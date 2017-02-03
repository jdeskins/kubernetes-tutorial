#!/bin/bash -e

#kubectl get svc hello-app -o json

# TODO: Change to version
CURRENT_VERSION=$(kubectl get svc hello-app -o 'jsonpath={.spec.selector.version}')

echo "Current version: $CURRENT_VERSION"

# TODO: Update svc to use new version in label selector


# Find the replica set for old version
# kubectl get rs

# COMMAND HISTORY
#  590  kubectl apply -f deployments/helloworld/helloworld-v1.yaml
#  591  kubectl apply -f deployments/helloworld/helloworld-v2.yaml
#  592  kubectl apply -f deployments/helloworld/helloworld-service.yaml
#  593  kubectl apply -f deployments/helloworld/helloworld-service-v1.yaml
#  594  kubectl apply -f deployments/helloworld/helloworld-service-v1.yaml
#  595  kubectl get rs --show-labels
#  596  kubectl get svc --show-labels
#  597  kubectl get svc hello-app -o yaml
#  598  kubectl get rs --show-labels
#  599  kubectl delete service,deployment hello-app
#  600  kubectl get rs --show-labels
#  601  kubectl delete rs hello-app-3643595958

# TO SEE VERSION INFO FROM WEB
# while true; do curl http://192.168.99.100:32508/version; sleep .5; done
