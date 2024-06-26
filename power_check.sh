#!/bin/bash

script_path="$0"
script_path=$(dirname $(readlink -f $0))
lock_file="$script_path/.lock"
log_file="$script_path/power.log"

power_supply=`upower -i /org/freedesktop/UPower/devices/DisplayDevice |grep power |awk '{print $3}'`

if [ "$power_supply" = "yes" ]; then
	echo '电源供电'
	if [ -f "$lock_file" ]; then
		# 已恢复供电
		echo "********************************************" >> $log_file
		date >> $log_file
		echo "供电恢复" >> $log_file
		rm $lock_file
	fi

else
	if [ -f "$lock_file" ]; then
		echo "已记录：停电"
	else
		touch $lock_file
		echo "********************************************" >> $log_file
		date >> $log_file
		echo "停电中" >> $log_file
	fi
fi
