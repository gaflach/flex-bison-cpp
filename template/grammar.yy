%skeleton "lalr1.cc"
%require  "3.0"
%defines 
%define api.namespace {<namespace>}
%define parser_class_name {<grammar>Parser}

%code requires{
   namespace <namespace> {
      class <grammar>Scanner;
      class <grammar>Reader;
   }

// The following definitions is missing when "%locations" isn't used
# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

}

%parse-param { <grammar>Scanner &scanner }
%parse-param { <grammar>Reader &reader }

%code{
   #include <iostream>
   #include <cstdlib>
   #include <fstream>
   
   #include "../<grammar>Reader.h"
   #include "../<grammar>Scanner.h"   
 
   #undef yylex
   #define yylex scanner.yylex
}

%define api.value.type variant
%define parse.assert

// ### ADD TOKEN DEFINITIONS HERE ###

// Example ---------------------------------------------------------------------

%token               END    0     "end of file"
%token <std::string> STRING
%token <std::string> MALFORMED_STRING
%token <std::string> IDENTIFIER
%token <std::string> KEYWORD1
%token <std::string> KEYWORD2
%token <std::string> INTEGER
%token <std::string> FLOAT

// -----------------------------------------------------------------------------


%locations

%%

// ### ADD GRAMMAR RULES HERE ###

// Example ---------------------------------------------------------------------

start
	: element_list END
	;
	
element_list
	: /* empty */
	| element_list element 
	;
	
element
	: KEYWORD1        { reader.readCallback("Keyword", $1); }
	| KEYWORD2        { reader.readCallback("Keyword", $1); }
	| STRING          { reader.readCallback("String", $1); }
	| INTEGER         { reader.readCallback("Integer", $1); }
	| FLOAT           { reader.readCallback("Float", $1); }
	| IDENTIFIER      { reader.readCallback("Identifier", $1); }
	;

// -----------------------------------------------------------------------------  
   
%%

void 
<namespace>::<grammar>Parser::error(const <namespace>::<grammar>Parser::location_type &l, const std::string &err_message) {
   std::cout << "Parsing Error: " << err_message << " at " << l << "\n";
}
