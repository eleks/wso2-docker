import org.apache.tools.ant.ProjectComponent;
import org.apache.tools.ant.filters.ChainableReader;

import groovy.json.JsonOutput;

@groovy.transform.CompileStatic
public class GroovyEval extends ProjectComponent implements ChainableReader {

    public Reader chain(final Reader rdr) {
        def buffer = new StringWriter()
        Map bind = [:];

        //to throw esception on wrong access
        Map prop = new HashMap()
        prop.putAll(this.getProject().getProperties()-System.getProperties())

        Map tree = Installer.propsToTreeMap(prop);

        bind.putAll( tree );
        //------------------
        bind.PROJ = this.getProject();
        bind.PROP = prop;
        //bind.TREE = tree;
        //-------------------
        new groovy.text.GStringTemplateEngine().createTemplate(rdr).make( bind ).writeTo( buffer );
        return new StringReader( buffer.toString() );
    }
}
