#!/bin/bash

kind delete cluster --name helm-elastic-stack
kind create cluster --config kind.yml --name helm-elastic-stack
kubectl config use-context kind-helm-elastic-stack
kubectl create namespace app
kubectl create namespace monitoring

helm install app ./app-chart -n app

helm dependency build ./elastic-stack-chart
helm install elastic-stack ./elastic-stack-chart -n monitoring
#helm upgrade elastic-stack ./elastic-stack-chart -n monitoring

