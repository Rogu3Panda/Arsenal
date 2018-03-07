#!/bin/bash
#Setting Variables
options_found=0
echo ""
echo "Insecure Service Finder"
echo "Version 1.10.2"
echo "Written By: Rogu3Panda"
echo ""
echo "	Attempts to Connect to Target Ports 21, 23, and 80 on target hosts"
echo "		Options:"
echo "		-t <target_file>"
echo "		-o <output_file>"
echo ""
while getopts ":ht:o:p:" opt; do
    options_found=1
        case $opt in
	    t)
		# ENABLE Next Line FOR DEBUGGGING
		#echo "-t was triggered TARGETFILE: $OPTARG">&2
		TARGET_FILE=${OPTARG}
		if [ ${TARGET_FILE: -4} != ".txt" ]
			then
				echo "[*] ERROR: Please enter in a target file name with a .txt extension"
				exit 1
		fi
		;;
	    o)
		# ENABLE Next Line FOR DEBUGGGING
		# echo "-o was triggered Outputfile: $OPTARG">&2
		OUTPUT_FILE=${OPTARG}
		if [ ${OUTPUT_FILE: -4} != ".txt" ]
			then
				echo "[*] ERROR: Please enter in a output file name with a .txt extension"
				exit 1
		fi
		;;
	    #p)
		# ENABLE Next Line FOR DEBUGGGING
		#echo "-p was triggered PORTS: $OPTARG">&2
		#PORTS=${OPTARG}
		#;;
	    h)
		echo "Usage ./InsecureServices -t <target_file> -o <output_file> -p <ports>"
		exit 1
		;;
	    \?)
      		echo ""
		echo "Invalid option: -$OPTARG" >&2
      		exit 1
      		;;
       	    :)
		echo ""
      		echo "Option -$OPTARG requires an argument." >&2
      		exit 1
      		;;
	esac
    done
#
#Check if options have been supplied
#
if ((!options_found));then
    echo ""
    echo "Please enter in the appropriate options"
    exit 0
fi
#
# Pulling IP's out of target file and then running netcat against them for the particular port.
#
for ip in $(cat $TARGET_FILE);do
    #
    # ENABLE Line FOR DEBUGGGING echo ping $ip 2>&1 | tee $OUTPUT_FILE
    #
    nc -nvv -w 1 -z $ip 21 23 80 2>&1 | tee -a $OUTPUT_FILE
done

#Splice Output Variable
#Keeping everything before the .extension
output=${OUTPUT_FILE%.*}
#
#
#Pulling out information - FTP Servers
#
#
cat $OUTPUT_FILE | sort -u | grep -w 'open' | grep -w 'ftp' > "$output"_ftp.txt
#
#
#Pulling out information - Telnet Servers
#
#
cat $OUTPUT_FILE | sort -u | grep -w 'open' | grep -w 'telnet' > "$output"_telnet.txt
#
#
#Pulling out information - HTTP Servers
#
#
cat $OUTPUT_FILE | sort -u | grep -w 'open' | grep -w 'http' > "$output"_http.txt

mkdir $output

mv $output*.* $output

cat $output/*.* | grep -w 'open' | sort -u >> "$output"/insecure_services.txt
#
#
#Begin FTP Anonymous checks
#
#
echo "Would you like to check for FTP Anonymous?"
echo ""
echo "Would you like to check for Telnet???"
echo ""
echo "[*] Screenshotting all HTTP Services"
echo ""
echo "Starting EyeWitness"
EyeWitness=$(locate EyeWitness.py)
cat "$output"/"$output"_http.txt | cut -d '[' -f2 | cut -d ']' -f1 > "$output"/EyeWitness_targets.txt
cd "$output"
python $EyeWitness --web --only-ports 21,80 -f EyeWitness_targets.txt
cd ..

echo "Script Completed"
echo ""
echo "Happy Hunting"
#echo $EyeWitness
#End of File
exit 0
