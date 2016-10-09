%{
#include <string>

/* Implementation of yyFlexScanner */ 
#include "../<grammar>Scanner.h"
#undef  YY_DECL
#define YY_DECL int <namespace>::<grammar>Scanner::yylex( \
  <namespace>::<grammar>Parser::semantic_type * const lval, \
  <namespace>::<grammar>Parser::location_type * loc)

/* typedef to make the returns for the tokens shorter */
using token = <namespace>::<grammar>Parser::token;

/* define yyterminate as this instead of NULL */
#define yyterminate() return( token::END )

/* msvc2010 requires that we exclude this header file. */
#define YY_NO_UNISTD_H

/* update location on matching */
#define YY_USER_ACTION loc->step(); loc->columns(yyleng);

%}

%option nodefault
%option yyclass="<namespace>::<grammar>Scanner"
%option noyywrap
%option c++
%option prefix="yy<grammar>"

%x MULTI_LINE_COMMENT
%x SINGLE_LINE_COMMENT

WS [ \t\b\f\r]+

%%
%{          
/* Executed at the beginning of yylex */
yylval = lval;
%}
 
 /* ### ADD TOKEN MATCHING RULES HERE ###
 
 /* --- Example ------------------------------------------------------------- */

 /* Whitespaces and New Lines */

{WS} { ; }
\n { loc->lines(); }

 /* Single Line Comment */

"//" { BEGIN(SINGLE_LINE_COMMENT); }
<SINGLE_LINE_COMMENT>.    { yymore(); }
<SINGLE_LINE_COMMENT>\n   { loc->lines(); BEGIN(0); }

"/*" { BEGIN(MULTI_LINE_COMMENT); }
<MULTI_LINE_COMMENT>.    { yymore(); }
<MULTI_LINE_COMMENT>\n   { loc->lines(); yymore(); }
<MULTI_LINE_COMMENT>"*/" { BEGIN(0); }

 /* Keywords */

keyword1 { return token::KEYWORD1; }
keyword2 { return token::KEYWORD2; }
	
 /* Identifiers */

[a-zA-Z_][a-zA-Z0-9$_]* {
		yylval->build<std::string>(yytext);
		return token::IDENTIFIER; 
	}

 /* Integer */
 
[0-9][0-9]* {
		yylval->build<std::string>(yytext);
		return token::INTEGER;
	}

 /* Floating Point: +1e10, 1e5, -1e-3 */
[+-]?[0-9]+([Ee][+-]?[0-9]+) {
		yylval->build<std::string>(yytext);
		return token::FLOAT;
	}

 /* Floating Point: +1.02e10, 1.003, -1e-3, .0 */
[+-]?[0-9]*\.[0-9]+([Ee][+-]?[0-9]+)? {
		yylval->build<std::string>(yytext);
		return token::FLOAT;
	}

 /* String */
 
\"[^"\n]*["\n] {
		// Note: '\r' is handled as a whitespace, so we don't need to deal 
		// with it here.
		
		const bool malformed = yytext[yyleng-1] != '"';
		if (!malformed)
			 yytext[yyleng-1] = '\0';
		yylval->build<std::string>(yytext + 1); // +1 skips initial quote		
		return malformed? token::MALFORMED_STRING : token::STRING;		
	}
 
 /* Unmatched */

. { return yytext[0]; }

 /* ------------------------------------------------------------------------- */

%%

	
