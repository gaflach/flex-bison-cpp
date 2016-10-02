# Flex/Bison C++ (Lex/Yacc C++)

A very simple code generator to make it easier to use Flex/Bison (Lex/Yacc) in C++.
Don't expect magic :)

This project is based on the Jonathan Beard's tutorial:
http://www.jonathanbeard.io/tutorials/FlexBisonC++

----------

Usage
---------

After downloading the code...

`./create.sh <grammar> <namespace>`

will generate a few files in the output folder that are ready to be modified/incremented and used inside a C++ project. 

Replace `<grammar>` by a grammar name and `<namespace>` by the name space in which all classes will be declared.

Testing
----------
Even without modifications, the generated code is ready to be compiled and tested.
The default parser will read numbers, strings and identifiers echoing them back to the screen.

To test...

`./create.sh Echo Parser`
`cd output/test`
`make`
`./Echo`

and type some numbers, strings and identifiers.

An example of output:

> 24061960
> Integer: 24061960
> counter 
> Identifier: counter
> "porto alegre"
> String: porto alegre
> 2.71828
> Float: 2.71828

Dependencies
------------
`sudo apt-get install flex` (flex >= 2.6)
`sudo apt-get install bison`
