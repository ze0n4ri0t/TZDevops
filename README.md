# TZDevops
login to the host

install git and clone repo

sudo apt install git -y



sudo addgroup docker

sudo usermod -aG docker $USER

make sudo to run without password promt

(Optional)
run visudo and add line "user    ALL=(ALL) NOPASSWD:ALL" where user is a username of the user that logged in, and who will run script

chmod +x script.sh

!!!! Relogin !!!! (User group setting not will be applied without it)

Run script 

./script.sh

Edit hosts file, on Windows C:\Windows\System32\drivers\etc\hosts on Linux /etc/hosts

add line: xx.xx.xx.xx blog.example.com where xx.xx.xx.xx is the ip of the host with Wordpress installed

Example:

192.168.4.23	blog.example.com

Expected results

