### ETCD depend on go, so follow the steps below to install go if necessary
```
# Download the go if needed "https://go.dev/doc/install"
curl -L https://go.dev/dl/go1.18.2.linux-amd64.tar.gz -o go.tar.gz

# extract the go into "/usr/local" dir, need sudo
sudo tar -C /usr/local -xzf go.tar.gz

# test "go path" and "go version"
export PATH=$PATH:/usr/local/go/bin

# If go is working save on the PATH "$HOME/.profile"
# get the new PATH 
printenv | grep PATH

echo PATH="${PATH:+${PATH}:}/usr/local/go/bin" >>  ~/.profile
source ~/.profile
```

### If etcd is not installed, run these commands on the control-plane
```
git clone -b v3.5.0 https://github.com/etcd-io/etcd.git
cd etcd
./build.sh

sudo mv etcd /usr/local/
sudo chown -R root:root /usr/local/etcd


# Remove the extra "PATH" in the profile added early and replace it with only one (removing with sed "sed -i '/^PATH=\//d' ~/.profile")
echo PATH="${PATH:+${PATH}:}/usr/local/etcd/bin" >>  ~/.profile
source ~/.profile
etcd --version
```

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

Backup the cluster with etcd
```
# SAMPLE 1 - ETCD snapshot with endpoint
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key snapshot save snapshotdb-bkp

# SAMPLE 2 - ETCD snapshot without endpoint
ETCDCTL_API=3 etcdctl --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key snapshot save snapshotdb-bkp
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
