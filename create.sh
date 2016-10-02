#/bin/bash

if [ -z "$1" ] || [ -z "$2" ] 
then
  echo "Usage: ./create.sh <gramar> <namespace>"
  echo "Example: ./create.sh JavaScript Parsing"
  exit
fi 

output_dir="output"
test_dir="test"

grammar=$1
namespace=$2

mkdir -p $output_dir
cp template/grammar.yy $output_dir/${grammar}.yy
cp template/scanner.l $output_dir/${grammar}.l
cp template/Reader.h $output_dir/${grammar}Reader.h
cp template/Reader.cpp $output_dir/${grammar}Reader.cpp
cp template/Scanner.h $output_dir/${grammar}Scanner.h
cp template/main.cpp $output_dir/main.cpp
cp template/Makefile $output_dir/Makefile
cp template/export.sh $output_dir

cd $output_dir
for file in *
do

	if [ -d $file ]
	then
		continue
	fi
 
	sed -i "s/<grammar>/$grammar/g" $file
	sed -i "s/<namespace>/$namespace/g" $file	
done

mkdir -p $test_dir
mv main.cpp $test_dir
mv Makefile $test_dir


