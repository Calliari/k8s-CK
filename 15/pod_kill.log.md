#### Kill the `kube-proxy` Pod running on node cluster2-worker1 and write the events this caused into /opt/course/15/pod_kill.log.

##### get the `kube-proxy` running in nodes
```
kubectl get pods -A -o wide | grep 'cluster2-worker'
```

##### Kill the `kube-proxy` Pod
```
kubectl delete pod kube-proxy-8lhzc -n kube-system
```
