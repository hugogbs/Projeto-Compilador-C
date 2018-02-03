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
Keyword        = auto|double|int|struct|const|float|short|unsigned|break|else|long|switch|continue|for|signed|void|case|enum|register|typedef|default|goto|sizeof|volatile|char|extern|return|union|do|if|static|while
Identifier     = [A-Za-z_][A-Za-z_0-9]*
Integer        = [0-9]+
Separator      = "("|")"|"{"|"}"|"["|"]"|","|";"
Operator       = "+"|"-"|"*"|"/"|"!"|"&&"|"||"|"=="|"!="|"<="|"<"|">="|">"|"="


WhiteSpace     = {LineTerminator} | [ \t\f]

Printable      = [ -~]

Any            = . | \n

program = "program"

%%

/* Keywords */
{Keyword} { return createToken("Keyword", yytext()); }

/* Identifiers */
{Identifier} { return createToken("Identifier", yytext()); }

/* Integer literals */
{Integer} { return createToken("Integer", yytext()); }

/* Separators */
{Separator} { return createToken("Separator", yytext()); }

/* Operators */
{Operator} { return createToken("Operator", yytext()); }

{program} { return createToken(yytext(), "");}
{WhiteSpace} { /**/ }

. { throw new RuntimeException("Caractere inválido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }
