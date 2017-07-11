/**/
import groovy.io.FileType

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
def deployTarget = System.getenv("DEPLOY_TARGET")


if(args.size()>0){
	mode = args[0]
}

assert mode in["all", "gsp", "!gsp"]
assert deployTarget
deployTarget=new File(deployTarget)
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
//copy default deploy and conf if empty
AntHelper.setLogLevel( ant, ant.project.MSG_WARN )
cpIfEmpty(deployHome, defaultsHome+"deploy")
cpIfEmpty(confHome, defaultsHome+"conf")

/*put environment vars with prefix `env.` into ant project properties*/
System.getenv().each{k,v-> ant.property(name:"env.$k",value:v) }

/*load&evaluate properties from files and put into ant project properties*/
if(confHome.exists()) {
    confHome.traverse(maxDepth:0, type: FileType.FILES, filter: {it.name.endsWith(".properties")}) {
        println "     [read] $it"
        Installer.evaluateProperties(it).each{k,v-> ant.property(name:k,value:v) }
    }
}

//define groovyeval ant filter
AntHelper.addGLoader(ant, "#GroovyLoader", this.getClass().getClassLoader())
ant.typedef(name:"groovyeval", classname:"GroovyEval", loaderref:"#GroovyLoader")

if(mode in ["all","gsp"]){
    //run copy with groovy templating with debug mode
    AntHelper.setLogLevel( ant, ant.project.MSG_DEBUG ) //.MSG_INFO
    ant.copy(flatten:false, encoding:"UTF-8", todir: deployTarget, overwrite:true) {
        fileset(dir: deployHome, includes: "**/*.gsp")
        globmapper(from:"*.gsp", to:"*")
        filterchain(){
            groovyeval(evalFile:"/opt/conf/eval.json")
            //fixcrlf()
        }
    }
}

if(mode in ["all","!gsp"]){
    //run copy without groovy templating 
    AntHelper.setLogLevel( ant, ant.project.MSG_INFO ) //.MSG_DEBUG
    ant.copy(flatten:false, todir: deployTarget, overwrite:true) {
        fileset(dir: deployHome, excludes: "**/*.gsp")
    }
}

