# Hello World Example


View currently running Pods.
```
kubectl -n demo get pods
```


### Create Deployment

```
kubectl -n demo apply -f deployments/helloworld-v1.yaml
```

You can view the status of the pods by running:
```
kubectl -n demo get pods
```

Add the wide output flag to see the nodes:
```
kubectl -n demo get pods -o wide
```

Display services with wide output to view external address:
```
kubectl -n demo get svc -o wide
```

Verify app is running at:  http://[CLUSTER_IP]:[PORT]

View version info of the running app at: http://[CLUSTER_IP]:[PORT]/version

When using LoadBalancer instead of NodePort, a Load Balancer will be created and you can
use that URL and the port specified in the service.

### Scale

Scale the application to 4 replicas
```
kubectl -n demo scale deployment hello-world --replicas=3
```

View the pods created:
```
kubectl get pods -o wide
```

See the labels:
```
kubectl get pods --show-labels=true
```

### Update the Image

You can run the following in a separate terminal to see the version numbers change as the update is rolled out.
```
while true; do curl http://[CLUSTER_IP]:[PORT]/version; sleep .5; done
```

Run the update:
```
kubectl -n demo apply -f deployments/helloworld-v2.yaml
```

You should see the version number change as the rolling update takes place.

### Rollback the Update
```
kubectl rollout undo deployment/hello-world
```

### Delete the deployment:
```
kubectl -n demo delete service,deployment hello-world
```


## Without Configuration Files
A simple way to launch containers without using a configuration file
```
kubectl run hello-world --image=jdeskins/hello-node:1.0 --port=8080
```

Allow the service to be accessible behind a load balancer:
```
kubectl expose deployment hello-world --type="LoadBalancer"
```


### Update the Image

You can run the following in a separate terminal to see the version numbers change as the update is rolled out.
```
while true; do curl http://[EXTERNAL_ADDRESS]:8080/version; sleep .5; done
```

Run the update:
```
kubectl set image deployment/hello-world hello-world=jdeskins/hello-node:2.0
```

Delete the deployment:
```
kubectl -n demo delete service,deployment hello-world
```
