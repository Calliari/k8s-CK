##### Create a Pod named `secret-pod` of image `busybox:1.31.1` which should keep running for some time on Namespace `secret`. 
##### It should be able to run on master nodes as well, create the proper toleration.
```
kubectl create ns secret
kubectl run secret-pod --image=busybox:1.31.1 -n secret --dry-run=client -o yaml
```

##### There is an existing Secret located at /opt/course/19/secret1.yaml, create it in the `secret` Namespace and mount it readonly into the Pod at `/tmp/secret1`.
```
vim /opt/course/19/secret1.yaml # add the "namespcae: secret" to the file
kubectl create -f 19/secret1.yaml
```

##### Create a new Secret in Namespace `secret` called `secret2` which should contain user=user1 and pass=1234. 
##### These entries should be available inside the Pod's container as environment variables APP_USER and APP_PASS.
```
kubectl create secret2 -n secret
```
