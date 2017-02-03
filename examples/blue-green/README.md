# Blue-Green Deployments

Walkthrough of a blue-green deployment with Kubernetes.

## Deploy
Deploy the initial version 'v1' of a website.
```
kubectl apply -f deployments/v1
```

## Verify Version is Live
Find the NodePort where the app is running.  
Run `kubectl get svc` and find the node port number.

In a new terminal window, run the following (using the Cluster IP and NodePort) to display the version -
updating every 0.5 seconds.
```
while true; do curl http://<CLUSTER_IP>:<NODE_PORT>/version; sleep .5; done
```

## Deploy Next Version
This will deploy 'v2' of the website, but will not be available until
the service is updated in next step.
```
kubectl apply -f deployments/v2/helloworld-v2.yaml
```

## Update the Service to Point to v2 Version
While running the next command, you can watch the terminal window
outputting the version url from the web app.
```
kubectl apply -f deployments/v2/helloworld-service-v2.yaml
```

## TODO: Remove the previous version
Use `kubectl` to query with labels to find version: v1

## Tear Down Environment
To remove the services, deployments, and replica sets created, run the following:
```
kubectl delete service,deployment,rs hello-app
```
