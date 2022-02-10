##### Create a Pod on the namespace `project-tiger` named `tigers-reunite` of image `httpd:2.4.41-alpine` with labels `pod=container` and `container=pod`
```
kubectl run tigers-reunite --image=httpd:2.4.41-alpine --labels='pod=container','container=pod' -n project-tiger --dry-run=client -o yaml
```

##### Check in what node where pod `tigers-reunite` is running
```
kubectl get pods -n project-tiger -o wide | grep 'tigers-reunite'
```

##### SSH into the node to get the container ID
```
ssh node1
sudo crictl ps | grep tigers-reunite
```

##### With `crictl`: write the ID of the `container` and the info.runtimeType into `/opt/course/17/pod-container.txt`
```
ssh node1
sudo crictl inspect bd02102835e50 | grep runtimeType

echo 'bd02102835e50 io.containerd.runc.v2' > /opt/course/17/pod-container.txt
```


##### With `crictl`: write the logs of the container into `/opt/course/17/pod-container.log`
```
ssh node1
crictl logs b01edbe6f89ed > pod-container.log
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 10.44.0.37. Set the 'ServerName' directive globally to suppress this message
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 10.44.0.37. Set the 'ServerName' directive globally to suppress this message
[Mon Sep 13 13:32:18.555280 2021] [mpm_event:notice] [pid 1:tid 139929534545224] AH00489: Apache/2.4.41 (Unix) configured -- resuming normal operations
[Mon Sep 13 13:32:18.555610 2021] [core:notice] [pid 1:tid 139929534545224] AH00094: Command line: 'httpd -D FOREGROUND'

exit
scp node1:~/pod-container.log /opt/course/17/pod-container.log
```
