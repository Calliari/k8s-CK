<b>
Check how long the `kube-apiserver` server certificate is valid on `cluster2-master1`. Do this with `openssl` or `cfssl`. 
Write the exipiration date into `/opt/course/22/expiration`.
Also run the correct `kubeadm` command to list the expiration dates and confirm both methods show the same date.
Write the correct kubeadm command that would renew the apiserver server certificate into `/opt/course/22/kubeadm-renew-certs.sh`.
</b>

```
# with openssl
openssl x509 -text -in /etc/kubernetes/pki/apiserver.crt | grep -i Validity -A2

# with kubeadm
kubeadm certs check-expiration apiserver
```


##### kubeadm command that would renew the apiserver server certificate
```
# for help 
kubeadm certs -h

# to renew apiserver server certificate
kubeadm certs renew apiserver
```
