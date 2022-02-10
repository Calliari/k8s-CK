#### Write a command into /opt/course/15/cluster_events.sh which shows the latest events in the whole cluster, ordered by time. Use kubectl for it.

##### Test the command that shows the latest events in the whole cluster, ordered by time
```
kubectl get events -A --sort-by=.metadata.creationTimestamp
```

##### Now write it to the file:
```
echo 'kubectl get events -A --sort-by=.metadata.creationTimestamp' > /opt/course/15/cluster_events.sh
```
