/**/
def description(){'''
copies the content of /opt/deploy folder into DEPLOY_TARGET env var
during copy evaluates `*.gsp` files as groovy templates
in groovy templates all parameters defined in `conf/ *.properties` are available
PROP["the.property.name"] 
or
the.property.name

optional prameter:
	all     (default) copy all files
	gsp     copy only *.gsp files
	!gsp    copy only not *.gsp files
'''
}

def mode='all'
def defaultsHome = "/opt/.defaults/"
def confHome = new File("/opt/conf")
def deployHome = new File("/opt/deploy")
def deployTarget = new File(System.getenv("DEPLOY_TARGET"))


if(args.size()>0){
	mode = args[0]
}

assert mode in["all", "gsp", "!gsp"]
assert deployTarget.exists()

/*create ant*/
def ant = new AntBuilder()

//if conf of deploy are empty fill them from `.defaults`
def cpIfEmpty={dst,src->
	if(!dst.list().length){
		ant.copy(todir:dst){
			fileset(dir:src)
		}
	}
}

cpIfEmpty(deployHome, defaultsHome+"deploy")
cpIfEmpty(confHome, defaultsHome+"conf")

/*load properties*/
def config=[:]
config.putAll(System.getenv())
//config.putAll(System.getProperties())

if(confHome.exists()) {
    confHome.traverse(maxDepth:0, type: FileType.FILES, filter: {it.endsWith(".properties")}) {
        println "Read $it"
        config = evaluateProperties(it,config)
    }
}
/*convert properties to tree map. 'a.b=1' -> [a:[b:1]]*/
//Map tree = Installer.propsToTreeMap(config);

/*put configs into ant*/
ant.project.getProperties().putAll(config)

//define groovyeval ant filter
AntHelper.addGLoader(ant, "#GroovyLoader", this.getClass().getClassLoader())
ant.typedef(name:"groovyeval", classname:"GroovyEval", loaderref:"#GroovyLoader")

if(mode in ["all","gsp"]){
    //run copy with groovy templating with debug mode
    AntHelper.setLogLevel( ant, ant.project.MSG_INFO ) //.MSG_DEBUG
    ant.copy(flatten:false, encoding:"UTF-8", todir: targetDir, overwrite:true) {
        fileset(dir: templatesDir, includes: "**/*.gsp")
        filterchain(){
            groovyeval()
            //fixcrlf()
        }
    }
}

if(mode in ["all","!gsp"]){
    //run copy without groovy templating 
    AntHelper.setLogLevel( ant, ant.project.MSG_INFO ) //.MSG_DEBUG
    ant.copy(flatten:false, todir: targetDir, overwrite:true) {
        fileset(dir: templatesDir, excludes: "**/*.gsp")
    }
}

