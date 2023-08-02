# TZDevops
 Prerequisites: 
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


# Prometheus install
chmod +x monitor-install.sh

./monitor-install.sh

# Expected results:

![изображение](https://github.com/ze0n4ri0t/TZDevops/assets/24235399/b2959374-cfeb-4d18-9b6c-d69d748e0b37)

Log in to the Grapha default user admin default password admin
Add Dasboards with metrics

CPU
rate(node_cpu_seconds_total{instance="localhost:9100",mode!="idle"}[1m])

Memory
node_memory_MemTotal_bytes{instance="localhost:9100"} - node_memory_MemFree_bytes{instance="localhost:9100"} - node_memory_Buffers_bytes{instance="localhost:9100"} - node_memory_Cached_bytes{instance="localhost:9100"}

node_memory_Buffers_bytes{instance="localhost:9100"}

node_memory_Cached_bytes{instance="localhost:9100"}

node_memory_MemFree_bytes{instance="localhost:9100"}

Disk usage
node_filesystem_size_bytes{device="/dev/sda1",instance="localhost:9100"} - node_filesystem_avail_bytes{device="/dev/sda1",instance="localhost:9100"}

node_filesystem_avail_bytes{device="/dev/sda1",instance="localhost:9100"}

Network
rate(node_network_receive_bytes_total{device="ens18"}[5m])

rate(node_network_transmit_bytes_total{device="ens18"}[5m])
# Expected result
![изображение](https://github.com/ze0n4ri0t/TZDevops/assets/24235399/f3a129a4-0a1d-4f21-b629-05e871590204)


