#### Temporarily stop the kube-scheduler, this means in a way that you can start it again afterwards
##### find the "kube-scheduler" pod first and all its details 
```
$ kubectl get pod -A -o wide | grep -E 'NAME|scheduler'
NAMESPACE       NAME                                       READY   STATUS    RESTARTS      AGE     IP                NODE               NOMINATED NODE   READINESS GATES
kube-system     kube-scheduler-cluster1-master1            1/1     Running   0             14m     172.31.37.190     cluster1-master1   <none>           <none>
```

### With that its probably running on the kubernetes' manifest directory `/etc/kubernetes/manifests`
So just move the file `kube-scheduler.yaml` will stop temporarily stop the kube-scheduler'.
```
mkdir /etc/kubernetes/manifests/stopped-tmp/
mv /etc/kubernetes/manifests/kube-scheduler.yaml  /etc/kubernetes/manifests/stopped-tmp/
```

#### Check the `kube-scheduler` now, its gone "temporarily"!
```
kubectl get pod -A -o wide | grep -E 'NAME|scheduler' 
```
 ##### Create a single Pod named `manual-schedule` of image `httpd:2.4-alpine` on node `cluster2-master1`, Make sure it's running.
```
# kubectl run -h # for help
kubectl run manual-schedule --image=httpd:2.4-alpine --dry-run=client -o yaml > pod-manual-schedule.yml # add the spec.nodeName: cluster1-master1
```
i.e:
```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: manual-schedule
  name: manual-schedule
spec:
  nodeName: cluster1-master1 # added 
  containers:
  - image: httpd:2.4-alpine
    name: manual-schedule
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

##### create the pod, it will run on the master `cluster1-master1`, because scheduer is 'stopped'.
```
kubectl apply -f pod-manual-schedule.yml
```

##### Start the kube-scheduler again, just move the file back `kube-scheduler.yaml` where it was.
```
mv /etc/kubernetes/manifests/stopped-tmp/kube-scheduler.yaml /etc/kubernetes/manifests/
```


##### creating a second Pod named `manual-schedule2` of image `httpd:2.4-alpine` and check if it's running on workernode, not on the master.
```
kubectl run manual-schedule2 --image=httpd:2.4-alpine # it shoud run on the one fo the workernode now as the scheduler is back doing its job.
```



