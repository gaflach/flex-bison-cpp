#include <cctype>
#include <fstream>
#include <cassert>

#include "<grammar>Reader.h"

namespace <namespace> {

<grammar>Reader::~<grammar>Reader() {
	delete scanner;
	delete parser;
} // end destructor

// -----------------------------------------------------------------------------

void <grammar>Reader::parseFromFile(const std::string &filename) {
	std::ifstream file(filename.c_str());
	if (!file.good()) {
		std::exit(1);
	} // end if
	parseFromStream(file);
} // end method

// -----------------------------------------------------------------------------

void <grammar>Reader::parseFromString(const std::string &str) {
	std::istringstream iss(str);
	parseFromStream(iss);
} // end method

// -----------------------------------------------------------------------------

void <grammar>Reader::parseFromStream(std::istream &stream) {
	if (!stream.good() && stream.eof()) {
		return;
	} // end if
	
	delete scanner;
	try {
		scanner = new <namespace>::<grammar>Scanner(&stream);
	} catch (std::bad_alloc &ba) {
		std::cerr << "Failed to allocate scanner: (" <<
				ba.what() << "), exiting!!\n";
		std::exit(1);
	} // end catch

	delete parser ;
	try {
		parser = new <namespace>::<grammar>Parser(*scanner, *this);
	} catch (std::bad_alloc &ba) {
		std::cerr << "Failed to allocate parser: (" <<
				ba.what() << "), exiting!!\n";
		std::exit(1);
	} // end catch
	
	if (parser->parse() != 0) {
		std::cout << "Parse failed.\n";
		std::exit(1);
	} else {
		std::cout << "Parse succeed.\n";
	} // end else

} // end method

} // end namespace
