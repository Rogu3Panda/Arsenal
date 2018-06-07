#!/bin/bash
options_found=0
echo ""
echo "Nmap Parser"
echo "Version 1.0"
echo "Written by Rogu3Panda"
echo ""
echo "Script Purpose: Clean Nmap Output"
echo ""

while getopts ":ht:o:" opt;do

  options_found=1

    case $opt in
	t)
	  TARGET_FILE=${OPTARG}
	    if [ ${TARGET_FILE: -6} != ".gnmap" ];then
		echo "[*] Error: Please enter in a file containing targets with a .gnmap extension"
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
	  echo "Usage: ./nmap_parser.sh -t <target_file> [options]"
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

egrep -v "^#|Status: Up" $TARGET_FILE | tr ',' '\n' | tr '\t' '\n' | grep -e Host -e open | tr '///' ',' | tr -s ',' | tr ' ' '\n'| sed '/^\s*$/d' | tr ',' ' ' 2>&1 | tee -a $OUTPUT_FILE
exit 0
