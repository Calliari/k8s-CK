#### kill the containerd container of the `kube-proxy` Pod on node `cluster2-worker1` and write the events into `/opt/course/15/container_kill.log`.

##### Get `kube-proxy` pod and the the conatinerd from the pod by:
```
kubectl describe kube-proxy-8lhzc -n kube-system | grep containerd
```

##### Kill `containerd` conatiner running on the `kube-proxy` on the node by:
```
# ssh into the node where the contaner is running and get the `conatiner-id`
ssh node2

# check the container running
crictl ps | grep kube-proxy

# Kill the container 
crictl rm -f 1e020b43c4423
```
