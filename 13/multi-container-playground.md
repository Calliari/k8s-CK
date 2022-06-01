Create a Pod named `multi-container-playground` in Namespace `default` with three containers, named `c1`, `c2` and `c3`.
There should be a volume attached to that Pod and mounted into every container, but the volume shouldn't be persisted or shared with other Pods.
- Container `c1` should be of image `nginx:1.17.6-alpine` and have the name of the node where its Pod is running on value available as environment variable `MY_NODE_NAME`.
- Container `c2` should be of image `busybox:1.31.1` and write the output of the date command every second in the shared volume into file `date.log`. You can use `while true; do date >> /your/vol/path/date.log; sleep 1; done` for this.
- Container `c3` should be of image `busybox:1.31.1` and constantly send the content of file `date.log` from the shared volume to stdout. You can use `tail -f /your/vol/path/date.log` for this.

Check the logs of container c3 to confirm correct setup.


##### kubectl run multi-container-playground --image=nginx:1.17.6-alpine -n default --dry-run=client -o yaml > multi-container-playground.yaml


```
# modify to have the volumes, the env variable and the commands accordingly with the container
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: multi-container-playground
  name: multi-container-playground
  namespace: default
spec:
  volumes:
  - name: vol
    hostPath:
      path: /data
  containers:
  - image: nginx:1.17.6-alpine
    name: c1
    env:
    - name: MY_NODE_NAME
      valueFrom:
        fieldRef:
          fieldPath: spec.nodeName
    volumeMounts:
    - name: vol
      mountPath: /data
  - image: busybox:1.31.1
    name: c2
    command: ['/bin/sh', '-c', 'while true; do date >> /data/date.log; sleep 1; done']
    volumeMounts:
    - name: vol
      mountPath: /data
  - image: busybox:1.31.1
    name: c3
    command: ['/bin/sh','-c','tail -f /data/date.log']
    volumeMounts:
    - name: vol
      mountPath: /data
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

#### check the env-variable from the container `c1`
```
kubectl exec -n default multi-container-playground -c c1 -- printenv MY_NODE_NAME
```

#### check the logs from the container `c3`, if the "date" logs have been create on the container `c2` it will be available on the `c3`
```
kubectl logs -n default multi-container-playground -c c3
```
