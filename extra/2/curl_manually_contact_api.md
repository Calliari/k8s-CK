<b>
There is an existing ServiceAccount `secret-reader` in Namespace `project-hamster`. 
Create a Pod of image `curlimages/curl:7.65.3` named `tmp-api-contact` which uses this ServiceAccount. Make sure the container keeps running.
Exec into the Pod and use curl to access the Kubernetes Api of that cluster manually, listing all available secrets. 
You can ignore insecure https connection. Write the command(s) for this into file `/opt/course/e4/list-secrets.sh`.
</b>

```
# show the secret from the project-hamster namespace
kubectl -n project-hamster get secret
```

##### Create a Pod of image `curlimages/curl:7.65.3` named `tmp-api-contact` which uses this ServiceAccount
```
kubectl run tmp-api-contact --image=curlimages/curl:7.65.3 --dry-run=client -o yaml -n project-hamster --command -- sh -c 'sleep 1d' > tmp-api-contact.yaml
vim tmp-api-contact.yaml # and add the ServiceAccount "  serviceAccountName: secret-reader"
```
