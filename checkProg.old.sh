###########################
#Created by Arkadiusz Kraus
###########################
name=$1
numberOfTests=$2
pathGen="generator_files"
echo "generating tests"
g++ $pathGen/generateIns.cpp -I $name -o $pathGen/gen
touch $pathGen/progname
echo $name > $pathGen/progname
echo " " >> $pathGen/progname
echo $numberOfTests >> $pathGen/progname
$pathGen/./gen < $pathGen/progname

echo "compiling programs"
g++ $name/prog/$name.cpp -o $pathGen/prog
g++ $name/brute/$name.cpp -o $pathGen/brute

echo "generating answers to user's tests"
numberOfUserTests=$(ls -l $name/usertests/*.in | wc -l)
echo "there are "$numberOfUserTests" user's tests"
for((i=1;i<=$numberOfUserTests;i++));do
	$pathGen/./prog < $name/usertests/$name$i.in > $name/usertests/$name$i.prog.out
done

echo "generating answers from program"
for ((i=1;$i<=$numberOfTests;i++));do
	touch $name/out/$name$i.prog.out
	$pathGen/./prog < $name/in/$name$i.in > $name/out/$name$i.prog.out
	echo "answer "$i" - generated" 
done

echo "generating answers from brute"
for ((i=1;$i<=$numberOfTests;i++));do
	touch $name/out/$name$i.brute.out
	$pathGen/./brute < $name/in/$name$i.in > $name/out/$name$i.brute.out
	echo "answer "$i" - generated" 
done

echo "checking user's tests"
for ((i=1;$i<=$numberOfUserTests;i++));do
	 touch $pathGen/difference	
	 diff $name/usertests/$name$i.prog.out $name/usertests/$name$i.out > $pathGen/difference 
	 if [ ! -s $pathGen/difference ]; 
	 then
	 	echo "test "$i" - OK"
	 else
	 	echo "test "$i" - fail"
	 fi		
done

echo "checking"
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
