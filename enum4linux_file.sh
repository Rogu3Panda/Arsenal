#!/bin/bash
options_found=0
echo ""
echo "Enum4Linux Against Target File Script"
echo "Version 2.0.0"
echo "Written by SadManatee"
echo ""
echo "Script Purpose: Runs Enum4Linux against a target file, containing all in-scope live machines."
while getopts ":ht:o:" opt;do

  options_found=1

    case $opt in
	t)
		TARGET_FILE=${OPTARG}
		if [ ${TARGET_FILE: -4} != ".txt" ];then
		echo "[*] Error: Please enter in a file containing targets with a .txt extension"
			exit 1
		fi
	;;
         o)
		OUTPUT_FILE=${OPTARG}
		if [ ${OUTPUT_FILE: -4} != ".txt" ];then
		echo "[*] ERROR: Please enter in a output file"
		exit 1
		fi
	;;
	h)
		echo "Help Command"
		echo "Usage: ./SMB_Null.sh [options]"
		echo "Options:"
		echo "-t <Target_File.txt>"
		echo "-o <Output_File.txt>"
		exit 1
	;;
    esac
done

if ((!options_found));then
	echo ""
	echo "Please enter in the appropriate optoins"
	exit 0
fi

for ip in $(cat $TARGET_FILE);do
	#THIS IS WHERE YOU PUT IN YOUR SCRIPT COMMANDS
	echo "LOREM IPSON" 2>&1 | tee -a $OUTPUT_FILE
	enum4linux $ip 2>&1 | tee -a $OUTPUT_FILE
done
exit 0
