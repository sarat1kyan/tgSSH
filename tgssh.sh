#!/bin/bash

banner1() {
  local text="$@"
  local length=$(( ${#text} + 2 ))
  local line=$(printf '%*s' "$length" '' | tr ' ' '-')
  echo "+$line+"
  printf "| %s |\n" "$(date)"
  echo "+$line+"
  printf "|$bold%s$reset|\n" "$text"
  echo "+$line+"
}

banner1 "WELCOME TO THE MAIN INSTALLER, PLEASE MAKE SURE YOU HAVE DOWNLOADED THE tgssh.py FILE"


#clolors
white='\e[1;37m'
green='\e[0;32m'
blue='\e[1;34m'
red='\e[1;31m'
yellow='\e[1;33m' 
echo ""
echo ""
banner() {
	echo -e $'\e[1;33m\e[0m\e[1;37m                                                         \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m      _|                  _|_|_|    _|_|_|  _|    _|     \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m    _|_|_|_|    _|_|_|  _|        _|        _|    _|     \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m      _|      _|    _|    _|_|      _|_|    _|_|_|_|     \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m      _|      _|    _|        _|        _|  _|    _|     \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m        _|_|    _|_|_|  _|_|_|    _|_|_|    _|    _|     \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m                    _|                                   \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m                _|_|                                     \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m                                                         \e[0m'
	
	echo ""    
	echo -e $'\e[1;33m\e[0m\e[1;33m    ██████████\e[0m'"\e[96m██████████"'\e[1;33m\e[0m\e[1;31m██████████\e[0m' '\e[1;32m\e[0m\e[1;32m control you remote server via telegram \e[0m''\e[1;37m\e[0m\e[1;37m \e[0m'                                       
	echo ""
	echo -e $'\e[1;33m\e[0m\e[1;33m  [ \e[0m\e[1;32m Follow on Github :- https://github.com/54R4T1KY4N \e[0m \e[1;32m\e[0m\e[1;33m] \e[0m'
	echo ""
	echo -e $'\e[1;37m\e[0m\e[1;37m    +-+-+-+-+-+-+-+ >>\e[0m'
	echo -e "\e[93m    tgSSH |1|.|2| stable"      
	echo -e $'\e[1;37m\e[0m\e[1;37m    +-+-+-+-+-+-+-+ >>\e[0m' 
	echo ""                                                
}
banner 

# Check if the user is root
if [[ $EUID -ne 0 ]]; then
   banner1 "This script must be run as root"
   exit 1
fi

banner1 "please provide the necessary credentials"

# Prompt for Telegram bot token
read -p "Enter your Telegram bot token: " bot_token

# Prompt for Telegram chat ID
read -p "Enter your Telegram chat ID: " chat_id

# Prompt for SSH hostname
read -p "Enter your SSH hostname: " ssh_hostname

# Prompt for SSH username
read -p "Enter your SSH username: " ssh_username

# Prompt for SSH password
read -s -p "Enter your SSH password: " ssh_password

banner1 "checking if the necesery packages exist..."

# Define the package managers to check for
pkg_managers=("apt-get" "dnf" "yum" "zypper" "pacman" "emerge" "apk" "xbps-install" "opkg")

# Loop through the package managers and install the required packages
for pkg_manager in "${pkg_managers[@]}"
do
    if command -v "$pkg_manager" >/dev/null 2>&1; then
        case "$pkg_manager" in
            "apt-get")
                sudo apt-get update
                sudo apt-get install -y python3 python3-pip sshpass
                ;;
            "dnf")
                sudo dnf install -y python3 python3-pip sshpass
                ;;
            "yum")
                sudo yum install -y python3 python3-pip sshpass
                ;;
            "zypper")
                sudo zypper install -y python3 python3-pip sshpass
                ;;
            "pacman")
                sudo pacman -Syu python python-pip sshpass --noconfirm
                ;;
            "emerge")
                sudo emerge -av dev-lang/python3 dev-python/pip net-misc/sshpass
                ;;
            "apk")
                sudo apk update
                sudo apk add python3 py3-pip sshpass
                ;;
            "xbps-install")
                sudo xbps-install -Sy python3 python3-pip sshpass
                ;;
            "opkg")
                sudo opkg update
                sudo opkg install python3 python3-pip sshpass
                ;;
        esac
        break
        
        else
            banner1 "Error: Unsupported Linux distribution."
            exit 1

    fi
done

if [[ -z $(command -v python3) ]]; then
    banner1 "Python3 not found. Install it manually and try again."
    exit 1
fi

# Install required Python modules
sudo pip3 install telegram paramiko

# Run the Python script with the provided inputs
python3 /path/to/your/python/script.py "$bot_token" "$chat_id" "$ssh_hostname" "$ssh_username" "$ssh_password"
