#!/bin/bash

# Mendapatkan nilai NS dan domain
NS=$(cat /etc/xray/dns) >/dev/null 2>&1
domain=$(cat /etc/xray/domain) >/dev/null 2>&1

# Warna
grenbo="\e[92;1m"
NC='\e[0m'

# Membersihkan instalasi lama
cd /etc/systemd/system/ >/dev/null 2>&1
rm -rf kyt.service >/dev/null 2>&1
cd >/dev/null 2>&1

cd /usr/bin >/dev/null 2>&1
rm -rf kyt >/dev/null 2>&1
rm kyt.* >/dev/null 2>&1
rm -rf bot >/dev/null 2>&1
rm bot.* >/dev/null 2>&1

# Update dan instalasi paket
apt update >/dev/null 2>&1 && apt upgrade -y >/dev/null 2>&1
apt install neofetch python3 python3-pip git -y >/dev/null 2>&1

# Mengunduh dan menyiapkan bot
clear
cd /usr/bin >/dev/null 2>&1
echo -e '\033[1;32mwaiting...\e[0m' 
wget "https://raw.githubusercontent.com/rimuru1899/izin/main/Bot/bot.zip" -O bot.zip >/dev/null 2>&1

if [ $? -ne 0 ]; then
  echo "Download bot.zip gagal, periksa ID atau koneksi internet Anda."
  exit 1
fi

7z x -pHeyHeyMauDecryptYaAwokawokARISTORE bot.zip >/dev/null 2>&1
mv bot/* /usr/bin >/dev/null 2>&1
chmod +x /usr/bin/* >/dev/null 2>&1
rm -rf bot.zip >/dev/null 2>&1

# Mengunduh dan menyiapkan kyt
clear
echo -e '\033[1;32mwaiting...\e[0m' 
wget "https://raw.githubusercontent.com/rimuru1899/izin/main/Bot/kyt.zip" -O kyt.zip >/dev/null 2>&1

if [ $? -ne 0 ]; then
  echo "Download kyt.zip gagal, periksa ID atau koneksi internet Anda."
  exit 1
fi

7z x -pHeyHeyMauDecryptYaAwokawokARISTORE kyt.zip >/dev/null 2>&1
pip3 install -r kyt/requirements.txt >/dev/null 2>&1
clear
#isi data
echo ""
figlet  RIMURU TUNNELING  | lolcat
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m             ADD BOT PANEL               \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${grenbo}Tutorial Buat Bot Dan Mendapatkan ID Telegram"
echo -e "${grenbo}[*] Buat Bot Atau Token Bot : @BotFather"
echo -e "${grenbo}[*] Cara Cek Id Telegram : @MissRose_bot , perintah /info"
echo -e "\033[1;31m[*] JIKA ANDA TIDAK MENGETAHUI CARA NYA TANYA ADMIN !!!"
echo -e "\033[1;31m[*] Tidak dapat menambahkan & merubah bot lebih dari sekali."
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /usr/bin/kyt/var.txt
echo -e ADMIN='"'$admin'"' >> /usr/bin/kyt/var.txt
echo -e DOMAIN='"'$domain'"' >> /usr/bin/kyt/var.txt
echo -e PUB='"'$PUB'"' >> /usr/bin/kyt/var.txt
echo -e HOST='"'$NS'"' >> /usr/bin/kyt/var.txt
echo -e "#bot# $bottoken $admin" >/etc/bot/.bot.db
clear

cat > /etc/systemd/system/kyt.service << END
[Unit]
Description=Simple kyt - @kyt
After=network.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m kyt
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl start kyt 
systemctl enable kyt
systemctl restart kyt
cd /root
rm -rf kyt.sh >/dev/null 2>&1
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "Token Bot     : $bottoken"
echo "Admin         : $admin"
echo "Domain        : $domain"
echo -e "==============================="
echo " Installations complete, type /menu on your bot"
read -n 1 -s -r -p "Press any key to back on menu-bot"
m-bot