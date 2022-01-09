#!/bin/bash

for i in "$@"; do
  case $i in
    -a=*|--version_service1=*)
      SERVICE1="${i#*=}"
      shift # past argument=value
      ;;
    -b=*|--version_service2=*)
      SERVICE2="${i#*=}"
      shift # past argument=value
      ;;
    -*|--*)
      echo "Unknown option $i"
      exit 1
      ;;
    *)
      ;;
  esac
done

echo "Version service 1 = ${SERVICE1}"
echo "Version service 2 = ${SERVICE2}"

if [[ -z $SERVICE1 || -z $SERVICE2 ]]; then
    echo "Both versions of services have to be specified!"
    exit 1
fi

if [ ! -x "$(command -v minikube)" ] && [ ! -x "$(command -v kubectl)" ]; then
    echo "Please install minikube and kubectl to be able to run this script"
    exit 1
fi

cp service1/deployment.yaml service1/deployment-custom.yaml
sed -i "s/latest/$SERVICE1/g" service1/deployment-custom.yaml

cp service2/deployment.yaml service2/deployment-custom.yaml
sed -i "s/latest/$SERVICE2/g" service2/deployment-custom.yaml


minikube start
kubectl apply -f service1/deployment-custom.yaml
kubectl apply -f service2/deployment-custom.yaml
