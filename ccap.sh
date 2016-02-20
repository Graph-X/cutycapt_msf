#!/bin/bash
##############################################################################################################
#  ccap.sh
#  A small shell script to take the output from your cutycapt.rc resource script and go collect the pictures
#  written by: @GraphX
#  TODO: combine cutycapt and ccap into one resource script and save images as loot or make it an aux module
#       
##############################################################################################################
THREADS=8
if [ $# != 2 ]; then
	echo "Usage: $0 <file> </path/to/dump/to/>"
	exit 1;
fi
fname=$1
cd $2
cat $fname | while read LINE; do
ofile=$(echo $LINE | cut -d "/" -f3- | cut -d "/" -f1 | sed 's/:/_/')
echo "[*] Capturing $LINE"
/usr/bin/cutycapt --url=$LINE --out=$ofile.png &
while (( $(jobs | wc -l) >= $THREADS )); do
sleep 0.1
jobs > /dev/null
done
done 
