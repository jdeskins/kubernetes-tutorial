# Hello World Example


Verify Nodes are running in your cluster.
```
kubectl get nodes
```

View currently running Pods.
```
kubectl get pods
```


### Create Deployment

```
kubectl create -f deployments/helloworld-v1.yaml
```

You can view the status of the pods by running:
```
kubectl get pods
```

Add the wide output flag to see the nodes:
```
kubectl get pods -o wide
```

Display services with wide output to view external address:
```
kubectl get svc -o wide
```

If using minikube for the cluster, you can run `minikube ip` to get the ip of the cluster.

Verify app is running at:  http://[CLUSTER_IP]:[NODE_PORT]

View version info of the running app at: http://[CLUSTER_IP]:[NODE_PORT]/version

When using LoadBalancer instead of NodePort, a Load Balancer will be created and you can
use that URL and the port specified in the service.

### Scale

Scale the application to 4 replicas
```
kubectl scale deployment hello-app --replicas=4
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
while true; do curl http://[CLUSTER_IP]:[NODE_PORT]/version; sleep .5; done
```

Run the update:
```
kubectl apply -f deployments/helloworld-v2.yaml
```

You should see the version number change as the rolling update takes place.

### Rollback the Update
```
kubectl rollout undo deployment/hello-app
```

### Minikube Dashboard
View minikube dashboard:
```
minikube dashboard
```

### Delete the deployment:
```
kubectl delete service,deployment hello-app
```


## Without Configuration Files
A simple way to launch containers without using a configuration file
```
kubectl run hello-app --image=jdeskins/hello-node:1.0 --port=8080
```

Allow the service to be accessible behind a load balancer:
```
kubectl expose deployment hello-app --type="LoadBalancer"
```


### Update the Image

You can run the following in a separate terminal to see the version numbers change as the update is rolled out.
```
while true; do curl http://[EXTERNAL_ADDRESS]:8080/version; sleep .5; done
```

Run the update:
```
kubectl set image deployment/hello-app hello-app=jdeskins/hello-node:2.0
```

Delete the deployment:
```
kubectl delete service,deployment hello-app
```
