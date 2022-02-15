<b>
Find the "Issuer" and "Extended Key Usage" values of the cluster2-worker1:
kubelet client certificate, the one used for outgoing connections to the `kube-apiserver`.
kubelet server certificate, the one used for incoming connections from the `kube-apiserver`.
Write the information into file `/opt/course/23/certificate-info.txt`.
Compare the "Issuer" and "Extended Key Usage" fields of both certificates and make sense of these.
</b>

#### Client certificate
```
# check where the certificates are:
ps aux | grep kubelet # look at the dir '--config=/var/lib/kubelet/'

# check the client cert in the node 'Issuer'
openssl x509 -text -in /var/lib/kubelet/pki/kubelet-client-current.pem | grep -i 'issuer'
    Issuer: CN=kubernetes
# check the client cert in the node 'Extended Key Usage'
openssl x509 -text -in /var/lib/kubelet/pki/kubelet-client-current.pem | grep -i 'Extended Key Usage' -A1
    X509v3 Extended Key Usage: TLS Web Client Authentication

```

#### Server certificate
```
# check the server cert in the node 'Issuer'
openssl x509 -text -in /var/lib/kubelet/pki/kubelet.crt | grep -i 'issuer'
    Issuer: CN=node2-ca@1643744159
# check the server cert in the node 'Extended Key Usage'
openssl x509 -text -in /var/lib/kubelet/pki/kubelet.crt | grep -i 'Extended Key Usage' -A1
    X509v3 Extended Key Usage: TLS Web Server Authentication
```


We see that the server certificate was generated on the worker node itself and the client certificate was issued by the Kubernetes api. The "Extended Key Usage" also shows if its for client or server authentication.
More about this: https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-tls-bootstrapping
