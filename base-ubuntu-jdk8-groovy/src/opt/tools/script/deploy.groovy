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
def confHome     = new File(System.getenv("CONF_SOURCE") ?: "/opt/conf")
def deployHome   = new File(System.getenv("DEPLOY_SOURCE") ?: "/opt/deploy")
def deployTarget = System.getenv("DEPLOY_TARGET")


if(args.size()>0){
	mode = args[0]
}

assert mode in["all", "gsp", "!gsp"]
assert deployTarget
deployTarget=new File(deployTarget)
assert confHome.exists()
assert deployHome.exists()
assert deployTarget.exists()

/*create ant*/
def ant = new AntBuilder()

//if `dst` folder is empty then copy the content from `src` folder
def cpIfEmpty={dst,src->
	if(!dst.list().length){
		ant.copy(todir:dst){
			fileset(dir:src)
		}
	}
}
//copy default deploy and conf from .defaults if current folders are empty
AntHelper.setLogLevel( ant, ant.project.MSG_WARN )
cpIfEmpty(deployHome, defaultsHome+"deploy")
cpIfEmpty(confHome, defaultsHome+"conf")

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
confHome.traverse(maxDepth:0, type: FileType.FILES, filter: {it.name.length()>2}, sort:{a,b-> a.isFile() <=> b.isFile() ?: a.name <=> b.name } ) {cf->
	confParsers.each{confParser->
		if( !cf.name.startsWith(".") && cf.name.endsWith(confParser.key) ){
		    println "     [read] $cf"
			Map nextProps = confParser.value( cf )
			//merge and evaluate properties
			Configs.postEvaluate( nextProps, finalProps )
		}
	}
}
//set properties into ant project
ant.project.addReference("#GroovyEvalProps", finalProps)

//store all evaluated properties into json file (for debug purpose)
new File(confHome,".eval.json").setText( JsonOutput.prettyPrint(JsonOutput.toJson( finalProps )) , "UTF-8")

//define groovyeval ant filter
AntHelper.addGLoader(ant, "#GroovyLoader", this.getClass().getClassLoader())
ant.typedef(name:"groovyeval", classname:"GroovyEval", loaderref:"#GroovyLoader")


if(mode in ["all","gsp"]){
    //run copy with groovy templating with debug mode
    println "deploy *.gsp templates..."
    AntHelper.setLogLevel( ant, ant.project.MSG_VERBOSE ) //.MSG_INFO
    ant.copy(flatten:false, encoding:"UTF-8", todir: deployTarget, overwrite:true) {
        fileset(dir: deployHome, includes: "**/*.gsp")
        globmapper(from:"*.gsp", to:"*")
        filterchain(){
            groovyeval()
            //fixcrlf()
        }
    }
}

if(mode in ["all","!gsp"]){
    //run copy without groovy templating 
    println "deploy other files..."
    AntHelper.setLogLevel( ant, ant.project.MSG_INFO ) //.MSG_DEBUG
    ant.copy(flatten:false, todir: deployTarget, overwrite:true) {
        fileset(dir: deployHome, excludes: "**/*.gsp")
    }
}

