import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Paths;


public class CLexicalAnalyzer {

    public static void main(String[] args) throws IOException {

        String rootPath = Paths.get("").toAbsolutePath(). toString();
        String subPath = "/";

        String sourceCode = rootPath + subPath + "/program.c";

        LexicalAnalyzer lexical = new LexicalAnalyzer(new FileReader(sourceCode));

        CToken token;

        while ((token = lexical.yylex()) != null) {
            System.out.println("<" + token.name + ", " + token.value + "> (" + token.line + " - " + token.column + ")");
        }
    }
}
