# Kubernetes Tutorial

## Examples

With [Docker for Mac (edge release)](https://docs.docker.com/docker-for-mac/kubernetes/) which contains a local kubernetes cluster, you can run these examples on your local machine.
 

### Creating Namespace
Many of the examples use a namespace called `demo`.
If using a different namespace, modify the `-n` parameter to use the proper namespace.

To create the `demo` namespace in your environment, run the following from project root directory:
```
kubectl apply -f examples/namespace-demo.yaml
```

### Deploying
* [HelloWorld Rolling Deployment](examples/helloworld)
* [Node/Redis Deployment](examples/node-redis)
* [Blue-Green Deployments](examples/blue-green)

### Cleanup
```
kubectl delete service,deployment ${APP_NAME}
```
