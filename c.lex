import java_cup.runtime.*;
import java_cup.runtime.Symbol;


%%

/*%{

private Symbol check_type() {
  switch (yytext)
  {
  case TYPEDEF_NAME:
      return new Symbol(Sym.TYPEDEF_NAME);
  case ENUMERATION_CONSTANT:
      return new Symbol(Sym.ENUMERATION_CONSTANT);
  default:
      return new Symbol(Sym.IDENTIFIER);
  }
}

private CToken createToken(String name, String value) {
    return new CToken( name, value, yyline, yycolumn);
}

%}*/

%public
%class LexicalAnalyzer
//%type CToken
%line
%column
%cup
%type java_cup.runtime.Symbol

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
/*Keyword        = auto|double|int|struct|const|float|short|unsigned|break|else|long|switch|continue|for|signed|void|case|enum|register|typedef|default|goto|sizeof|volatile|char|extern|return|union|do|if|static|while*/
Identifier     = [A-Za-z_][A-Za-z_0-9]*
Integer        = "-"?[0-9]+
Float          = "-"?[0-9]+"."[0-9]+
/*Octal          = "-"?0[0-9]+*/
/*Hexadecimal    = "-"?0x[0-9]+*/

/*Separator      = "("|")"|"{"|"}"|"["|"]"|","|";"*/
/*Operator       = "+"|"-"|"*"|"/"|"%"|"!"|"&&"|"||"|"=="|"!="|"<="|"<"|">="|">"|"="|"+="|"-="|"*="|"/="|"%="|"&="|"^="|"&"|"|"|"~"|"^"|"<<"|">>"|"++"|"--"*/

Comments = {LineComment} | {BlockComment}
LineComment = "//" {InputCharacter}* {LineTerminator}?
BlockComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"

WhiteSpace     = {LineTerminator} | [ \t\f  ]

Printable      = [ -~]

Any            = . | \n

/*program = "program"*/

/*%{
#include <stdio.h>
#include "y.tab.h"

extern void yyerror(const char *);

extern int sym_type(const char *);

#define sym_type(identifier) IDENTIFIER

static void comment(void);
static int check_type(void);
%}*/

%%

