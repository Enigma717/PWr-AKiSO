#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
cyan=$(tput setaf 6)
white=$(tput setaf 7)

while sleep 1; 
do

	disk_read=$(grep -w sda /proc/diskstats | awk '{print $6}')
	disk_write=$(grep -w sda /proc/diskstats | awk '{print $10}')


	uptime=$(awk '{print $1}' /proc/uptime)
	uptime_days=$(bc <<< "scale=0;$uptime/86000") 
	uptime_hours=$(bc <<< "scale=0;(($uptime/3600)-($uptime_days*24))") 
	uptime_minutes=$(bc <<< "scale=0;(($uptime/60)-($uptime_hours*60))")
	uptime_seconds=$(bc <<< "($uptime-($uptime_days*86000)-($uptime_hours*3600)-($uptime_minutes*60))")


	battery=$(grep POWER_SUPPLY_CAPACITY /sys/class/power_supply/BAT0/uevent | grep -o '[[:digit:]]*')


	load_1m=$(awk '{print $1}' /proc/loadavg)
	load_5m=$(awk '{print $2}' /proc/loadavg)
	load_10m=$(awk '{print $3}' /proc/loadavg)


	memory_total=$(grep MemTotal /proc/meminfo | grep -o '[[:digit:]]*')
	memory_avail=$(grep MemAvailable /proc/meminfo | grep -o '[[:digit:]]*')
	memory_used=$(bc <<< "scale=1;(($memory_total-$memory_avail)/1024)")
	memory_total=$(bc <<< "scale=1;($memory_total/1024/1024)")


	tput clear
	printf "\n$red=====[$cyan DISK $red]=====================================================\n"
	printf "\n$green   Sectors read: $disk_read || Sectors written: $disk_write \n"
	printf "\n$red=====[$cyan UPTIME $red]===================================================\n"
	printf "\n$green   Days: $uptime_days || Hours: $uptime_hours || Minutes: $uptime_minutes || Seconds: $uptime_seconds\n"
	printf "\n$red=====[$cyan BATTERY $red]==================================================\n"
	printf "\n$green   Capacity: $battery%%\n"
	printf "\n$red=====[$cyan SYSTEM LOAD $red]==============================================\n"
	printf "\n$green   1 minute: $load_1m || 5 minutes: $load_5m || 10 minutes: $load_10m\n"
	printf "\n$red=====[$cyan MEMORY $red]===================================================\n"
	printf "\n$green   Used memory: $memory_used MiB/$memory_total GiB\n"
	printf "\n$red==================================================================$white\n"

done
