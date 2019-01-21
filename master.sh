#!/bin/bash
options_found=0
echo ""
echo "Master Check Script"
echo "Version 2.0.0"
echo "Written by TrashPandaz"
echo ""
echo "Script Purpose: Provides Template for help, file input, file output, and port options for new scripts."
while getopts ":ht:o:p:" opt;do

  options_found=1

    case $opt in
	p)
		PORT_FILE=${OPTARG}
	;;
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
	rpcclient -U "" -N $ip 2>&1 | tee -a $OUTPUT_FILE
done
exit 0
