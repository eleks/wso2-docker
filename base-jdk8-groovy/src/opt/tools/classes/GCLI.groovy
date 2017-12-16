/**/


import org.codehaus.groovy.control.CompilerConfiguration;
import org.codehaus.groovy.runtime.StackTraceUtils;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

@groovy.transform.CompileStatic
public class GCLI{
	static String SCRIPT_PATH="./tools/script"
	static String CLASS_PATH="./tools/classes"
	static String PROP_PATH="./tools/tools.properties"
	
	String [] args
	Map<String,String> cmd2classname = [:]
	Map<String,String> scmd2cmd = [:]
	
	//Map<String,MetaScript> scripts = [:]
	GroovyShell shell;
	GroovyClassLoader loader;
	
	private static Pattern subjAndBody=Pattern.compile("(?m)^[\\s\$]*.*\\S.*\$[\\s\$]*");

	public static void main(String [] args){
		int err=0;
		try{
			//load common properties
			new File(PROP_PATH).with{
				if(it.exists()){
					Properties p = new Properties()
					p.load(it.newInputStream())
					System.getProperties().putAll(p)
				}
			}
			//load local properties defined by user
			new File("local.properties").with{
				if(it.exists()){
					Properties p = new Properties()
					p.load(it.newInputStream())
					//p.keySet().removeAll( System.getProperties().keySet() )
					System.getProperties().putAll(p)
				}else{
					//println "you can use `local.properties` "
				}
			}
			//get properties from args
			def sysProps = args.findAll{it.matches("^-D[^=]+=.*\$")}
			args = args-sysProps
			sysProps.each{p->
				(p =~ "-D([^=]+)=(.*)\$").each{List<String> kv->
					System.setProperty(kv[1],kv[2])
					//println "system option: ${kv[1]} = ${kv[2]}"
				}
			}
			//set some defaults
			if(!System.getProperty("grape.config"))System.setProperty("grape.config","./tools/grape.xml")
			if( System.getProperty("resolve.debug") ){
				//show grape downloads
				System.setProperty("groovy.grape.report.downloads","true")
				//show ivy debug info
				System.setProperty("ivy.message.logger.level",System.getProperty("resolve.debug"))
			}else{
				System.setProperty("ivy.message.logger.level","0")
			}
			
			def runner = new GCLI();
			runner.args=args;
			err = runner.run()
			if(err==0)System.out.print("\nOK\n")
		}catch(Throwable t){
			println "ERROR:"
			t = StackTraceUtils.deepSanitize(t)
			t.printStackTrace(System.out)
			err=1;
			Thread.sleep(3000);
		}
		Thread.sleep(789)
		if(System.getProperty("gcli.pause") as Boolean){
			println "\npress enter to continue..."
			System.in.read()
		}
		if(err)System.exit(1)
	}
	
	void runScript(String cmd, List<String> args=[]){
		cmd = scmd2cmd.get(cmd)?:cmd
		String scriptClassName = cmd2classname.get( cmd )
		assert scriptClassName : "script not found command: `${cmd}`"
		println "[${cmd}] ${args?:''}" 
		Script script = (Script)(loader.loadClass(scriptClassName).newInstance());
		script.setBinding(new Binding(
			args: args,
			cli: this,
		))
		script.run()
	}
	
