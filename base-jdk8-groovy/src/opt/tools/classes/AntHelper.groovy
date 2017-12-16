import org.apache.tools.ant.AntClassLoader;
import  org.apache.tools.ant.BuildLogger;
import org.apache.tools.ant.PropertyHelper;


@groovy.transform.CompileStatic
public class AntHelper {

	public static AntBuilder addGLoader(AntBuilder ant, String refid="#GroovyLoader", ClassLoader cl=AntHelper.class.getClassLoader()){
		AntClassLoader acl = new AntClassLoader(cl, ant.getProject(), null, true); //define ant classloader to use groovy as parent
		ant.getProject().addReference( refid, acl ) //register groovy based ant classloader
		return ant;
	}

    /* 4 - debug   ant.project.MSG_DEBUG  */
    /* 3 - verbose ant.project.MSG_VERBOSE */
    /* 2 - normal  ant.project.MSG_INFO */
	public static AntBuilder setLogLevel(AntBuilder ant, int level ){
		ant.getProject().getBuildListeners().each{ i->
			if(i instanceof BuildLogger){
				BuildLogger logger = (BuildLogger) i;
				logger.setMessageOutputLevel(level);
			}
		}
		return ant;
	}


}
