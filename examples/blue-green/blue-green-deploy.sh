#!/bin/bash -e


usage="Usage: $(basename "$0") -a <APP_NAME> -f <DEPLOY_FILE> -v <NEW_VERSION>
 Script for blue-green deployment.

Available options are:
    -a  Application name
    -f  Relative path to deploy file (ex: deployments/v2/service.yaml)
    -h  Show this help text
    -v  New version to point existing service
"

# Capture args
while getopts ":a:f:h:v:" opt; do
  case $opt in
    a) APP_NAME="$OPTARG"
    ;;
    f) DEPLOY_FILE="$OPTARG"
    ;;
    h) echo "$usage"
    exit
    ;;
    v) NEW_VERSION="$OPTARG"
    ;;
    \?) echo "$usage" >&2
    exit 1
    ;;
  esac
done

# Verify args
if (( $# != 6 ))
then
  echo "$usage"
  exit 1
fi

echo "Updating service for app: $APP_NAME, version: $NEW_VERSION, file: $DEPLOY_FILE"


# Capture current version service is using
OLD_VERSION=$(kubectl get svc ${APP_NAME} -o 'jsonpath={.spec.selector.version}')
echo "Old version: $OLD_VERSION"


# TODO: Verify new version has pods ready
RESULT=$(kubectl get pods -l app=$APP_NAME -l version=$NEW_VERSION -o 'jsonpath={.items[*].status.phase}')
echo "$RESULT"

## TODO: Update svc to use new version in label selector
#kubectl apply -f $DEPLOY_FILE


# Find the replica set for old version
REPLICA_SET=$(kubectl get rs -l app=$APP_NAME -l version=$OLD_VERSION -o 'jsonpath={.items[*].metadata.name}')
echo "Orphaned Replica Set to delete: $REPLICA_SET"


## TODO: Delete old replica set
#kubectl delete rs $REPLICA_SET

echo "FINISHED"
