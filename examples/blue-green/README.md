# Blue-Green Deployments

Walkthrough of a blue-green deployment with Kubernetes.

## Deploy
Deploy the initial version 'v1' of a website.
```
kubectl apply -f deployments/helloworld/helloworld-v1.yaml
```

## Verify Version is Live
In a new terminal window, run the following to display the version -
updating every 0.5 seconds.
```
while true; do curl http://192.168.99.100:32508/version; sleep .5; done
```

## Deploy Next Version
This will deploy 'v2' of the website, but will not be available until
the service is updated in next step.
```
kubectl apply -f deployments/helloworld/helloworld-v2.yaml
```

## Update the Service to Point to v2 Version
While running the next command, you can watch the terminal window
outputting the version url from the web app.
```
kubectl apply -f deployments/helloworld/helloworld-service-v2.yaml
```

## TODO: Remove the previous version
Use `kubectl` to query with labels to find version: v1
