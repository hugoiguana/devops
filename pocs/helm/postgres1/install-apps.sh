#!/bin/bash

kind delete cluster --name helm-postgres1
kind create cluster --config kind.yml --name helm-postgres1
kubectl config use-context kind-helm-postgres1
kubectl create namespace postgres
helm install postgres ./chart