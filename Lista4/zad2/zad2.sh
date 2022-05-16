#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
bold=$(tput bold)
resetcursor=$(tput sgr0)
processes=$(ls /proc | grep -Eo '[0-9]{1,7}')
> actualpids.txt


for f in $processes
do
	echo "$f" >> actualpids.txt
done
sort -n -o sortedpids.txt actualpids.txt


printf "\n$red=====[$magenta$bold PROCESSESS $resetcursor$red]===========================================\n"
printf "\n$yellow PID\t PPID\t$cyan UID\t STATE\t FD\t$green NAME\n"
printf "\n$red==============================================================\n\n"

while read p; 
do

	if [ -d /proc/$p ]
       	then
		ppid=$(grep PPid: /proc/$p/status | awk '{print $2}')
		uid=$(grep Uid: /proc/$p/status | awk '{print $2}')
		state=$(grep State: /proc/$p/status | awk '{print $2}')
		fd=$(ls /proc/$p/fdinfo | wc -l)
		name=$(grep Name: /proc/$p/status | awk '{print $2}')
	fi
	
	printf "$yellow $p\t $ppid\t"
	printf "$cyan $uid\t $state\t $fd\t"
	printf "$green $name\n"
       	
done < sortedpids.txt

printf "\n$red==============================================================$resetcursor\n\n"
