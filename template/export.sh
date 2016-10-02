#/bin/bash

if [ -z "$1" ] 
then
  echo "Usage: ./export.sh <directory> "
  echo "Example: ./export.sh /path/to/<grammar>/"
  exit
fi 

dir="$PWD"
outdir="$1"
gendir="$outdir/base"

# Backup files, we don't want to ruin lifes...
temp=`mktemp -d`
cp * $temp
echo "Your files were backed up in '$temp'..." 

mkdir -p $gendir
cp <grammar>Reader.h $outdir
cp <grammar>Reader.cpp $outdir
cp <grammar>Scanner.h $outdir

cd $gendir
bison -d -v $dir/<grammar>.yy
flex --outfile=<grammar>.yy.cc $dir/<grammar>.l
rm *.output
cd ..
