###########################
#Created by Arkadiusz Kraus
###########################
name=$1
numberOfTests=$2
mode=$3

pathGen="generator_files"
echo "generating tests"
g++ $pathGen/generateIns.cpp -I $name -o $pathGen/gen
touch $pathGen/progname
echo $name > $pathGen/progname
echo " " >> $pathGen/progname
echo $numberOfTests >> $pathGen/progname
$pathGen/./gen < $pathGen/progname

echo "compiling programs"
g++ --std=c++14 $name/prog/$name.cpp -o $pathGen/prog
g++ --std=c++14 $name/brute/$name.cpp -o $pathGen/brute
g++ --std=c++14 $name/checker/$name.cpp -o $pathGen/checker

echo "generating answers to user's tests"
numberOfUserTests=$(ls -l $name/usertests/*.in | wc -l)
echo "there are "$numberOfUserTests" user's tests"
for test in $name/usertests/*.in; do
	testname="${test%%.*}"
	$pathGen/./prog < $test > $testname.prog.out
done

echo "generating answers from program"
for ((i=1;$i<=$numberOfTests;i++));do
	touch $name/out/$name$i.prog.out
	$pathGen/./prog < $name/in/$name$i.in > $name/out/$name$i.prog.out
	echo "answer "$i" - generated" 
done

if [ $mode = "1" ] 
then
	echo "generating answers from brute"
	for ((i=1;$i<=$numberOfTests;i++));do
		touch $name/out/$name$i.brute.out
		$pathGen/./brute < $name/in/$name$i.in > $name/out/$name$i.brute.out
		echo "answer "$i" - generated" 
	done
fi

echo "checking user's tests"
if [ $mode = "1" ] 
then
	for test in $name/usertests/*.in; do
		testname="${test%%.*}"	
		diff $testname.prog.out $testname.out > $pathGen/difference 
		if [ ! -s $pathGen/difference ]; 
		then
			echo "test "$testname" - OK"
		else
			echo "test "$testname" - fail"
			head -4 $pathGen/difference | tail -3
		fi		
	done
else
	for ((i=1;$i<=$numberOfUserTests;i++));do
		touch $pathGen/mergeIn
		$name/usertests/$name$i.in > $pathGen/mergeIn 
		$name/usertests/$name$i.prog.out >> $pathGen/mergeIn 
		result=$($pathGen/checker < $pathGen/mergeIn)
		echo "test "$i" - "$result	
	done
fi	

echo "checking"
if [ $mode = "1" ] 
then
	for ((i=1;$i<=$numberOfTests;i++));do
		 touch $pathGen/difference	
		 diff $name/out/$name$i.prog.out $name/out/$name$i.brute.out > 	$pathGen/difference 
		 if [ ! -s $pathGen/difference ]; 
		 then
		 	echo "test "$i" - OK"
		 else
		 	echo "test "$i" - fail"
		 fi		
	done
else
	for ((i=1;$i<=$numberOfTests;i++));do
		touch $pathGen/mergeIn
		echo $(cat $name/in/$name$i.in) > $pathGen/mergeIn 
		echo $(cat $name/out/$name$i.prog.out) >> $pathGen/mergeIn 
		result=$($pathGen/checker < $pathGen/mergeIn)
		echo "test "$i" - "$result	
	done
fi	
