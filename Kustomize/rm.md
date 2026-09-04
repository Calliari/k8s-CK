To test the base Kustomize run: 
```
# From the dir "Kustomize"
kubectl kustomize ./base
```

To test the dev Kustomize run:
```
kubectl kustomize ./overlays/dev
```

To test the prod Kustomize run:
```
kubectl kustomize ./overlays/prod
```


To apply after checking; 
```
#kubectl apply -k <kustomization path directory>/
kubectl apply -k ./overlays/dev
```
