#!/bin/bash

cols=$(tput cols)

for x in $(seq 1 $cols)
do
	echo -en '\033[48;5;1m=\033[0m'
done
