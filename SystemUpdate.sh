#!/bin/bash
echo -e "\n$(date "+%d-%m-%Y --- %T") --- Starting work \n"

if [[ $EUID -ne 0 ]]
then
    RED='\033[0;31m'
    
    echo -e "This script must be run as ${RED}root"
    exit 1
  fi

SYS_ARCH=$(cat /etc/os-release | grep -o -m1 "arch")
#echo "$SYS_ARCH"
SYS_DEBIAN=$(cat /etc/os-release | grep -o -m1 "debian")


if [[ $SYS_ARCH == "arch" ]]
then
	pacman -Syu
	pacman -Qdtq
elif [[ $SYS_DEBIAN == "debian" ]]
then
	apt update
	apt -y upgrade

	apt autoremove
	apt autoclean

else

	echo "I dont Know This System $SYS_ARCH"
fi





echo -e "\n$(date "+%d-%m-%Y --- %T") \t Script Terminated"
