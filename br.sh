#!/bin/bash

cols=$(tput cols)
fg_color="black"
bg_color="red"

# Add error code flag? if [ $? = 0 ]; then br -b green; else br $?; fi;

while getopts "b:f:" opt; do
	case $opt in
		b)
			bg_color="$OPTARG"
			;;
		f)
			fg_color="$OPTARG"
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit 1
			;;
		:)
			echo "Option -$OPTARG requires an argument." >&2
			exit 1
			;;
	esac
done

# Shift based on the number of args used
shift $((OPTIND - 1))

case $fg_color in
	black)
		fg_color=30
		;;
	red)
		fg_color=31
		;;
	green)
		fg_color=32
		;;
	yellow)
		fg_color=33
		;;
	blue)
		fg_color=34
		;;
	magenta)
		fg_color=35
		;;
	cyan)
		fg_color=36
		;;
	white)
		fg_color=37
esac

case $bg_color in
	black)
		bg_color=40
		;;
	red)
		bg_color=41
		;;
	green)
		bg_color=42
		;;
	yellow)
		bg_color=43
		;;
	blue)
		bg_color=44
		;;
	magenta)
		bg_color=45
		;;
	cyan)
		bg_color=46
		;;
	white)
		bg_color=47
esac

message=""
# Get the message put together
for current_arg in $@; do
	eval message="\"\$message $current_arg\""
done

if [ ! -z "$message" -a "$message" != " " ]; then
	message="=====[$message ]"
else
	message=""
fi

# Find the length of the message
msg_len=`expr length "$message"`
# Find the total number of ='s needed
total_eq=`expr $cols - $msg_len`
num_eq=$total_eq

# for x in $(seq 1 $num_eq)
# do
# 	printf "\033[${fg_color};${bg_color}m=\033[0m"
# done

printf "\033[${fg_color};${bg_color}m$message\033[0m"

for x in $(seq 1 $num_eq)
do
	printf "\033[${fg_color};${bg_color}m=\033[0m"
done
