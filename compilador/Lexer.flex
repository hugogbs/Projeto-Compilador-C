import java.io.*;
import java.util.*;
import java_cup.runtime.*;

%%
%public
%class Lexer
%cup
%implements sym
%char
%line
%column

%{
  public Lexer(java.io.Reader in, ComplexSymbolFactory sf){
  	this(in);
  	symbolFactory = sf;
  }
  ComplexSymbolFactory symbolFactory;

  private Symbol symbol(int sym) {
    return symbolFactory.newSymbol("sym", sym, new Location(yyline+1,yycolumn+1,yychar), new Location(yyline+1,yycolumn+yylength(),yychar+yylength()));
  }
  private Symbol symbol(int sym, Object val) {
    Location left = new Location(yyline+1,yycolumn+1,yychar);
    Location right= new Location(yyline+1,yycolumn+yylength(), yychar+yylength());
    return symbolFactory.newSymbol("sym", sym, left, right,val);
  }
  private Symbol symbol(int sym, Object val,int buflength) {
    Location left = new Location(yyline+1,yycolumn+yylength()-buflength,yychar+yylength()-buflength);
    Location right= new Location(yyline+1,yycolumn+yylength(), yychar+yylength());
    return symbolFactory.newSymbol("sym", sym, left, right,val);
  }

  private int typecheck(String s){
  	if (Parser.lookupType(s.trim())) {
  	    return TYPE_NAME;
  	}
  	else {
  	    return IDENTIFIER;
  	}
  }
%}

%eofval{
     return symbolFactory.newSymbol("EOF", EOF, new Location(yyline+1,yycolumn+1,yychar), new Location(yyline+1,yycolumn+1,yychar+1));
%eofval}

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

Any            = . | \n

%%

/* Keywords */
"auto" { return symbol(AUTO,yytext()); }
"double" {return symbol(DOUBLE,yytext()); }
"int" {return symbol(INT,yytext()); }
"struct" {return symbol(STRUCT,yytext()); }
"const" {return symbol(CONST,yytext()); }
"float" {return symbol(FLOAT,yytext()); }
"short" {return symbol(SHORT,yytext()); }
"unsigned" {return symbol(UNSIGNED,yytext()); }
"break" {return symbol(BREAK,yytext()); }
"else" {return symbol(ELSE,yytext()); }
"long" {return symbol(LONG,yytext()); }
"switch" {return symbol(SWITCH,yytext()); }
"continue" {return symbol(CONTINUE,yytext()); }
"for" {return symbol(FOR,yytext()); }
"signed" {return symbol(SIGNED,yytext()); }
"void" {return symbol(VOID,yytext()); }
"case" {return symbol(CASE,yytext()); }
"enum" {return symbol(ENUM,yytext()); }
"register" {return symbol(REGISTER,yytext()); }
"typedef" {return symbol(TYPEDEF,yytext()); }
"default" {return symbol(DEFAULT,yytext()); }
"goto" {return symbol(GOTO,yytext()); }
"sizeof" {return symbol(SIZEOF,yytext()); }
"volatile" {return symbol(VOLATILE,yytext()); }
"char" {return symbol(CHAR,yytext()); }
"extern" {return symbol(EXTERN,yytext()); }
"return" {return symbol(RETURN,yytext()); }
"union" {return symbol(UNION,yytext()); }
"do" {return symbol(DO,yytext()); }
"if" {return symbol(IF,yytext()); }
"static" {return symbol(STATIC,yytext()); }
"while" {return symbol(WHILE,yytext()); }
"inline" {return symbol(INLINE,yytext()); }
"restrict" {return symbol(RESTRICT,yytext()); }

"_Alignas" {return symbol(ALIGNAS,yytext()); }
"_Alignof" {return symbol(ALIGNOF,yytext()); }
"_Atomic" {return symbol(ATOMIC,yytext()); }
"_Bool" {return symbol(BOOL,yytext()); }
"_Complex" {return symbol(COMPLEX,yytext()); }
"_Generic" {return symbol(GENERIC,yytext()); }
"_Imaginary" {return symbol(IMAGINARY,yytext()); }
"_Noreturn" {return symbol(NORETURN,yytext()); }
"_Static_assert" {return symbol(STATIC_ASSERT,yytext()); }
"_Thread_local" {return symbol(THREAD_LOCAL,yytext()); }
"__func__" {return symbol(FUNC_NAME,yytext()); }

/* Whitespace */
{WhiteSpace} { /**/ }

/* Comments */
{Comments} { /**/ }

/* Identifiers */
{Identifier} { return symbol(IDENTIFIER,yytext()); }

/* Integer */
{Integer} {return symbol(I_CONSTANT,yytext()); }

/* Float */
{Float} {return symbol(F_CONSTANT,yytext()); }

/* String */
\"([^\\\"]|\\.)*\" {return symbol(STRING_LITERAL,yytext()); }
/* Char */
/*\'([^\\\"]|\\.)*\' {return symbol(CHAR,yytext()); }*/

/* Separators */
"(" {return symbol(LPAREN); }
")" {return symbol(RPAREN); }
("{"|"<%") {return symbol(LKEY); }
("}"|"%>") {return symbol(RKEY); }
("["|"<:") {return symbol(LBRA); }
("]"|":>") {return symbol(RBRA); }

/* Operators */
"," {return symbol(COMMA); }
";" {return symbol(SEMICOLON); }
"+" {return symbol(PLUS); }
"-" {return symbol(MINUS); }
"*" {return symbol(STAR); }
"/" {return symbol(BAR); }
"%" {return symbol(PERC); }
"!" {return symbol(EXCLA); }
"&&" {return symbol(AND_OP); }
"||" {return symbol(OR_OP); }
"==" {return symbol(EQ_OP); }
"!=" {return symbol(NE_OP); }
"<=" {return symbol(LE_OP); }
"<" {return symbol(LT); }
">=" {return symbol(GE_OP); }
">" {return symbol(GT); }
"=" {return symbol(EQUALS); }
"+=" {return symbol(ADD_ASSIGN); }
"-=" {return symbol(SUB_ASSIGN); }
"*=" {return symbol(MUL_ASSIGN); }
"/=" {return symbol(DIV_ASSIGN); }
"%=" {return symbol(MOD_ASSIGN); }
"&=" {return symbol(AND_ASSIGN); }
"^=" {return symbol(XOR_ASSIGN); }
"&" {return symbol(AND); }
"|" {return symbol(PIPE); }
"~" {return symbol(TIL); }
"^" {return symbol(CARET); }
"<<" {return symbol(LEFT_OP); }
">>" {return symbol(RIGHT_OP); }
"++" {return symbol(INC_OP); }
"--" {return symbol(DEC_OP); }
"..." {return symbol(ELLIPSIS); }
">>=" {return symbol(RIGHT_ASSIGN); }
"<<=" {return symbol(LEFT_ASSIGN); }
"|=" {return symbol(OR_ASSIGN); }
"->" {return symbol(PTR_OP); }
":" {return symbol(DDOT); }
"." {return symbol(DOT); }
"?" {return symbol(INTER); }

.|\n			{ throw new RuntimeException("Caractere inválido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }
