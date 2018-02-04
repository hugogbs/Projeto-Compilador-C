import java_cup.runtime.*;

%%

%{


private CToken createToken(String name, String value) {
    return new CToken( name, value, yyline, yycolumn);
}

%}

%public
%class LexicalAnalyzer
%type CToken
%line
%column

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
Keyword        = auto|double|int|struct|const|float|short|unsigned|break|else|long|switch|continue|for|signed|void|case|enum|register|typedef|default|goto|sizeof|volatile|char|extern|return|union|do|if|static|while
Identifier     = [A-Za-z_][A-Za-z_0-9]*
Integer        = "-"?[0-9]+
Float          = "-"?[0-9]+"."[0-9]+
Octal          = "-"?0[0-9]+
Hexadecimal    = "-"?0x[0-9]+

Separator      = "("|")"|"{"|"}"|"["|"]"|","|";"
Operator       = "+"|"-"|"*"|"/"|"%"|"!"|"&&"|"||"|"=="|"!="|"<="|"<"|">="|">"|"="|"+="|"-="|"*="|"/="|"%="|"&="|"^="|"&"|"|"|"~"|"^"|"<<"|">>"|"++"|"--"

Comments = {LineComment} | {BlockComment}
LineComment = "//" {InputCharacter}* {LineTerminator}?
BlockComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"

WhiteSpace     = {LineTerminator} | [ \t\f  ]

Printable      = [ -~]

Any            = . | \n

program = "program"

%%

/* Whitespace */
{WhiteSpace} { /**/ }

/* Comments */
{Comments} { /**/ }

/* Keywords */
{Keyword} { return createToken("Keyword", yytext()); }

/* Identifiers */
{Identifier} { return createToken("Identifier", yytext()); }

/* Octal */
{Octal} { return createToken("Octal", yytext()); }
/* Hexadecimal */
{Hexadecimal} { return createToken("Hexadecimal", yytext()); }
/* Integer */
{Integer} { return createToken("Integer", yytext()); }
/* Float */
{Float} { return createToken("Float", yytext()); }

/* String */
\"([^\\\"]|\\.)*\" { return createToken("String", yytext()); }
/* Char */
\'([^\\\"]|\\.)*\' { return createToken("Char", yytext()); }

/* Separators */
{Separator} { return createToken("Separator", yytext()); }

/* Operators */
{Operator} { return createToken("Operator", yytext()); }



. { throw new RuntimeException("Caractere inválido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }
