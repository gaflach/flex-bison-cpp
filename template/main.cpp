#include <iostream>
#include <cstdlib>
#include <cstring>

#include "<grammar>Reader.h"

int 
main(const int argc, const char * argv[]) {
	if (argc == 2) {
		<namespace>::<grammar>Reader reader;
		reader.parseFromFile(argv[1]);
		return 0;
	} if (argc == 1) {
		<namespace>::<grammar>Reader reader;
		reader.parseFromStream(std::cin);
		return 0;	 	
	} else {
		std::cout << "Usage: ./" << argv[0] << " <file to be parsed>"  << "\n";
		return 1;
	} // end else
} // end main