<YYINITIAL> {
  "auto" { return new Symbol(Sym.AUTO); }
  "double" {return new Symbol(Sym.DOUBLE); }
  "int" {return new Symbol(Sym.INT); }
  "struct" {return new Symbol(Sym.STRUCT); }
  "const" {return new Symbol(Sym.CONST); }
  "float" {return new Symbol(Sym.FLOAT); }
  "short" {return new Symbol(Sym.SHORT); }
  "unsigned" {return new Symbol(Sym.UNSIGNED); }
  "break" {return new Symbol(Sym.BREAK); }
  "else" {return new Symbol(Sym.ELSE); }
  "long" {return new Symbol(Sym.LONG); }
  "switch" {return new Symbol(Sym.SWITCH); }
  "continue" {return new Symbol(Sym.CONTINUE); }
  "for" {return new Symbol(Sym.FOR); }
  "signed" {return new Symbol(Sym.SIGNED); }
  "void" {return new Symbol(Sym.VOID); }
  "case" {return new Symbol(Sym.CASE); }
  "enum" {return new Symbol(Sym.ENUM); }
  "register" {return new Symbol(Sym.REGISTER); }
  "typedef" {return new Symbol(Sym.TYPEDEF); }
  "default" {return new Symbol(Sym.DEFAULT); }
  "goto" {return new Symbol(Sym.GOTO); }
  "sizeof" {return new Symbol(Sym.SIZEOF); }
  "volatile" {return new Symbol(Sym.VOLATILE); }
  "char" {return new Symbol(Sym.CHAR); }
  "extern" {return new Symbol(Sym.EXTERN); }
  "return" {return new Symbol(Sym.RETURN); }
  "union" {return new Symbol(Sym.UNION); }
  "do" {return new Symbol(Sym.DO); }
  "if" {return new Symbol(Sym.IF); }
  "static" {return new Symbol(Sym.STATIC); }
  "while" {return new Symbol(Sym.WHILE); }
  "inline" {return new Symbol(Sym.INLINE); }
  "restrict" {return new Symbol(Sym.RESTRICT); }

  "_Alignas" {return new Symbol(Sym.ALIGNAS); }
  "_Alignof" {return new Symbol(Sym.ALIGNOF); }
  "_Atomic" {return new Symbol(Sym.ATOMIC); }
  "_Bool" {return new Symbol(Sym.BOOL); }
  "_Complex" {return new Symbol(Sym.COMPLEX); }
  "_Generic" {return new Symbol(Sym.GENERIC); }
  "_Imaginary" {return new Symbol(Sym.IMAGINARY); }
  "_Noreturn" {return new Symbol(Sym.NORETURN); }
  "_Static_assert" {return new Symbol(Sym.STATIC_ASSERT); }
  "_Thread_local" {return new Symbol(Sym.THREAD_LOCAL); }
  "__func__" {return new Symbol(Sym.FUNC_NAME); }

  /* Whitespace */
  {WhiteSpace} { /**/ }

  /* Comments */
  {Comments} { /**/ }

  /* Keywords */
  /*{Keyword} { return createToken("Keyword", yytext()); }*/

  /* Identifiers */
  {Identifier} { return new Symbol(Sym.IDENTIFIER); }

  /* Octal */
  /*{Octal} { return createToken("Octal", yytext()); }*/
  /* Hexadecimal */
  /*{Hexadecimal} { return createToken("Hexadecimal", yytext()); }*/
  /* Integer */
  {Integer} {return new Symbol(Sym.I_CONSTANT); }
  /* Float */
  {Float} {return new Symbol(Sym.F_CONSTANT); }

  /* String */
  \"([^\\\"]|\\.)*\" {return new Symbol(Sym.STRING_LITERAL); }
  /* Char */
  /*\'([^\\\"]|\\.)*\' { return createToken("Char", yytext()); }*/

  /* Separators */
  /*{Separator} { return createToken("Separator", yytext()); }*/

  /* Operators */
  /*{Operator} { return createToken("Operator", yytext()); }*/

  "(" {return new Symbol(Sym.LPAREN); }
  ")" {return new Symbol(Sym.RPAREN); }
  ("{"|"<%") {return new Symbol(Sym.LKEY); }
  ("}"|"%>") {return new Symbol(Sym.RKEY); }
  ("["|"<:") {return new Symbol(Sym.LBRA); }
  ("]"|":>") {return new Symbol(Sym.RBRA); }
  "," {return new Symbol(Sym.COMMA); }
  ";" {return new Symbol(Sym.SEMICOLON); }
  "+" {return new Symbol(Sym.PLUS); }
  "-" {return new Symbol(Sym.MINUS); }
  "*" {return new Symbol(Sym.STAR); }
  "/" {return new Symbol(Sym.BAR); }
  "%" {return new Symbol(Sym.PERC); }
  "!" {return new Symbol(Sym.EXCLA); }
  "&&" {return new Symbol(Sym.AND_OP); }
  "||" {return new Symbol(Sym.OR_OP); }
  "==" {return new Symbol(Sym.EQ_OP); }
  "!=" {return new Symbol(Sym.NE_OP); }
  "<=" {return new Symbol(Sym.LE_OP); }
  "<" {return new Symbol(Sym.LT); }
  ">=" {return new Symbol(Sym.GE_OP); }
  ">" {return new Symbol(Sym.GT); }
  "=" {return new Symbol(Sym.EQUALS); }
  "+=" {return new Symbol(Sym.ADD_ASSIGN); }
  "-=" {return new Symbol(Sym.SUB_ASSIGN); }
  "*=" {return new Symbol(Sym.MUL_ASSIGN); }
  "/=" {return new Symbol(Sym.DIV_ASSIGN); }
  "%=" {return new Symbol(Sym.MOD_ASSIGN); }
  "&=" {return new Symbol(Sym.AND_ASSIGN); }
  "^=" {return new Symbol(Sym.XOR_ASSIGN); }
  "&" {return new Symbol(Sym.AND); }
  "|" {return new Symbol(Sym.PIPE); }
  "~" {return new Symbol(Sym.TIL); }
  "^" {return new Symbol(Sym.CARET); }
  "<<" {return new Symbol(Sym.LEFT_OP); }
  ">>" {return new Symbol(Sym.RIGHT_OP); }
  "++" {return new Symbol(Sym.INC_OP); }
  "--" {return new Symbol(Sym.DEC_OP); }
  "..." {return new Symbol(Sym.ELLIPSIS); }
  ">>=" {return new Symbol(Sym.RIGHT_ASSIGN); }
  "<<=" {return new Symbol(Sym.LEFT_ASSIGN); }
  "|=" {return new Symbol(Sym.OR_ASSIGN); }
  "->" {return new Symbol(Sym.PTR_OP); }
  ":" {return new Symbol(Sym.DDOT); }
  "." {return new Symbol(Sym.DOT); }
  "?" {return new Symbol(Sym.INTER); }
}

/*static int check_type(void)
{
    switch (sym_type(yytext))
    {
    case TYPEDEF_NAME:
        return new Symbol(Sym.TYPEDEF_NAME);
    case ENUMERATION_CONSTANT:
        return new Symbol(Sym.ENUMERATION_CONSTANT);
    default:
        return new Symbol(Sym.IDENTIFIER);
    }
}*/

<<EOF>> { return new Symbol( Sym.EOF ); }

[^] { throw new RuntimeException("Caractere inválido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }
