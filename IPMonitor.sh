#!/bin/bash
clear
SERVERIP=$1
x=1
up=0
down=0

while [ $x = 1 ]
do
	
	ping -c 1 $SERVERIP > /dev/null 2>&1

	if [ $? -ne 0 ]
	then
		#Play a sound when the server is not responding.
		((down++))
		mpg123 alert.mp3
		#break	
	else
		#Output if everything is ok
		((up++))
	fi
		clear
		printf "IP monitor\n"
		printf "\n"
		printf "Ip $SERVERIP successfull reply count: $up\n"
		printf "IP $SERVERIP failed response count: $down\n"
printf "\n"

done
