import org.apache.tools.ant.ProjectComponent;
import org.apache.tools.ant.filters.ChainableReader;

import groovy.json.JsonOutput;

@groovy.transform.CompileStatic
public class GroovyEval extends ProjectComponent implements ChainableReader {
	/*where to store evaluated json properties*/
    private String evalFile=null;
    public void setEvalFile(String evalFile){
        this.evalFile = evalFile
    }
    public String getEvalFile(){
        evalFile
    }


    public Reader chain(final Reader rdr) {
        Map bind = [:];

        //to throw esception on wrong access
        Map prop = new HashMap()
        prop.putAll(this.getProject().getProperties())
        System.getProperties().each{ prop.remove(it.key) } //remove system properties
        //remove ant properties
        prop.remove("ant")
        prop.remove("ant.core.lib")
        prop.remove("ant.java.version")
        prop.remove("ant.version")
        prop.remove("basedir")


        Map tree = Installer.propsToTreeMap(prop);
        if(evalFile){
        	new File(evalFile).setText( JsonOutput.prettyPrint(JsonOutput.toJson( tree )) , "UTF-8")
        }

        bind.putAll( tree );
        //------------------
        bind.PROJ = this.getProject();
        bind.PROP = prop;
        //bind.TREE = tree;
        //-------------------
        //def buffer = new StringWriter()
        //new groovy.text.GStringTemplateEngine().createTemplate(rdr).make( bind ).writeTo( buffer );
        def buffer = new ReaderTemplate(rdr).make(bind);
        return new StringReader( buffer.toString() );
    }
}
