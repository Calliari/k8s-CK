#### Create a new ServiceAccount `processor` in Namespace `project-hamster`
```
kubectl create namespace project-hamster
kubectl create serviceaccount processor
```

#### Create a `Role` and `RoleBinding`, both named `processor` as well. These should allow the new `SA` to only create `Secrets` and `ConfigMaps` in that Namespace. verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
```
# get the dry-run examples from - kubectl create role -h
kubectl create role processor -n project-hamster --verb=create --resource=secrets,configmaps --dry-run=client -o yaml

# get the dry-run examples from - kubectl create rolebinding -h
kubectl create rolebinding processor -n project-hamster --role=processor --serviceaccount=project-hamster:processor --dry-run=client -o yaml
```

#### Test our RBAC setup we can use `kubectl auth can-i` with options to check 
```
kubectl auth can-i -h # examples
kubectl options # for options and Username to impersonate for the operation
```

Like:
```
k -n project-hamster auth can-i create secret --as system:serviceaccount:project-hamster:processor

k -n project-hamster auth can-i create configmap --as system:serviceaccount:project-hamster:processor

k -n project-hamster auth can-i create pod --as system:serviceaccount:project-hamster:processor

k -n project-hamster auth can-i delete secret --as system:serviceaccount:project-hamster:processor

k -n project-hamster auth can-i get configmap --as system:serviceaccount:project-hamster:processor
```

