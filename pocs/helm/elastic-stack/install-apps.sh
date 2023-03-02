#!/bin/bash

kind delete cluster --name helm-elastic-stack
kind create cluster --config kind.yml --name helm-elastic-stack
kubectl config use-context kind-helm-elastic-stack
kubectl create namespace app
#kubectl create namespace elastic

helm install app ./app-chart -n app

#helm dependency build ./cassandra-chart
#helm install cassandra-chart ./cassandra-chart -n database
#helm upgrade cassandra-chart ./cassandra-chart -n database

