##### Your coworker said node cluster3-worker2 is running an older Kubernetes version and is not even part of the cluster. 
##### Update Kubernetes on that node to the exact version that's running on cluster3-master1. 
##### Then add this node to the cluster. Use kubeadm for this
```
# from control-plane
kubectl drain $NODENAME --ignore-daemonsets --force
kubeadm token create --print-join-command # save this output
```

##### replace x in 1.22.x-00 with the latest patch version
```
ssh $NODENAME
# from workernode
kubeadm upgrade node

apt-mark unhold kubelet kubectl && apt-get update && \
apt-get install -y kubelet=1.22.x-00 kubectl=1.22.x-00 && \
apt-mark hold kubelet kubectl

# check versions 
kubeadm version
kubectl version
kubelet --version
```

##### Restart the kubelet:
```
# from workernode
sudo systemctl daemon-reload && sudo systemctl restart kubelet
kubeadm join # command output from kubeadm token create ran on the control-plane

```

##### Bring the node back online by marking it schedulable:
```
# from control-plane
kubectl uncordon $NODENAME
```
