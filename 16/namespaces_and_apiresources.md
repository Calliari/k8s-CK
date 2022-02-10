#####  Create a new Namespace called `cka-master`.
```
kubectl create namespace cka-master
```

##### Write the names of all namespaced Kubernetes resources (like Pod, Secret, ConfigMap...) into `/opt/course/16/resources.txt`.
```
k api-resources -h # help always good
k api-resources    # shows all
kubectl api-resources --namespaced -o name >  /opt/course/16/resources.txt
```

##### Find the `project-*` Namespace with the highest number of Roles defined in it and write its name and amount of Roles into `/opt/course/16/crowded-namespace.txt`.
```
kubectl get ns

project-c13
project-c14
project-hamster
project-snake 
project-tiger
```

##### check the number of role for each one (passing --no-headers) means no showing the row [NAME STATUS AGE] when the output is diplaied.
```
kubectl get role -n project-c13 --no-headers
kubectl get role -n project-c14 --no-headers
kubectl get role -n project-hamster --no-headers
kubectl get role -n project-snake --no-headers
kubectl get role -n project-tiger --no-headers
```

##### Write its `name` and amount of `Roles` into `/opt/course/16/crowded-namespace.txt`.
```
echo "project-c14 with 300 resources" > /opt/course/16/crowded-namespace.txt
```
