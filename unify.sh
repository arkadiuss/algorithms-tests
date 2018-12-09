for ans in usertests/*.ans; do
	name="${ans%%.*}"
	mv $ans $name.out 
done
	
