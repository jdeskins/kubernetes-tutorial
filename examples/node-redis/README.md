# Node Redis Demo App

Run Node.js web app with Redis database.

## Build the Docker image
This example uses the jdeskins/node-demo:1.0 Docker image that is publically available.
To build your own, run the following command using the name you want.  Replace the image
name in web-deployment-v1.yaml file.  You will also need to push the image to a public repo.
```
cd src
docker build -t node-demo:1.0 .
```

## Run locally using Docker
```
docker run -d --name redis-master -p 6379:6379 redis:3.0.7-alpine redis-server --appendonly yes
docker run -d --name web -p 8080:8080 --link redis-master:redis-master jdeskins/node-demo:2.0
```

To stop and remove the containers:
```
docker stop web redis-master
docker rm web redis-master
```

## Run in Kubernetes Cluster
Deploy the Redis and frontend web app.  Pointing to the directory will execute all yaml files in that directory.
```
kubectl -n demo create -f deployments
```

## Tail the logs
```
kubectl -n demo logs -f [POD_NAME]
```

## Scale the front-end
```
kubectl -n demo scale deployment node-demo --replicas=3
```

## Cleanup

Remove the running containers:
```
kubectl -n demo delete service,deployment redis-master node-demo
```
