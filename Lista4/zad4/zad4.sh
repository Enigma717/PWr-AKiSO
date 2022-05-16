#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
resetcursor=$(tput sgr0)


lynx -dump "$1" >| websiteold.txt
>changes.txt

while :
do

	lynx -dump "$1" >| websitenew.txt

	current_date=$(date +"%m-%d-%Y %T")
	save_difference=$(diff websiteold.txt websitenew.txt > changes.txt)
	check_difference=$(diff websiteold.txt websitenew.txt | wc -l)	
	
	if [ $check_difference -gt 0 ]
	then
		printf "\n$red[$current_date]$green Change on the site detected!$resetcursor"
	fi
	
	sleep $2
done
