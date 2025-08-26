#! /bin/bash

n1=$1
n2=$2


is_prime(){
	local num=$1
	if [ $n1 -le 1 ]; then
		return 1
	fi
}



i=$n1
while [ $n1 -le $n2 ]; 
do
	cont=0
	dig=${n1:$cont:1}
	if [ $dig -eq $patron ]; then
		if [ is_prime $n1]; then
			echo "$n1 primo"
		else
			echo $n1
		fi
	fi
	n1=$(($n1+1))
done