	int run(){
		def cc = new CompilerConfiguration()
		cc.setClasspathList([SCRIPT_PATH,CLASS_PATH])
		cc.setScriptBaseClass( MetaScript.class.getName() )
		this.shell = new GroovyShell(this.getClass().getClassLoader(),new Binding(),cc);
		this.loader = shell.getClassLoader()
		//COLLECT SCRIPT NAMES
		new File(SCRIPT_PATH).eachFile{File script->
			String name=script.getName()
			if(name.endsWith(".groovy")){
				name=name.replaceAll("\\..*","")
				def cmd = toCommand(name)
				if(!cmd2classname[cmd]) cmd2classname.put( cmd, name )
			}
		}
		cmd2classname = cmd2classname.sort()
		//fill short names
		for (Map.Entry<String,String>e in cmd2classname.entrySet()) {
			def scmd = toSCommand(e.value)
			if(!scmd2cmd[scmd])scmd2cmd.put(scmd,e.key);
		}
		
		if(!args){
			showHelp(null)
		}else if(args[0]=="help" && args.size()==1){
			showHelp("help")
		}else if(args[0]=="help" && args.size()>1){
			showHelp(args[1])
		}else{
			if( cmd2classname.containsKey( scmd2cmd.get(args[0])?:args[0] ) ){
				//println "gcli loaded"
				runScript( args[0], Arrays.asList(args.drop(1)) )
			}else{
				println "wrong command: `${args[0]}`"
				showHelp(null)
				return 1; /*err*/
			}
		}
		return 0; /*no err*/
	}
	private Map<String,MetaScript> loadAllScripts(){
		Map<String,MetaScript> cmd2class = [:]
		for(Map.Entry<String,String>e in cmd2classname.entrySet()){
			def c = loader.loadClass(e.value)
		}
		for(Class c in loader.getLoadedClasses()){
			if( MetaScript.class. isAssignableFrom(c) ){
				MetaScript script = (MetaScript)c.newInstance()
				if(script.description()!=null){
					cmd2class.put(toCommand(c.getName()),script);
				}
			}
		}
		cmd2class=cmd2class.sort()
		return cmd2class;
	}
	
	
	private void showHelp(String cmd){
		Map<String,MetaScript> cmd2class=loadAllScripts()
		if(!cmd || cmd=="help"){
			println "usage: ${this.getClass().getName()} [system-options] <command> [args]"
			println ""
			println "to get help use:"
			println "  ${this.getClass().getName()} help [command]"
			if(cmd=="help"){
				println ""
				println "system-options:"
				println "   could be specified in the local.properties file "
				println "   or in command line before command with syntax: -Dname=value"
				println ""
				println "   gcli.pause                [true|false] if you need to pause after run"
				println "   resolve.debug             debug level 1-4 for repository resolve actions"
				println "   resolve.level             the repository resolve level [integration|milestone|release]"
				println "   ivy.cache.default.root    path to the cache of ivy repository"
				println "   ivy.local.default.root    path to the local ivy repository"
				
				println ""
				println "available commands:"
				int keysMaxLen = cmd2class.max{ it.key.length() }.key.length()
				Map<String,String> cmd2scmd = (Map<String,String>)scmd2cmd.collectEntries{Map.Entry<String,String> e-> [e.value,e.key] } //revert map
				for(Map.Entry<String,MetaScript>e in cmd2class.entrySet()){
					String scmd = cmd2scmd.get( e.key ) //length 3
					scmd = scmd? "("+scmd+")" : ""
					println String.format("   %-${keysMaxLen+3}s %-6s  %s",e.key, scmd, getSubject(e.value.description().toString()))
				}
			}
		}else{
			cmd = scmd2cmd.get(cmd)?:cmd
			if(cmd2class.containsKey(cmd)){
				MetaScript script = cmd2class[cmd];
				println script.description().toString().trim()
			}else{
				println "wrong command: `${cmd}`"
				showHelp(null)
			}
		}
	}
	
	
	
	String toCommand(String name){
		return name.toLowerCase().tr("_","-")
	}
	
	String toSCommand(String name){
		StringBuilder s=new StringBuilder(name.length());
		name.each{String c->
			if(c.charAt(0).isUpperCase() || c.charAt(0).isDigit()){
				s.append( c.toLowerCase() )
			}
		}
		if(s.size()==0)return null;
		if(s.size()>3)s.setLength(3)
		return s.toString()
	}
	
	public static abstract class MetaScript extends Script{
		Object description(){null};
	}
	
	//returns first non empty line from input string
	public static String getSubject(String s){
		if(s==null)return null;
		Matcher m=subjAndBody.matcher(s);
		if(m.find())return m.group().trim();
		return s;
	}

	//returns everything except first non empty line
	public static String getBody(String s){
		if(s==null)return null;
		return subjAndBody.matcher(s).replaceFirst("");
	}
}


