# TZDevops

# Prerequisites: 
Debian or Ununtu host

login to the host

install git and clone repo, run commands:

sudo apt install git -y

git clone https://github.com/ze0n4ri0t/TZDevops.git

sudo addgroup docker

sudo usermod -aG docker $USER

(Optional) make sudo to run without password promt

run visudo and add line "user    ALL=(ALL) NOPASSWD:ALL" where user is a username of the user that logged in, and who will run script

!!!! Relogin !!!! (User group setting not will be applied without it)

Run script 

cd TZDevops/

chmod +x script.sh

./script.sh

Edit hosts file, on Windows C:\Windows\System32\drivers\etc\hosts on Linux /etc/hosts

add line: xx.xx.xx.xx blog.example.com where xx.xx.xx.xx is the ip of the host with Wordpress installed

Example:

192.168.4.23	blog.example.com

# Expected results:
![изображение](https://github.com/ze0n4ri0t/TZDevops/assets/24235399/1e5e9856-dde4-4bab-ba5f-1cdbc55ab016)


