

install-cluster:
	kind delete cluster --name helm-logrotate2
	kind create cluster --config kind.yml --name helm-logrotate2
	kubectl config use-context kind-helm-logrotate2
uninstall-cluster:
	kind delete cluster --name kind-helm-logrotate2	



app-install:
	helm install garbage-collector ./chart -n default
app-upgrade:
	helm upgrade garbage-collector ./chart -n default
app-describe:
	kubectl describe pod -n default $(kubectl get pod -n app -l app=app -o jsonpath="{.items[0].metadata.name}")	
app-log:
	kubectl logs -n default $(kubectl get pod -n app -l app=app -o jsonpath="{.items[0].metadata.name}") -f
app-bash:
	kubectl exec -n default $(kubectl get pod -n app -l app=app -o jsonpath="{.items[0].metadata.name}") -it /bin/bash


