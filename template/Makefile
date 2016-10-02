CC    ?= clang
CXX   ?= clang++

EXE = <grammar>

CDEBUG = -g -Wall

CXXDEBUG = -g -Wall

CSTD = -std=c99
CXXSTD = -std=c++14

CFLAGS = -Wno-deprecated-register -O0  $(CDEBUG) $(CSTD) 
CXXFLAGS = -Wno-deprecated-register -O0  $(CXXDEBUG) $(CXXSTD)


CPPOBJ = main exported/<grammar>Reader
SOBJ =  parser lexer

FILES = $(addsuffix .cpp, $(CPPOBJ))

OBJS  = $(addsuffix .o, $(CPPOBJ))

CLEANLIST =  $(addsuffix .o, $(OBJ)) $(OBJS) \
				 <grammar>.tab.cc <grammar>.tab.hh \
				 location.hh position.hh \
			     stack.hh <grammar>.output parser.o \
				 lexer.o <grammar>.yy.cc $(EXE)\

.PHONY: all
all: 
	cd .. && sh ./export.sh test/exported
	cp main.cpp exported
	cd exported && g++ main.cpp <grammar>Reader.cpp base/<grammar>.yy.cc base/<grammar>.tab.cc -std=c++11 -o ../<grammar>

.PHONY: clean
clean:
	rm -rf exported
