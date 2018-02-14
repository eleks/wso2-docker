import java.util.zip.ZipFile;
import java.util.zip.ZipEntry;
import java.nio.file.Path;


@groovy.transform.CompileStatic
public class Tools {
	public static void unzip(File src, Path dst, boolean verbose=false){
		def zipFile = new ZipFile(src)
		zipFile.entries().each { ZipEntry entry->
			Path dstUnzip = dst.resolve(entry.getName())
			if(entry.isDirectory()){
				dstUnzip.toFile().mkdirs()
			}else{
				if(verbose)println "     [entry] ${dstUnzip}"
				dstUnzip.toFile().withOutputStream{ it << zipFile.getInputStream(entry) }
			}
		}
		zipFile.close()
	}
}
