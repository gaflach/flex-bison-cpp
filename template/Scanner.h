#ifndef <grammar>_SCANNER_H
#define <grammar>_SCANNER_H

#if ! defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#include "base/<grammar>.tab.hh"
#include "base/location.hh"

namespace <namespace> {

class <grammar>Scanner : public yyFlexLexer {
public:
   
   <grammar>Scanner(std::istream *in) : yyFlexLexer(in) {
      loc = new <grammar>Parser::location_type();
   };
   virtual ~<grammar>Scanner() {
      delete loc;
   };

   // Get rid of override virtual function warning.
   using FlexLexer::yylex;

   virtual
   int yylex(<grammar>Parser::semantic_type * const lval, 
             <grammar>Parser::location_type *location);

private:
   <grammar>Parser::semantic_type *yylval = nullptr;
   <grammar>Parser::location_type *loc    = nullptr;
};

} // end namespace

#endif

