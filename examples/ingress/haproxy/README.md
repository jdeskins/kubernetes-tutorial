# Kubernetes Ingress

## Examples

https://github.com/kubernetes/ingress/tree/master/examples/deployment/haproxy


### Create TLS Secret
```
openssl req \
  -x509 -newkey rsa:2048 -nodes -days 365 \
  -keyout tls.key -out tls.crt -subj '/CN=localhost'

kubectl create secret tls tls-secret --cert=tls.crt --key=tls.key

rm -v tls.crt tls.key
```


### Create Web App
```
kubectl create -f http-svc.yaml

kubectl create -f default-backend.yaml

kubectl create -f haproxy-ingress.yaml

kubectl create -f ingress.yaml
```

Look for nodePort field next to port: 80.
```
kubectl get svc/haproxy-ingress -oyaml
```

This will hit the default backend because host was not found.
```
curl -i <IP_ADDRESS>:<NODE_PORT>

```

Send host in the header
```
curl -i <IP_ADDRESS>:<NODE_PORT> -H 'Host: foo.bar'
```


### Cleanup
```
kubectl delete service,deployment haproxy-ingress
kubectl delete service,rc http-svc
kubectl delete service,deployment ingress-default-backend
kubectl delete ing app

```
