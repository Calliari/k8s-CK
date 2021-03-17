# k8s-CKAD (Kubernetes)
k8s-CKAD traing for the certification (Kubernetes)

References https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/



### (This need to be done in all nodes and control node as well)
#### Letting iptables see bridged traffic 
```
# containerd
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Setup required sysctl params, these persist across reboots.
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
```

```
General for default container
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

# Setup required sysctl params, these persist across reboots.
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
```


#### (1) Install the container runtime (containerd in this case) and add containerd's configuration
```
sudo apt-get update && sudo apt-get install -y containerd
mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd
sudo swapoff -a # Swap disabled. You MUST disable swap in order for the kubelet to work properly.
```


#### Update the apt package index and install packages needed to use the Kubernetes apt repository:
```
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl
```

#### (2) Download the Google Cloud public signing key:
```
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
```

#### (3) Add the Kubernetes apt repository:
```
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
```


#### (4) Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:
```
sudo apt-get update
sudo apt-get install -y kubelet=1.20.1-00 kubeadm=1.20.1-00 kubectl=1.20.1-00
sudo apt-mark hold kubelet kubeadm kubectl # prevent automatic update 
```

### (On the control plane) Initialise the cluster
CIDR RANGE for pods
```
sudo kubeadm init --pod-network-cidr 192.168.0.0/16
```



