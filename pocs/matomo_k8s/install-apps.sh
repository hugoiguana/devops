#!/bin/bash

kubectl apply -f mysql/configmap.yaml
kubectl apply -f mysql/pv.yaml
kubectl apply -f mysql/deployment.yaml
kubectl apply -f mysql/service.yaml

kubectl apply -f matomo/db-secret.yaml
kubectl apply -f matomo/matomo-admin-secret.yaml
kubectl apply -f matomo/deployment.yaml
kubectl apply -f matomo/service-matomo.yaml