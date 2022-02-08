You're ask to find out following information about the cluster k8s-c1-H:

How many master nodes are available?
How many worker nodes are available?
What is the Service CIDR?
Which Networking (or CNI Plugin) is configured and where is its config file?
Which suffix will static pods have that run on cluster1-worker1?


# /opt/course/14/cluster-info
```
1: [command]--> kubectl get nodes | grep master | wc -l 
1: [ANSWER] --> 3
```
```
2: [command]--> kubectl get nodes | grep 'node' | wc -l
2: [ANSWER] --> 2
```
```
3: [command]--> cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep range
3: [ANSWER] --> 10.96.0.0/12
```
```
4: [command]--> ls -lsa /etc/cni/net.d/ && sudo cat /etc/cni/net.d/* | grep -i 'cni'
4: [ANSWER] --> calico, /etc/cni/net.d/10-calico.conflist
```
```
5: [command]--> The suffix is the node hostname with a leading hyphen, to check the nodes hostname (`$ kubectl get nodes `)
5: [ANSWER] --> -cluster1-worker1
```
