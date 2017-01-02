name=$1
if [ -n "$1" ]
then
	cd $1
	prog=$(cat .generator_files/progname)
	brute=$(cat .generator_files/brutename)
	checker=$(cat .generator_files/checkername)
	mv prog/$1.cpp prog/$1.old.cpp
	cp ../../$prog prog/$1.cpp
	mv brute/$1.cpp brute/$1.old.cpp
	cp ../../$brute brute/$1.cpp
	mv checker/$1.cpp checker/$1.old.cpp
	cp ../../$checker checker/$1.cpp
fi
