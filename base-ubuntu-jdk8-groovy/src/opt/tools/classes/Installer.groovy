/**/
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Installer{
    public static Map propsToTreeMap(Map p){
        Map root=new java.util.concurrent.ConcurrentSkipListMap();
        p.each{
            String [] keys=it.key.split('\\.')
            Map cur=root;
            for(int i=0;i<keys.length-1;i++) {
                if( !cur.containsKey(keys[i]) || !(cur[keys[i]] instanceof Map) ){
                    //if(cur.containsKey(keys[i]))System.err.println("    WARN: skip ${it.key}=${cur[keys[i]]}")
                    cur[keys[i]] = new java.util.concurrent.ConcurrentSkipListMap();
                }
                cur = cur[keys[i]];
            }
            if( cur.containsKey(keys[keys.length-1]) && cur[keys[keys.length-1]] instanceof Map ){
                System.err.println("    WARN: skip $it")
            }else{
                cur[keys[keys.length-1]]=it.value;
            }
        }
        return root;
    }

    /*scans file and returns evaluated properties map*/
    public static Map evaluateProperties(String fileName, Map map=[:]){
        def file = new File(fileName)
        def eng = new groovy.text.GStringTemplateEngine();
        map = [:]+map; //make a copy
        file.eachLine("UTF-8"){line->
            if(!line.startsWith("#") || line.trim().length()==0){
                (line=~"([^=]+)=(.*)").with{matcher->
                    if(matcher.find()){
                        String key=matcher.group(1)
                        String val=matcher.group(2)
                        if(val.indexOf('${')>=0 && val.indexOf('}')>=0){
                            val = eng.createTemplate(val).make(map).toString()
                        }
                        map.put(key,val)
                    }
                }
            }
        }

        return map;
    }

    public static File toFile(Object o){
        if(o instanceof File)return (File)o;
        if(o instanceof String)return new File((String)o);
        if(o instanceof org.codehaus.groovy.runtime.GStringImpl)return new File((String)o);

        throw new RuntimeException("unsupporeted parameter: "+(o==null?"null":o.getClass().getName()));
    }

    public static Map getProperties(File file) {
        Properties properties = new Properties()
        file.withInputStream {
            properties.load(it)
        }
        properties
    }
}
