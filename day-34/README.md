# Deploying a Kubeadm Cluster

## Steps: 
### Deploy two EC2 instances 
 - T2.medium for Control Node
 - T2.micro for Worker Node

### Log in to Control Node and Worker Node and install Packages

 - Create the Configuration File for containerd:
```bash
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
```

 - Load the Modules:
```bash
sudo modprobe overlay
sudo modprobe br_netfilter
```

Set the System Configurations for Kubernetes Networking:
```bash
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo sysctl --system
```

![alt text](<img/Screenshot from 2024-08-29 11-24-53.png>)

 - Containerd
```bash
# Install containerd:
sudo apt-get update && sudo apt-get install -y containerd.io

# Create the Default Configuration File for containerd:
sudo mkdir -p /etc/containerd

# Generate the Default containerd Configuration and Save It:
sudo containerd config default | sudo tee /etc/containerd/config.toml

# Restart containerd:
sudo systemctl restart containerd

# Verify that containerd is Running:
sudo systemctl status containerd

# Disable Swap:
sudo swapoff -a
```

![alt text](<img/Screenshot from 2024-08-29 11-25-33.png>)

 - Kubernetes
```bash
# Install Dependency Packages:
sudo apt-get update && sudo apt-get install -y apt-transport-https curl

# Download and Add the GPG Key:
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.27/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add Kubernetes to the Repository List:
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.27/deb/ /
EOF

# Update the Package Listings:
sudo apt-get update

# Install Kubernetes Packages:
sudo apt-get install -y kubelet kubeadm kubectl

# Turn Off Automatic Updates:
sudo apt-mark hold kubelet kubeadm kubectl
```
 - Kubernetes installed on Master node
![alt text](<img/Screenshot from 2024-08-29 11-26-55.png>)

 - Kubernetes installed on Worker node
![alt text](<img/Screenshot from 2024-08-29 11-31-57.png>)

### Initialize the Cluster

 - On the Control Plane Node, Initialize the Kubernetes Cluster:
```bash
sudo kubeadm init --pod-network-cidr 192.168.0.0/16 --kubernetes-version 1.27.11
```

![alt text](<img/Screenshot from 2024-08-29 11-44-27.png>)

 - Set kubectl Access:
```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

 - Join command on worker node 
```bsah
sudo kubeadm join xxx.xx.xx.xxx:xxxx --token byctgb.xxxxxxxxxxxxxxxx         --discovery-token-ca-cert-hash sha256:xxxxxxxxxxxxxxxx 
```

![alt text](<img/Screenshot from 2024-08-29 11-32-34.png>)