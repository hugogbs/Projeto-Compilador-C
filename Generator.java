import java.io.File;
import java.nio.file.Paths;

public class Generator {

    public static void main(String[] args) {
      
      String rootPath = Paths.get("").toAbsolutePath(). toString();
      String subPath = "/";

      String file = rootPath + subPath + "c.lex";

      File sourceCode = new File(file);

      jflex.Main.generate(sourceCode);

    }
}
