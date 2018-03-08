package compiler.generated;
import java_cup.runtime.*;
import compiler.core.*;
import java_cup.runtime.ComplexSymbolFactory.ComplexSymbol;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.Symbol;
%%

%public
%class Scanner
%unicode
%line
%column
%cup
%cupdebug

%{
   StringBuffer string = new StringBuffer();

   private ComplexSymbolFactory symbolFactory = new ComplexSymbolFactory();

   private Symbol symbol(int sym) {
         return symbolFactory.newSymbol("sym", sym, new Location(yyline+1,yycolumn+1), new Location(yyline+1,yycolumn+yylength()));
     }
     private Symbol symbol(int sym, Object val) {
         Location left = new Location(yyline+1,yycolumn+1);
         Location right= new Location(yyline+1,yycolumn+yylength());
         return symbolFactory.newSymbol("sym", sym, left, right,val);
     }
     private Symbol symbol(int sym, Object val,int buflength) {
         Location left = new Location(yyline+1,yycolumn+yylength()-buflength);
         Location right= new Location(yyline+1,yycolumn+yylength());
         return symbolFactory.newSymbol("sym", sym, left, right,val);
     }

  /*private Symbol symbol(int type) {
	return new JavaSymbol(type, yyline+1, yycolumn+1);
  }

  private Symbol symbol(int type, Object value) {
	return new JavaSymbol(type, yyline+1, yycolumn+1, value);
  } */

  private long parseLong(int start, int end, int radix) {
	long result = 0;
	long digit;

	for (int i = start; i < end; i++) {
	  digit  = Character.digit(yycharat(i),radix);
	  result*= radix;
	  result+= digit;
	}

	return result;
  }
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
Identifier     = [A-Za-z_][A-Za-z_0-9]*
Integer        = "-"?[0-9]+
Float          = "-"?[0-9]+"."[0-9]+
Comments = {LineComment} | {BlockComment}
LineComment = "//" {InputCharacter}* {LineTerminator}?
BlockComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"

WhiteSpace     = {LineTerminator} | [ \t\f  ]

Printable      = [ -~]

Any            = [^] | \n

%%

<YYINITIAL> {

  /* Keywords */
  "auto"        { return symbol(sym.AUTO); }
  "double"      {return symbol(sym.DOUBLE); }
  "int" {return symbol(sym.INT); }
  "struct" {return symbol(sym.STRUCT); }
  "const" {return symbol(sym.CONST); }
  "float" {return symbol(sym.FLOAT); }
  "short" {return symbol(sym.SHORT); }
  "unsigned" {return symbol(sym.UNSIGNED); }
  "break" {return symbol(sym.BREAK); }
  "else" {return symbol(sym.ELSE); }
  "long" {return symbol(sym.LONG); }
  "switch" {return symbol(sym.SWITCH); }
  "continue" {return symbol(sym.CONTINUE); }
  "for" {return symbol(sym.FOR); }
  "signed" {return symbol(sym.SIGNED); }
  "void" {return symbol(sym.VOID); }
  "case" {return symbol(sym.CASE); }
  "enum" {return symbol(sym.ENUM); }
  "register" {return symbol(sym.REGISTER); }
  "typedef" {return symbol(sym.TYPEDEF); }
  "default" {return symbol(sym.DEFAULT); }
  "goto" {return symbol(sym.GOTO); }
  "sizeof" {return symbol(sym.SIZEOF); }
  "volatile" {return symbol(sym.VOLATILE); }
  "char" {return symbol(sym.CHAR); }
  "extern" {return symbol(sym.EXTERN); }
  "return" {return symbol(sym.RETURN); }
  "union" {return symbol(sym.UNION); }
  "do" {return symbol(sym.DO); }
  "if" {return symbol(sym.IF); }
  "static" {return symbol(sym.STATIC); }
  "while" {return symbol(sym.WHILE); }
  "inline" {return symbol(sym.INLINE); }
  "restrict" {return symbol(sym.RESTRICT); }

  "_Alignas" {return symbol(sym.ALIGNAS); }
  "_Alignof" {return symbol(sym.ALIGNOF); }
  "_Atomic" {return symbol(sym.ATOMIC); }
  "_Bool" {return symbol(sym.BOOL); }
  "_Complex" {return symbol(sym.COMPLEX); }
  "_Generic" {return symbol(sym.GENERIC); }
  "_Imaginary" {return symbol(sym.IMAGINARY); }
  "_Noreturn" {return symbol(sym.NORETURN); }
  "_Static_assert" {return symbol(sym.STATIC_ASSERT); }
  "_Thread_local" {return symbol(sym.THREAD_LOCAL); }
  "__func__" {return symbol(sym.FUNC_NAME); }

  /* Whitespace */
  {WhiteSpace} { /**/ }

  /* Comments */
  {Comments} { /**/ }

  /* Identifiers */
  {Identifier} { return symbol(sym.IDENTIFIER, yytext()); }

  /* Integer */
  {Integer} {return symbol(sym.I_CONSTANT, yytext()); }

  /* Float */
  {Float} {return symbol(sym.F_CONSTANT, yytext()); }

  /* String */
  \"([^\\\"]|\\.)*\" {return symbol(sym.STRING_LITERAL, yytext()); }
  /* Char */
  /*\'([^\\\"]|\\.)*\' {return symbol(CHAR,yytext()); }*/

  /* Separators */
  "(" {return symbol(sym.LPAREN); }
  ")" {return symbol(sym.RPAREN); }
  ("{"|"<%") {return symbol(sym.LKEY); }
  ("}"|"%>") {return symbol(sym.RKEY); }
  ("["|"<:") {return symbol(sym.LBRA); }
  ("]"|":>") {return symbol(sym.RBRA); }

  /* Operators */
  "," {return symbol(sym.COMMA); }
  ";" {return symbol(sym.SEMICOLON); }
  "+" {return symbol(sym.PLUS); }
  "-" {return symbol(sym.MINUS); }
  "*" {return symbol(sym.STAR); }
  "/" {return symbol(sym.BAR); }
  "%" {return symbol(sym.PERC); }
  "!" {return symbol(sym.EXCLA); }
  "&&" {return symbol(sym.AND_OP); }
  "||" {return symbol(sym.OR_OP); }
  "==" {return symbol(sym.EQ_OP); }
  "!=" {return symbol(sym.NE_OP); }
  "<=" {return symbol(sym.LE_OP); }
  "<" {return symbol(sym.LT); }
  ">=" {return symbol(sym.GE_OP); }
  ">" {return symbol(sym.GT); }
  "=" {return symbol(sym.EQUALS); }
  "-=" {return symbol(sym.SUB_ASSIGN); }
  "+=" {return symbol(sym.ADD_ASSIGN); }
  "*=" {return symbol(sym.MUL_ASSIGN); }
  "/=" {return symbol(sym.DIV_ASSIGN); }
  "%=" {return symbol(sym.MOD_ASSIGN); }
  "&=" {return symbol(sym.AND_ASSIGN); }
  "^=" {return symbol(sym.XOR_ASSIGN); }
  "&" {return symbol(sym.AND); }
  "|" {return symbol(sym.PIPE); }
  "~" {return symbol(sym.TIL); }
  "^" {return symbol(sym.CARET); }
  "<<" {return symbol(sym.LEFT_OP); }
  ">>" {return symbol(sym.RIGHT_OP); }
  "++" {return symbol(sym.INC_OP); }
  "--" {return symbol(sym.DEC_OP); }
  "..." {return symbol(sym.ELLIPSIS); }
  ">>=" {return symbol(sym.RIGHT_ASSIGN); }
  "<<=" {return symbol(sym.LEFT_ASSIGN); }
  "|=" {return symbol(sym.OR_ASSIGN); }
  "->" {return symbol(sym.PTR_OP); }
  ":" {return symbol(sym.DDOT); }
  "." {return symbol(sym.DOT); }
  "?" {return symbol(sym.INTER); }

  [^]|\n			{ throw new RuntimeException("Caractere inválido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }
}
