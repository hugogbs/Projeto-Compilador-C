
LineTerminator = \r|\n|\r\n
Identifier     = [A-Za-z_][A-Za-z_0-9]*
Integer        = [0-9]+

WhiteSpace     = {LineTerminator} | [ \t\f]

Printable      = [ -~]

Any            = . | \n


<YYINITIAL> {
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

	/* Whitespace */
	{WhiteSpace} { /* ignore */ }

	/* Comments */
	"/*" { yybegin(LONG_COMMENT); }
	"//" { yybegin(SHORT_COMMENT); }
	"*/" { return makeErrorToken("stray comment terminator \"*/\""); }

	/* Any other illegal character. */
	{Any} { return makeErrorToken("stray " + charName()); }
}
