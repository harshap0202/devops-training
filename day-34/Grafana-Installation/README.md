# Installing Grafana on Ubuntu Server

## Following official documentation

```bash
# Install the prerequisite packages:
sudo apt-get install -y apt-transport-https software-properties-common wget

# Import the GPG key:
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

# To add a repository for stable releases, run the following command:
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
```

![alt text](<img/Screenshot from 2024-08-29 11-57-53.png>)

```bash
# Updates the list of available packages
sudo apt-get update

# To install Grafana OSS, run the following command:
sudo apt-get install grafana
```

![alt text](<img/Screenshot from 2024-08-29 11-58-56.png>)

## Verifying installation

```bash
sudo systemctl start grafana-server.service

sudo systemctl status grafana-server.service
```

![alt text](<img/Screenshot from 2024-08-29 12-00-05.png>)

## UI Access

![alt text](<img/Screenshot from 2024-08-29 12-00-21.png>)

![alt text](<img/Screenshot from 2024-08-29 12-00-48.png>)

## Installing Prometheus and Installing Node-Exporter

 - Prometheus installed and running
![alt text](<img/Screenshot from 2024-08-29 12-21-17.png>)
![alt text](<img/Screenshot from 2024-08-29 12-24-47.png>)

 - Node Exporter installed and running
![alt text](<img/Screenshot from 2024-08-29 12-21-34.png>)
![alt text](<img/Screenshot from 2024-08-29 12-22-51.png>)

## Configuring Prometheus with Grafana

 - Adding prometheus data source in grafana
![alt text](<img/Screenshot from 2024-08-29 12-44-31.png>)

 - Running simple metrics promql query
![alt text](<img/Screenshot from 2024-08-29 12-43-15.png>)