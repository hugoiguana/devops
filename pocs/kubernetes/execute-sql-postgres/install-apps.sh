#!/bin/bash

kind delete cluster --name execute-sql-postgres
kind create cluster --config kind.yml --name execute-sql-postgres
kubectl config use-context kind-execute-sql-postgres
kubectl create namespace postgres
helm install postgres ./postgres-chart
