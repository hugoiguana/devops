#!/bin/bash

kind delete cluster --name helm-vault-terraform-springboot
kind create cluster --config kind.yml --name helm-vault-terraform-springboot
kubectl config use-context kind-helm-vault-terraform-springboot
kubectl create namespace vault
helm dependency build ./vault-chart
helm install vault ./vault-chart -n vault