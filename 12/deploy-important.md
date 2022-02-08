Use Namespace project-tiger, create a Deployment named `deploy-important` with label `id=very-important` (the Pods should also have this label) and 3 replicas.
With two containers, `container1` image `nginx:1.17.6-alpine` second one `container2` with image `kubernetes/pause`.
There should be only ever one Pod of that Deployment running on one worker node. 
The third Pod won't be scheduled, unless a new worker node will be added.
In a way we kind of simulate the behaviour of a DaemonSet here, but using a Deployment and a fixed number of replicas.


##### kubectl create deployment deploy-important --image=nginx:1.17.6-alpine -n project-tiger --dry-run=client -o yaml > deploy-important.yaml

```
# Modify accordingly with the description above
---
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    id: very-important
  name: deploy-important
  namespace: project-tiger
spec:
  replicas: 3
  selector:
    matchLabels:
      id: very-important
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        id: very-important
    spec:
      containers:
      - image: nginx:1.17.6-alpine
        name: container1
      - image: kubernetes/pause
        name: container2
        resources: {}
      affinity:                                             # add
        podAntiAffinity:                                    # add
          requiredDuringSchedulingIgnoredDuringExecution:   # add
          - labelSelector:                                  # add
              matchExpressions:                             # add
              - key: id                                     # add
                operator: In                                # add
                values:                                     # add
                - very-important                            # add
            topologyKey: kubernetes.io/hostname             # add
status: {}
```
