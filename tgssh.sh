#!/bin/bash

echo "okaaaay, let's go..."

# Check if the user is root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

echo "please provide the necessary credentials"

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

echo "checking if the necesery packages exist..."

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
            echo "Error: Unsupported Linux distribution."
            exit 1

    fi
done

if [[ -z $(command -v python3) ]]; then
    echo "Python3 not found. Install it manually and try again."
    exit 1
fi

# Install required Python modules
sudo pip3 install telegram paramiko

# Run the Python script with the provided inputs
python3 /path/to/your/python/script.py "$bot_token" "$chat_id" "$ssh_hostname" "$ssh_username" "$ssh_password"
