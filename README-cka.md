# k8s-CKAD (Kubernetes)
k8s-CKAD traing for the certification (Kubernetes)

References https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

Playground for testing and practing, online cluster:
- https://killercoda.com/playgrounds/scenario/cka
- https://killer.sh
- https://killercoda.com

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
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
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
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd
sudo swapoff -a # Swap disabled. You MUST disable swap in order for the kubelet to work properly.
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```


#### Update the apt package index and install packages needed to use the Kubernetes apt repository:
```
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl
```

#### (2) Download the Google Cloud public signing key:
```
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
# or curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
```

#### (3) Add the Kubernetes repository list apt repository: (one way)
```
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

```

#### (3) Add the Kubernetes repository list apt repository: (second way)
```
Add Kubernetes to repository list:

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
#deb https://apt.kubernetes.io/ kubernetes-xenial main
deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main
EOF
```


#### (4) Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:
```
sudo apt-get update
KUBE_COMPONENT_VERSION=1.20.1-00
sudo apt-get install -y kubelet=$KUBE_COMPONENT_VERSION kubeadm=$KUBE_COMPONENT_VERSION kubectl=$KUBE_COMPONENT_VERSION
sudo apt-mark hold kubelet kubeadm kubectl # prevent automatic update 
```

### (On the control plane) Initialise the cluster
CIDR RANGE for pods
```
sudo kubeadm init --pod-network-cidr 192.168.0.0/16
```

#### Set kubectl access from the control plane:
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

#### test the cluster 
```
kubectl version
```
#### Install the Calico Network Add-On
```
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```


#### Get the token from the control plane to run on the worker-nodes to join the cluster as a worker
```
kubeadm token create --print-join-command
```


#### Display/show/get all the kubernetes worker-nodes joined and the roles assigned to them
```
kubectl get nodes
```



#### To remove a worker-nodes from the cluster 
```
# Find the nodes with
kubectl get nodes
# Drain it with "all pods will be taking down"
kubectl drain NODE-NAME --ignore-daemonsets --force
# Delete it with 
kubectl delete node "NODE-NAME" 
# If using kubeadm, run on “NODE-NAME” itself 
kubeadm reset
```
