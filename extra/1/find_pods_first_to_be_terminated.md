<b>
  Check all available Pods in the Namespace `project-c13` and find the names of those that would probably be terminated first 
  if the nodes run out of resources (cpu or memory) to schedule all Pods. 
  Write the Pod names into `/opt/course/e1/pods-not-stable.txt`.
</b>



```
# show the pods with the CPU and Memory requests, and those without requests
kubectl -n project-c13 describe pod | grep -E "^(Name:|    Requests:)" -A1
```

##### We see that the Pods of Deployment c13-3cc-runner-heavy don't have any resources requests specified. Hence our answer would be:
```
cat /opt/course/e1/pods-not-stable.txt
c13-3cc-runner-heavy-65588d7d6-djtv9map
c13-3cc-runner-heavy-65588d7d6-v8kf5map
c13-3cc-runner-heavy-65588d7d6-wwpb4map
o3db-0
o3db-1
```
