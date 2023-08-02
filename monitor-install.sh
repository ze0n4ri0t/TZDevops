#!/bin/bash
sudo hostnamectl set-hostname blog.example.com
echo "127.0.0.1       blog.example.com" | sudo tee -a /etc/hosts
sudo useradd \
    --system \
    --no-create-home \
    --shell /bin/false prometheus
	
mkdir ~/tmp
cd ~/tmp
wget https://github.com/prometheus/prometheus/releases/download/v2.46.0/prometheus-2.46.0.linux-amd64.tar.gz
tar xzfv prometheus-2.46.0.linux-amd64.tar.gz

cd ./prometheus-2.46.0.linux-amd64/
sudo mkdir -p /data /etc/prometheus
sudo mv prometheus promtool /usr/local/bin/
sudo chown -R prometheus:prometheus /etc/prometheus/ /data/
sudo mv consoles/ console_libraries/ /etc/prometheus/
sudo mv prometheus.yml /etc/prometheus/prometheus.yml
 
echo "
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/data \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.enable-lifecycle

[Install]
WantedBy=multi-user.target
" | sudo tee /etc/systemd/system/prometheus.service

sudo systemctl daemon-reload
sudo systemctl enable prometheus.service
sudo systemctl start prometheus.service

cd ..
sudo useradd \
    --system \
    --no-create-home \
    --shell /bin/false node_exporter

wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
tar xzfv node_exporter-1.6.1.linux-amd64.tar.gz
sudo mv \
  node_exporter-1.6.1.linux-amd64/node_exporter \
  /usr/local/bin/
  
echo "
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/node_exporter \
    --collector.logind

[Install]
WantedBy=multi-user.target
" | sudo tee /etc/systemd/system/node_exporter.service

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

echo "
  - job_name: node_export
    static_configs:
      - targets: ["localhost:9100"]
" | sudo tee -a /etc/prometheus/prometheus.yml

curl -X POST http://localhost:9090/-/reload


sudo apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_10.0.3_amd64.deb
sudo dpkg -i grafana-enterprise_10.0.3_amd64.deb
sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

cd ~
rm -rf ~/tmp
