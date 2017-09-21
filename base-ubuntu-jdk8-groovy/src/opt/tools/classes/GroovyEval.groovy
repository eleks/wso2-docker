import org.apache.tools.ant.ProjectComponent;
import org.apache.tools.ant.filters.ChainableReader;

import groovy.json.JsonOutput;

@groovy.transform.CompileStatic
public class GroovyEval extends ProjectComponent implements ChainableReader {


    public Reader chain(final Reader rdr) {
        Map bind = (Map)this.getProject().getReference("#GroovyEvalProps") ?: [:];

        //bind.TREE = tree;
        //-------------------
        //def buffer = new StringWriter()
        //new groovy.text.GStringTemplateEngine().createTemplate(rdr).make( bind ).writeTo( buffer );
        def buffer = new ReaderTemplate(rdr).make(bind);
        return new StringReader( buffer.toString() );
    }
}
