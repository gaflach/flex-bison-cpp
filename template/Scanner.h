#ifndef <grammar>_SCANNER_H
#define <grammar>_SCANNER_H

/* From Flex documentation:
 *   The c++ scanner is a mess. The FlexLexer.h header file relies on the
 *   following macro. This is required in order to pass the c++-multiple-scanners
 *   test in the regression suite. We get reports that it breaks inheritance.
 *   We will address this in a future release of flex, or omit the C++ scanner
 *   altogether.
 *
 * So, for now, let's define this variable too...
 */
 
#define yyFlexLexer yy<grammar>FlexLexer

#if ! defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#undef yylex

#include "base/<grammar>.tab.hh"

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

