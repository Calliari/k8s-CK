##### ServiceAccount `secret-reader` object namespace `project-hamster`
```
kubectl get serviceaccounts -n project-hamster

kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: secret-reader
  namespace: project-hamster
EOF

```
##### Test the access 
```
k auth can-i get secret --as system:serviceaccount:project-hamster:secret-reader
```


If the POD need to "get" the secret a (Role and RoleBinding) are needed
```
kubectl create role pod-reader-role --verb=get --resource=secret -n project-hamster -o yaml --dry-run=client
kubectl create rolebinding pod-reader-rolebinding --role=pod-reader-role --serviceaccount=project-hamster:secret-reader -o yaml -n project-hamster --dry-run=client
```
