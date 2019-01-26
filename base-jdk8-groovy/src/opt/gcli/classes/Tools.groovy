import java.util.zip.ZipFile;
import java.util.zip.ZipEntry;
import java.nio.file.Path;


@groovy.transform.CompileStatic
public class Tools {
	public static void unzip(File src, Path dst, boolean verbose=false){
		def zipFile = new ZipFile(src)
		zipFile.entries().each { ZipEntry entry->
			long lastModified = entry.getTime()
			if(lastModified==-1)lastModified=src.lastModified()
			def entryName = entry.getName().tr('\\','/')
			File dstUnzip = new File(dst.toFile(), entryName)
			if(entryName.endsWith('/')){
				dstUnzip.mkdirs()
			}else{
				if(verbose)println "     [entry] ${dstUnzip}"
				dstUnzip.getParentFile().mkdirs()
				dstUnzip.withOutputStream{ it << zipFile.getInputStream(entry) }
				dstUnzip.setLastModified( lastModified )
			}
		}
		zipFile.close()
	}
}
