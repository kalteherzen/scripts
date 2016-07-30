#!/bin/bash

week=$(date +%V)
day=$(date +%w)
date=$(date)

clear

printf "Today is: $date\n"

if [ $week == 30 ] && [ $day == 5 ]; then
	printf "Celebrate, it's the Sysadmin Day\n"
else
	printf "Get back to work\n"
fi
