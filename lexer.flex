LineTerminator = \r|\n|\r\n
Identifier     = [A-Za-z_][A-Za-z_0-9]*
Integer        = [0-9]+

WhiteSpace     = {LineTerminator} | [ \t\f]

Printable      = [ -~]

Any            = . | \n


<YYINITIAL> {

  /* Keywords */
  "auto"    { return makeSymbol(cminor.parser.Symbol.AUTO); }
  "double"  { return makeSymbol(cminor.parser.Symbol.DOUBLE); }
  "int" { return makeSymbol(cminor.parser.Symbol.INT); }
  "struct"    { return makeSymbol(cminor.parser.Symbol.STRUCT); }
  "const" { return makeSymbol(cminor.parser.Symbol.CONST); }
  "float"     { return makeSymbol(cminor.parser.Symbol.INT); }
  "short"    { return makeSymbol(cminor.parser.Symbol.SHORT); }
  "unsigned"  { return makeSymbol(cminor.parser.Symbol.UNSIGN); }
  "break" { return makeSymbol(cminor.parser.Symbol.BREAK); }
  "else"  { return makeSymbol(cminor.parser.Symbol.ELSE); }
  "long" { return makeSymbol(cminor.parser.Symbol.LONG); }
  "switch"  { return makeSymbol(cminor.parser.Symbol.SWITCH); }
  "continue"    { return makeSymbol(cminor.parser.Symbol.CONTINUE); }
  "for"  { return makeSymbol(cminor.parser.Symbol.FOR); }
  "signed" { return makeSymbol(cminor.parser.Symbol.SIGNED); }
  "void"    { return makeSymbol(cminor.parser.Symbol.VOID); }
  "case" { return makeSymbol(cminor.parser.Symbol.CASE); }
  "enum"     { return makeSymbol(cminor.parser.Symbol.ENUM); }
  "register"    { return makeSymbol(cminor.parser.Symbol.REGISTER); }
  "typedef"    { return makeSymbol(cminor.parser.Symbol.TYPEDEF); }
  "default"  { return makeSymbol(cminor.parser.Symbol.DEFAULT); }
  "goto" { return makeSymbol(cminor.parser.Symbol.GOTO); }
  "sizeof"  { return makeSymbol(cminor.parser.Symbol.SIZEOF); }
  "volatile" { return makeSymbol(cminor.parser.Symbol.VOLATILE); }
  "char"  { return makeSymbol(cminor.parser.Symbol.CHAR); }
  "extern"    { return makeSymbol(cminor.parser.Symbol.EXTERN); }
  "return"  { return makeSymbol(cminor.parser.Symbol.RETURN); }
  "union" { return makeSymbol(cminor.parser.Symbol.UNION); }
  "do"    { return makeSymbol(cminor.parser.Symbol.DO); }
  "if" { return makeSymbol(cminor.parser.Symbol.IF); }
  "static"     { return makeSymbol(cminor.parser.Symbol.STATIC); }
  "while"    { return makeSymbol(cminor.parser.Symbol.WHILE); }

  /* Identifiers */
  {Identifier} { return makeSymbol(cminor.parser.Symbol.IDENTIFIER, getIdentifierString()); }

  /* Integer literals */
  {Integer} { return makeSymbol(cminor.parser.Symbol.INT_LITERAL, Integer.parseInt(yytext())); }

  /* Separators */
  	"(" { return makeSymbol(cminor.parser.Symbol.LPAREN); }
  	")" { return makeSymbol(cminor.parser.Symbol.RPAREN); }
  	"{" { return makeSymbol(cminor.parser.Symbol.LBRACE); }
  	"}" { return makeSymbol(cminor.parser.Symbol.RBRACE); }
    "[" { return makeSymbol(cminor.parser.Symbol.LBRACKET); }
    "]" { return makeSymbol(cminor.parser.Symbol.RBRACKET); }
  	"," { return makeSymbol(cminor.parser.Symbol.COMMA); }
  	";" { return makeSymbol(cminor.parser.Symbol.SEMI); }

  	/* Operators */
  	"+"  { return makeSymbol(cminor.parser.Symbol.ADD); }
  	"-"  { return makeSymbol(cminor.parser.Symbol.SUB); }
  	"*"  { return makeSymbol(cminor.parser.Symbol.STAR); }
  	"/"  { return makeSymbol(cminor.parser.Symbol.DIV); }
  	"!"  { return makeSymbol(cminor.parser.Symbol.NOT); }
  	"&&" { return makeSymbol(cminor.parser.Symbol.AND); }
  	"||" { return makeSymbol(cminor.parser.Symbol.OR); }
  	"==" { return makeSymbol(cminor.parser.Symbol.EQ); }
  	"!=" { return makeSymbol(cminor.parser.Symbol.NE); }
  	"<=" { return makeSymbol(cminor.parser.Symbol.LE); }
  	"<"  { return makeSymbol(cminor.parser.Symbol.LT); }
  	">=" { return makeSymbol(cminor.parser.Symbol.GE); }
  	">"  { return makeSymbol(cminor.parser.Symbol.GT); }
  	"="  { return makeSymbol(cminor.parser.Symbol.ASSIGN); }

    /* String literal */
    \" { yybegin(STRINGLITERAL); stringBuffer.setLength(0); }

    /* Character literal */
    \' { yybegin(CHARLITERAL); stringBuffer.setLength(0); }

	/* Whitespace */
	{WhiteSpace} { /* ignore */ }

	/* Comments */
	"/*" { yybegin(LONG_COMMENT); }
	"//" { yybegin(SHORT_COMMENT); }
	"*/" { return makeErrorToken("stray comment terminator \"*/\""); }

	/* Any other illegal character. */
	{Any} { return makeErrorToken("stray " + charName()); }
}

<STRINGLITERAL> {

	/* End of string literal */
	\"            { yybegin(YYINITIAL); return new Symbol(cminor.parser.Symbol.STRING_LITERAL, stringBuffer.toString()); }

	/* Escape sequences */
	\\n           { stringBuffer.append('\n'); Symbol err = checkStringLiteralLength(); if(err != null) return err; }
	\\0           { stringBuffer.append('\0'); Symbol err = checkStringLiteralLength(); if(err != null) return err; }
	\\{Printable} { stringBuffer.append(getLastChar()); Symbol err = checkStringLiteralLength(); if(err != null) return err; }

	/* Legal unescaped characters */
	{Printable}   { stringBuffer.append(getLastChar()); Symbol err = checkStringLiteralLength(); if(err != null) return err; }

	/* Stray newline */
	{LineTerminator} { yybegin(YYINITIAL); return makeErrorToken("missing closing quote for string literal"); }

	/* Other, illegal characters */
	{Any}         { yybegin(STRING_RECOVER); return makeErrorToken("illegal " + charName() + " in string literal"); }

}
