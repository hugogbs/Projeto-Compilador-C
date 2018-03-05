import java.io.File;
import java.io.Reader;
import java_cup.parser;
import java.io.FileReader;
import java.nio.file.Paths;

import java_cup.parser;

public class Main {

    public static void main(String[] args) {

        String rootPath = Paths.get("").toAbsolutePath().toString();
        String subPath = "/";

        String sourcecode = rootPath + subPath + "program.c";


        try {
            Parser p = new Parser(new LexicalAnalyzer(new FileReader(sourcecode)));
            Object result = p.parse().value;

            System.out.println("Compilacao concluida com sucesso...");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
