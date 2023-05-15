#!/bin/bash

kind delete cluster --name helm-cassandra
kind create cluster --config kind.yml --name helm-cassandra
kubectl config use-context kind-helm-cassandra
kubectl create namespace database
kubectl create namespace app
helm dependency build ./cassandra-chart
helm install cassandra-chart ./cassandra-chart -n database
#helm upgrade cassandra-chart ./cassandra-chart -n database

helm install app ./app-chart -n app