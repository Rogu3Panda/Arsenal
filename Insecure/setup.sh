#!/bin/bash
#
# Script Ensures all dependent files have been installed
#

echo "Checking for Chris Truncers EyeWitness Program"
echo "Found at: https://github.com/ChrisTruncer/EyeWitness"
echo "EyeWitness is utilized in this program for HTTP Screenshots"
echo ""
#EyeWitness=$(locate EyeWitness.py)
EyeWitness=$(locate asdfasdf.py)
if [ $? -eq 0 ]
	then
		EyeWitness_Exists=Yes
		echo "EyeWitness is already installed on machine"
		echo "[SUCCESS]: Skipping EyeWitness Installation"
	else
		EyeWitness_Exists=No
		echo "[!_Error]: EyeWitness was not discovered"
		echo "[NOTE]: EyeWitness is required for HTTP Capture"
		echo "Would you like to download EyeWitness?"
		echo ""
		echo "Yes or No: "
		read input
		if [ $input == "Yes" ];then
				git clone https://github.com/ChrisTruncer/EyeWitness
				./EyeWitness/setup/setup.sh
		elif [ $input == "No" ]; then
			echo ""
			echo "You have chosen to not install EyeWitness"
			echo ""
			echo "You will not be able to perform HTTP Captures"
		fi
fi
