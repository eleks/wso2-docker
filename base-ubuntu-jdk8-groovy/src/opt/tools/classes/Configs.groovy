/**/
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.yaml.snakeyaml.Yaml;
import groovy.text.TemplateEngine;
import groovy.text.GStringTemplateEngine;
import groovy.json.JsonSlurperClassic;

public class Configs{

   	/**load plain properties file*/
    public static Map parseProperties(def fileName){
        def file = toFile(fileName)
        def p = [:]
        file.eachLine("UTF-8"){line->
            if(!line.startsWith("#") || line.trim().length()==0){
                (line=~"([^=]+)=(.*)").with{matcher->
                    if(matcher.find()){
                        String key=matcher.group(1)
                        String val=matcher.group(2)
                        p.put(key,val)
                    }
                }
            }
        }
        return propsToTreeMap(p)
    }

    /** parses json file and returns plain map-array object. json must have a map as root element */
    public static Map parseJson(def fileName){
    	//load plain properties file 
        File file = toFile(fileName)
        return new JsonSlurperClassic().parse(file, "UTF-8");
    }

    /** parses yaml file and returns plain map-array object. yaml must have a map as root element */
    public static Map parseYaml(def fileName){
    	//load plain properties file 
        File file = toFile(fileName)
        return new Yaml().load(file.newReader("UTF-8"));
    }


    /**evaluates the values of `src` properties tree based on `root` and stores final result into the `root`*/
	public static void postEvaluate(Object src, Map root, Object target=root, Closure linkToParent = {it}, List jpath=[], TemplateEngine eng = new GStringTemplateEngine()){
        if(src instanceof Map){
            if(target==null){ target = linkToParent( [:] ) }
            assert target instanceof Map
            src.each{me->
                def linkToParentMap = { target.put(me.getKey(), it); it; }
                postEvaluate(me.getValue(), root, target[me.getKey()], linkToParentMap, jpath+[(jpath?".":"")+me.getKey()], eng)
            }
        }else if(src instanceof List){
            if(target==null){ target = linkToParent( [] ) }
            assert target instanceof List
            for(int i=0;i<src.size();i++){
                def linkToParentList = { target.add(it); it; }
                postEvaluate(src[i], root, null, linkToParentList, jpath+['['+i+']'], eng)
            }
        }else{
            if(src instanceof String){
            	try{
                	int p0=src.indexOf('${')
                	int p1=src.indexOf('}')
                	if(p0==0 && p1==src.length()-1 && src.indexOf('${',2)==-1){
                		//assume it's a groovy script inside brackets returning an object (string, map, array)
						src = new GroovyShell(new Binding(root)).evaluate(src.substring(2, p1))
						if(src!=null && !src instanceof Map && !src instanceof Collection){
							src=src.toString() //force to be string if not map and not array
						}
                	}else if(p0>=0 && p1>0){
                        src = eng.createTemplate(src).make(root).toString()
                    }
                }catch(Throwable t){
                	throw new Exception("Failed to evaluate `${jpath.join('')}`: "+t);
                }
            }
            linkToParent(src)
        }
	}


    private static Map propsToTreeMap(Map p){
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

    public static File toFile(Object o){
        if(o instanceof File)return (File)o;
        if(o instanceof String)return new File((String)o);
        if(o instanceof org.codehaus.groovy.runtime.GStringImpl)return new File((String)o);

        throw new RuntimeException("unsupporeted parameter: "+(o==null?"null":o.getClass().getName()));
    }

}
