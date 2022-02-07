On Namespace project-tiger Create a DaemonSet named `ds-important` with image `httpd:2.4-alpine` and labels `id=ds-important` 
and `uuid=18426a0b-5f59-4e10-923f-c0e078e82462`. 
The Pods it creates should request `10 millicore` *cpu* and `10 mebibyte` *memory*. 
The Pods of that DaemonSet should run on all nodes, master and worker.

Template for the from here and twaek the config yam file
https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/

Also a templete from deployment can be used as well and twaek the config yam file
```
k -n project-tiger create deployment --image=httpd:2.4-alpine ds-important --dry-run=client -o yaml
```
