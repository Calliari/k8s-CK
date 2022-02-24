##### Make a backup of etcd running on master1 and save it on the master node at /tmp/etcd-backup.db
```
# Find the etcd directory to get the "cacert", "cert" and "key"
cd /etc/kubernetes && find ./ -name etcd

# take the etcd backup
ETCDCTL_API=3 etcdctl snapshot save ./etcd-backup.db \
--cacert /etc/kubernetes/pki/etcd/ca.crt \
--cert /etc/kubernetes/pki/etcd/server.crt \
--key /etc/kubernetes/pki/etcd/server.key
```

##### Then create a Pod of your kind in the cluster
```
kubectl run test-pod --image=nginx
```

##### Finally restore the backup, confirm the cluster is still working and that the created Pod is no longer with us.
```
# Stop all the pods
cd /etc/kubernetes/manifests/
mkdir bkp
mv *.yaml ./bkp/

# use the backups etcd file early created to restore, "make sure the '/var/lib/etcd/member' dir is not there, can be moved to another path.
ETCDCTL_API=3 etcdctl snapshot restore ./etcd-backup.db  --data-dir="/var/lib/etcd" \
--cacert /etc/kubernetes/pki/etcd/ca.crt \
--cert /etc/kubernetes/pki/etcd/server.crt \
--key /etc/kubernetes/pki/etcd/server.key


# Start all the pods after the restore
mv ./bkp/*.yaml /etc/kubernetes/manifests/
```


All the pods should be back excluded the last one created after the snapshot (test-pod)
