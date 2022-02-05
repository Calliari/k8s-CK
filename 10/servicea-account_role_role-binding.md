#### Create a new ServiceAccount `processor` in Namespace `project-hamster`
```
kubectl create namespace project-hamster
kubectl create serviceaccount processor
```

#### Create a `Role` and `RoleBinding`, both named `processor` as well. These should allow the new `SA` to only create `Secrets` and `ConfigMaps` in that Namespace.
```
# get the dry-run examples from - kubectl create role -h
kubectl create role processor -n project-hamster --verb=create --resource=secrets,configmaps --dry-run=client -o yaml

# get the dry-run examples from - kubectl create rolebinding -h
kubectl create rolebinding processor -n project-hamster --role=processor --serviceaccount=project-hamster:processor --dry-run=client -o yaml
```

#### Test our RBAC setup we can use `kubectl auth can-i`
```
k auth can-i -h # examples

```
