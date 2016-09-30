#!/bin/sh


while :
do
	cat /sys/class/power_supply/BAT0/capacity
	sleep 60
done
