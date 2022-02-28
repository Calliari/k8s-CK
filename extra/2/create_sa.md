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
