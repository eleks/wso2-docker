/**/
import groovy.io.FileType
import groovy.json.JsonOutput

def description(){'''
loads in alphabetical order and evaluates configuration files (*.yaml, *.json, *.properties) from `CONF_SOURCE` env var
copies the content of `DEPLOY_SOURCE` folder into `DEPLOY_TARGET`
during copy evaluates `*.gsp` files as groovy templates
in groovy templates all the configuration parameters are available as:
the.property.name

optional prameter:
	all     (default) copy all files
	gsp     copy only *.gsp files
	!gsp    copy only not *.gsp files
'''
}

def mode='all'

def defaultsHome = "/opt/.defaults/"
def confSource     = System.getenv("CONF_SOURCE") ?: "/opt/conf"       //could be a list separated with : or ;
def deploySource   = System.getenv("DEPLOY_SOURCE") ?: "/opt/deploy"   //could be a list separated with : or ;
def deployTarget   = System.getenv("DEPLOY_TARGET")


if(args.size()>0){
	mode = args[0]
}

assert mode in["all", "gsp", "!gsp"]
assert deployTarget : "env var DEPLOY_TARGET must be defined"
deployTarget=new File(deployTarget)
assert deployTarget.exists()

//convert sources to lists of files
confSource   = confSource.split('[;:]').findAll().collect{new File(it).getCanonicalFile()}
deploySource = deploySource.split('[;:]').findAll().collect{new File(it).getCanonicalFile()}

assert confSource.size()>0
assert deploySource.size()>0

/*create ant builder*/
def ant = new AntBuilder()

//if `dst` folder is empty then copy the content from `src` folder
def cpIfEmpty={dst,src->
	assert dst.exists():"folder does not exist: $dst"
	if(!dst.list().length){
		ant.copy(todir:dst){
			fileset(dir:src)
		}
	}
}
//validate that deploySource does not contain nested paths
deploySource.
	collectEntries{x-> [x,deploySource.find{y-> x!=y && y.toPath().startsWith( x.toPath() ) }] }.
	each{path,subpath->
		assert subpath==null:"The path and subpath can't be in DEPLOY_SOURCE paths list\n     `$path` includes\n     `$subpath`"
	}


//copy default deploy and conf from .defaults if current (last) folders are empty
AntHelper.setLogLevel( ant, ant.project.MSG_WARN )
cpIfEmpty(confSource[-1], defaultsHome+"conf")
cpIfEmpty(deploySource[-1], defaultsHome+"deploy")

/*load&evaluate properties from files */
def finalProps = [:]

//add system envs into properties
finalProps.env = System.getenv()

/*load&evaluate properties from files */
def confParsers=[
	".properties": Configs.&parseProperties,
	".yaml"      : Configs.&parseYaml,
	".json"      : Configs.&parseJson,
]
//let's got through CONF_SOURCE folders and parse configs in each
confSource.each{confItem->
	println "  [CONF_SOURCE] $confItem"
	assert confItem.exists(): "the path in CONF_SOURCE does not exist: $confItem"
	confItem.traverse(maxDepth:0, type: FileType.FILES, filter: {it.name.length()>2}, sort:{a,b-> a.isFile() <=> b.isFile() ?: a.name <=> b.name } ) {cf->
		confParsers.each{confParser->
			if( !cf.name.startsWith(".") && cf.name.endsWith(confParser.key) ){
				println "     [read] ${cf.name}"
				Map nextProps = confParser.value( cf )
				//merge and evaluate properties
				Configs.postEvaluate( nextProps, finalProps )
			}
		}
	}
}
//store the last evaluated config into the last CONF_SOURCE folder in json format  (for debug purpose)
new File(confSource[-1],".eval.json").setText( JsonOutput.prettyPrint(JsonOutput.toJson( finalProps )) , "UTF-8")

//set properties into ant project
ant.project.addReference("#GroovyEvalProps", finalProps)
//define groovyeval ant filter to be used in copy of *.gsp files
AntHelper.addGLoader(ant, "#GroovyLoader", this.getClass().getClassLoader())
ant.typedef(name:"groovyeval", classname:"GroovyEval", loaderref:"#GroovyLoader")

deploySource.each{deployItem->
	println "  [DEPLOY_SOURCE] $deployItem"
	assert deployItem.exists(): "the path in DEPLOY_SOURCE does not exist: $deployItem"
	if(mode in ["all","gsp"]){
		//run copy with groovy templating with debug mode to see where the error occured
		println "     copy *.gsp templates..."
		AntHelper.setLogLevel( ant, ant.project.MSG_VERBOSE ) //.MSG_INFO
		ant.copy(flatten:false, encoding:"UTF-8", todir: deployTarget, overwrite:true) {
			fileset(dir: deployItem, includes: "**/*.gsp")
			globmapper(from:"*.gsp", to:"*")
			filterchain(){
				groovyeval()
				//fixcrlf()
			}
		}
	}

	if(mode in ["all","!gsp"]){
		//run copy without groovy templating 
		println "     copy other files..."
		AntHelper.setLogLevel( ant, ant.project.MSG_INFO ) //.MSG_DEBUG
		ant.copy(flatten:false, todir: deployTarget, overwrite:true) {
			fileset(dir: deployItem, excludes: "**/*.gsp")
		}
	}
}

