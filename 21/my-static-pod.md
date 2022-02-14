##### Create a Static Pod named `my-static-pod` in Namespace default on `cluster3-master1`. 
##### It should be of image nginx:1.16-alpine and have resource requests for `10m` CPU and `20Mi` memory.
##### Then create a `NodePort` Service named `static-pod-service` which exposes that static Pod on `port 80` and 
##### check if it has Endpoints and if its reachable through the `cluster3-master1` internal IP address. 
##### You can connect to the internal node IPs from your main terminal.
```
kubectl run my-static-pod --image=nginx:1.16-alpine --dry-run=client -o yaml  -n default > my-static-pod.yaml
```

###### Add the request cpu and memory (https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/)
```
  containers:
  - image: nginx:1.16-alpine
    name: my-static-pod
    resources:               # add 
      requests:              # add
        cpu: 10m             # add
        memory: 20Mi         # add
    ports:          
    - containerPort: 80
```

##### chekc if the pod can respond on port :80
```
kubectl exec my-static-pod -- wget --spider  -S 127.0.0.1:80
```

##### Creating a service with --dry-run and tweak the `selector` to match the pod labels
```
kubectl create service nodeport static-pod-service --tcp=80:80 --dry-run=client -o yaml > static-pod-service.yaml
vim static-pod-service.yaml
kubectl create -f  static-pod-service.yaml
```
