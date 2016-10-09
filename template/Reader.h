#ifndef <grammar>_READER_H
#define <grammar>_READER_H

#include <string>
#include <cstddef>
#include <iostream>
#include <istream>
#include <sstream>

namespace <namespace> {

class <grammar>Scanner;
class <grammar>Parser;

class <grammar>Reader {
friend class <grammar>Parser;
	
public:
	<grammar>Reader() :
		parser(nullptr),
		scanner(nullptr) {}

	virtual ~<grammar>Reader();

	void parseFromFile(const std::string &filename);
	void parseFromString(const std::string &str);
	void parseFromStream(std::istream &stream);

private:

	////////////////////////////////////////////////////////////////////////////
	// Flex (Lex) / Bison (Yacc)
	////////////////////////////////////////////////////////////////////////////	
	
	<grammar>Parser *parser;
	<grammar>Scanner *scanner;

	////////////////////////////////////////////////////////////////////////////
	// Parsing callbacks.
	////////////////////////////////////////////////////////////////////////////

	// ### ADD PARSER CALLBACKS HERE ###
	
	// --- Example -------------------------------------------------------------
	void readCallback(const std::string &type, const std::string &text) { 
		std::cout << type << ": " << text << '\n';
	}
	// -------------------------------------------------------------------------	
	
}; // end class

} // end namespace
#endif

