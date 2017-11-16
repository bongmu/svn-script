#/bin/bash
i=1
while [[ "$i" -lt 15 ]];do
	let "square=i*i"
	let "i=i+1"
	echo "$i*$i=${square}"
done
