/**/
import groovy.io.FileType
import groovy.json.JsonOutput
import java.nio.file.Path
import groovy.io.FileVisitResult

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
confSource   = confSource.split('[;:]').findAll().collect{new File(it.trim()).getCanonicalFile()}
deploySource = deploySource.split('[;:]').findAll().collect{new File(it.trim()).getCanonicalFile()}

assert confSource.size()>0
assert deploySource.size()>0


//if `dst` folder is empty then copy the content from `src` folder
def cpIfEmpty={dst,src->
	assert dst.exists():"folder does not exist: $dst"
	src = new File(src)
	if(!dst.list().length){
		src.traverse(maxDepth: -1, type: FileType.ANY) {srcFile->
			def rel = src.toPath().relativize(srcFile.toPath())
			def dstPath = dst.toPath().resolve(rel)
			if(srcFile.isDirectory()){
				dstPath.toFile().mkdirs()
			}else{
				dstPath.toFile().withOutputStream{ it << srcFile.newInputStream() }
			}
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
cpIfEmpty(confSource[-1], defaultsHome+"conf")
cpIfEmpty(deploySource[-1], defaultsHome+"deploy")

/*load&evaluate properties from files */
def finalProps = [:]

//add system envs into properties
finalProps.env = [:]+System.getenv()

/*load&evaluate properties from files */
def confParsers=[
	".properties": Configs.&parseProperties,
	".yaml"      : Configs.&parseYaml,
	".json"      : Configs.&parseJson,
]
//let's go through CONF_SOURCE folders and parse configs in each
confSource.each{confItem->
	println "  [CONF_SOURCE] $confItem"
	assert confItem.exists(): "the path in CONF_SOURCE does not exist: $confItem"
	confItem.traverse(maxDepth:0, type: FileType.FILES, filter: {it.name.length()>2}, sort:{a,b-> a.isFile() <=> b.isFile() ?: a.name <=> b.name } ) {cf->
		confParsers.each{confParser->
			if( !cf.name.startsWith(".") && cf.name.endsWith(confParser.key) ){
				println "     [read]  ${cf.name}"
				Map nextProps = confParser.value( cf )
				//merge and evaluate properties
				Configs.postEvaluate( nextProps, finalProps )
			}
		}
	}
}
//store the last evaluated config into the last CONF_SOURCE folder in json format  (for debug purpose)
new File("/opt/.eval.json").setText( JsonOutput.prettyPrint(JsonOutput.toJson( finalProps )) , "UTF-8")

def context=[:]  //deploy context

def renderFunction={file, binding=null-> 
	if(file==null)return ""
	if(!file instanceof String)file=file.toString()
	File tpl=null;
	if(file.startsWith("/") || file.startsWith("\\")){
		//let's lookup template file in this or previous directories
		tpl = deploySource.reverse().dropWhile{it!=context.sourcePath}.collect{ new File(it,file) }.find{it.exists()}
	}else{
		tpl = new File(context.sourceFile.getParentFile(), file)
	}
	if(tpl==null || !tpl.exists()){
		throw new Exception("Resource not found: ${tpl ?: file}")
	}
	return new ReaderTemplate(tpl.newReader("UTF-8")).make(binding?:finalProps + [context:context]).toString()
}

def skipExt = ".gspx"
deploySource.each{deployItem->
	println "  [DEPLOY_SOURCE] $deployItem"
	assert deployItem.exists(): "the path in DEPLOY_SOURCE does not exist: $deployItem"
	if(mode in ["all","gsp"]){
		deployItem.traverse(
			maxDepth: -1, 
			type:     FileType.ANY, 
			filter:   {it.isDirectory() || it.isFile()}, 
			preDir:   {it.getName().endsWith(skipExt) ? FileVisitResult.SKIP_SUBTREE : FileVisitResult.CONTINUE}, 
			sort:     {a,b-> a.isFile() <=> b.isFile() ?: a.name <=> b.name },
		) {src->
			def rel = deployItem.toPath().relativize(src.toPath())
			def dst = deployTarget.toPath().resolve(rel)
			if(src.isDirectory()){
				if(src.getName().endsWith(skipExt))	{
					//println "     [skip]  $src"
				}else{
					println "     [dir]   $dst"
					dst.toFile().mkdirs()
				}
			}else if(src.getName().endsWith(skipExt)){
				//just eXclude gspx files from copying
			}else if(src.getName().endsWith(".gsp") && mode in ["all","gsp"]){
				//remove .gsp from target name
		        dst = dst.getParent().resolve( dst.getFileName().toString()[0..-5] ).toFile()
				println "     [gsp]   ${dst}"
				context = [
						file:dst,
						sourcePath: deployItem,
						sourceFile: src,
						render: renderFunction,
					].asImmutable()
				dst.withOutputStream{outStream->
					PrintStream printer = new PrintStream(outStream, true, "UTF-8");
					new ReaderTemplate(src.newReader("UTF-8")).make(finalProps+[out:printer, context:context]);
					printer.flush(); //just to be sure )
				}
			}else if(mode in ["all","!gsp"]){
				if(src.getName().endsWith(".unzip")){
					println "     [unzip] ${src.getName()} > ${dst}"
					def zipFile = new java.util.zip.ZipFile(src)
					zipFile.entries().each { entry->
						println "     [unzi-] ${entry.getName()}"
						dstUnzip = dst.getParent().resolve(entry.getName())
						if(entry.isDirectory()){
							dstUnzip.toFile().mkdirs()
						}else{
							println "     [unzip] ${dstUnzip}"
							dstUnzip.toFile().withOutputStream{ it << zipFile.getInputStream(entry) }
						}
					}
					zipFile.close()
				}else{
					println "     [copy]  ${dst}"
					dst.toFile().withOutputStream{ it << src.newInputStream() }
				}
			}
		}
	}
}

