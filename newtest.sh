###########################
#Created by Arkadiusz Kraus
###########################
name=$1
prog=$2
brute=$3
checker=$4
mkdir $name
cd $name
mkdir "in" 
mkdir "out" 
mkdir "prog"
mkdir "brute"
mkdir "usertests"
mkdir "checker"
mkdir ".generator_files"
if [ -n "$2" ] 
then 
	path=../../$2
	path2=prog/$1.cpp
	echo "copying file " $path " to " $path2
	cp ../../$2 prog/$1.cpp
	touch .generator_files/progname
	echo $2 > .generator_files/progname
fi
if [ -n "$3" ] 
then
	path=../../$3
	path2=brute/$1.cpp
	echo "copying file " $path " to " $path2
	cp ../../$3 brute/$1.cpp
	touch .generator_files/brutename
	echo $3 > .generator_files/brutename
fi
if [ -n "$4" ] 
then
	path=../../$4
	path2=checker/$1.cpp
	echo "copying file " $path " to " $path2
	cp ../../$4 checker/$1.cpp
	touch .generator_files/checkername
	echo $4 > .generator_files/checkername
fi
cp ../makeIn_template.cpp makeIn.cpp
