# Investigation on the cluster set up:

===========================================================
kubelet: [TYPE]
kube-apiserver: [TYPE]
kube-scheduler: [TYPE]
kube-controller-manager: [TYPE]
etcd: [TYPE]
dns: [TYPE] [NAME]
-------------------------------------------
# Choices of [TYPE] are: 
not-installed
process
static-pod
pod
===========================================================
####### Commnads
#### find processes
ps aux | grep kubelet 

#### check manifest set up
find /etc/systemd/system/ | grep kube
find /etc/systemd/system/ | grep etcd

#### check pods runnig in master and on the namespace 'kube-system'
kubectl -n kube-system get pod -o wide | grep master1

# check pods runnig that are no 'static-pod' (usually pods that ends with differents charactres but start with the same name), i.e:
coredns-78fcd69978-mscsz                   1/1     Running   1 (48m ago)   23h
coredns-78fcd69978-zfmcd                   1/1     Running   1 (48m ago)   23h

## how they (coredns-78fcd69978-***) are managed ? 
kubectl -n kube-system describe pod coredns-78fcd69978-zfmcd | grep Controlled
# Controlled By:  ReplicaSet/coredns-78fcd69978 # looks like another object ending with differents charactres but start with the same name

## how they (ReplicaSet/coredns-***) are managed ?
kubectl describe ReplicaSet/coredns-78fcd69978 -n kube-system | grep Controlled
Controlled By:  Deployment/coredns # ahaa, now I found out that it's managed by 'coredns' with ReplicaSet and is controlled via a "Deployment" object.


So the answer will be:
===========================================================
kubelet: process
kube-apiserver: static-pod
kube-scheduler: static-pod
kube-scheduler-special: static-pod 
kube-controller-manager: static-pod
etcd: static-pod
dns: pod coredns
