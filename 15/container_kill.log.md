#### kill the containerd container of the kube-proxy Pod on node cluster2-worker1 and write the events into /opt/course/15/container_kill.log.

##### Get `kube-proxy` pod and thne the conatinerd from the pod by:
```
kubectl describe kube-proxy-8lhzc -n kube-system | grep containerd
```

##### Kill `containerd` conatiner running on the `kube-proxy` by:
```

```
