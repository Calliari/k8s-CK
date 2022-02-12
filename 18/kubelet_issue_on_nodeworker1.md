There seems to be an issue with the kubelet not running on cluster3-worker1. 
Fix it and confirm that cluster has node cluster3-worker1 available in Ready state afterwards. 
You should be able to schedule a Pod on cluster3-worker1 afterwards.
Write the reason of the issue into /opt/course/18/reason.txt.

```
# identify in which node the issue is on
kubectl get node | grep 'NotReady'

# ssh into that node
ssh cluster3-worker1

# check the kubelet status
sudo systemctl status kubelet

# try to restart it
sudo systemctl restart kubelet
# issue
# /usr/local/bin/kubelet: No such file or directory

# check the path with CMD: whereis kubelet
kubelet: /usr/bin/kubelet

# After identify the path was wrong, correcting it looking from the status where is show the service file at 'sudo systemctl status kubelet':
#  Drop-In: /etc/systemd/system/kubelet.service.d
#           └─10-kubeadm.conf


# Fix it
vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf # fix
# Restart it
sudo systemctl daemon-reload && sudo systemctl restart kubelet
```
