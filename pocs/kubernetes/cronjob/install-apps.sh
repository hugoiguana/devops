#!/bin/bash

#kind delete cluster --name helm-cronjob
#kind create cluster --config kind.yml --name helm-cronjob
#kubectl config use-context kind-helm-cronjob
helm install cronjob ./chart -n default
#helm upgrade cronjob ./chart -n default
#helm uninstall cronjob