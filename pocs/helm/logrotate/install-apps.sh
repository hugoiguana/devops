#!/bin/bash

#kind delete cluster --name helm-logrotate
#kind create cluster --config kind.yml --name helm-logrotate
#kubectl config use-context kind-helm-logrotate
helm install logrotate ./chart -n default
helm upgrade logrotate ./chart -n default
#helm uninstall logrotate