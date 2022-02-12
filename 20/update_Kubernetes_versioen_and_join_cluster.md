##### Your coworker said node cluster3-worker2 is running an older Kubernetes version and is not even part of the cluster. 
##### Update Kubernetes on that node to the exact version that's running on cluster3-master1. 
##### Then add this node to the cluster. Use kubeadm for this
```
kubectl drain $NODENAME --ignore-daemonsets --force
ssh $NODENAME

```

##### replace x in 1.22.x-00 with the latest patch version
```
apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.22.x-00 kubectl=1.22.x-00 && \
apt-mark hold kubelet kubectl
```

##### Restart the kubelet:
```
sudo systemctl daemon-reload && sudo systemctl restart kubelet
```

##### Bring the node back online by marking it schedulable:
```
kubectl uncordon $NODENAME
```
