#!/bin/bash

kubectl apply -f postgres/configmap.yaml
kubectl apply -f postgres/pv.yaml
kubectl apply -f postgres/deployment.yaml
kubectl apply -f postgres/service.yaml

kubectl apply -f nginx/nginx-config-configmap.yaml
kubectl apply -f nginx/nginx-certificate-configmap.yaml
kubectl apply -f nginx/nginx-certificate-key-configmap.yaml
kubectl apply -f nginx/nginx-certificate-ca-configmap.yaml
kubectl apply -f nginx/issuer-keycloak.yaml

kubectl apply -f matrix/matrix-homeserver-configmap.yaml
kubectl apply -f matrix/matrix-log-config-configmap.yaml
kubectl apply -f matrix/matrix-signing-key-configmap.yaml
#kubectl apply -f matrix/pv.yaml

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml