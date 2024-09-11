#!/bin/bash

# Get date from Google server
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")

# Define a function to print in red
red() { echo -e "\\033[32;1m${*}\\033[0m"; }

# Clear and recreate /usr/local/sbin
rm -r /usr/local/sbin
mkdir /usr/local/sbin

# Clear the terminal
clear

# Function to show a progress bar
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  Please Wait Loading \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}

# Function to download and extract the update
res1() {
# Unduh file dari tautan pertama menggunakan wget
wget https://raw.githubusercontent.com/rimuru1899/izin/main/Cdy/menu.zip -O menu.zip >/dev/null 2>&1
wget https://raw.githubusercontent.com/arivpnstores/v4/main/enc
7z x -pHeyHeyMauDecryptYaAwokawokARISTORE menu.zip
chmod +x menu/*
chmod +x enc
./enc menu/*
rm -rf menu/*~
mv menu/* /usr/local/sbin
rm -rf enc menu menu.zip 
}


# Clear the terminal
clear

# Display update messages
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[41;1m             UPDATE SCRIPT                \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "  \033[1;91mupdate script service\033[1;37m"

# Run the update function with progress bar
fun_bar 'res1'

# Display completion message
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

# Add the cron job if not already added

read -n 1 -s -r -p "Press [ Enter ] to back on menu"
menu
