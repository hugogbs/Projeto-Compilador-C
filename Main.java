import java.io.File;
import java.io.Reader;
import java_cup.parser;
import java.io.FileReader;
import java.nio.file.Paths;

import java_cup.runtime.Symbol;
// import syntaxtree.*;
// import visitor.*;
import java.io.*;
import java.util.*;

import java_cup.parser;

// public class Main {
//
//     public static void main(String[] args) {
//
//         String rootPath = Paths.get("").toAbsolutePath().toString();
//         String subPath = "/";
//
//         String sourcecode = rootPath + subPath + "program.c";
//
//
//         try {
//             Parser p = new Parser(new LexicalAnalyzer(new FileReader(sourcecode)));
//             Object result = p.parse().value;
//
//             System.out.println("Compilacao concluida com sucesso...");
//         } catch (Exception e) {
//             e.printStackTrace();
//         }
//     }
// }


  public class Main {
    	public static void main(String[] args) 	{
      		if(args.length != 1) {
        			System.out.println("ERROR: Invalid number of command line arguments.");
        			System.out.println("USAGE: java Main file.txt");
        			System.exit(1);
      		}
      		try {
        			Symbol sy;
        			Program collect;
        			Parser parser = new Parser(new LexicalAnalyzer(new FileInputStream(args[0])));
        			sy = parser.parse();
      		}	catch (IOException e)	{
      			   System.err.println("ERROR: Unable to open file: " + args[0]);
      		}	catch (Exception e) {
      			   e.printStackTrace(System.err);
      		}
    	}
  }
