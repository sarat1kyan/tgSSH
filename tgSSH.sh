#!/bin/bash

echo "Starting the setup..."

# Check if the user is root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

read -p "Enter your Telegram bot token: " bot_token

read -p "Enter your Telegram chat ID: " chat_id

read -p "Enter your SSH Host IP address: " ssh_hostname

read -p "Enter your SSH Host username: " ssh_username

read -s -p "Enter your SSH password: " ssh_password
echo

pkg_managers=("apt-get" "dnf" "yum" "zypper" "pacman" "emerge" "apk" "xbps-install" "opkg")

installed=false
for pkg_manager in "${pkg_managers[@]}"; do
    if command -v "$pkg_manager" >/dev/null 2>&1; then
        case "$pkg_manager" in
            "apt-get")
                sudo apt-get update && sudo apt-get install -y python3 python3-pip sshpass
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
                sudo apk update && sudo apk add python3 py3-pip sshpass
                ;;
            "xbps-install")
                sudo xbps-install -Sy python3 python3-pip sshpass
                ;;
            "opkg")
                sudo opkg update && sudo opkg install python3 python3-pip sshpass
                ;;
        esac
        installed=true
        break
    fi
done

if ! $installed; then
    echo "Error: Unsupported Linux distribution."
    exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
    echo "Python3 not found. Install it manually and try again."
    exit 1
fi

sudo pip3 install telegram paramiko

export BOT_TOKEN="$bot_token"
export CHAT_ID="$chat_id"
export SSH_IP="$ssh_hostname"
export SSH_USERNAME="$ssh_username"
export SSH_PASSWORD="$ssh_password"

python3 tgSSH.py