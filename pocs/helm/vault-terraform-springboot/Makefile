

install-cluster:
	kind delete cluster --name helm-vault-terraform-springboot
	kind create cluster --config kind.yml --name helm-vault-terraform-springboot
	kubectl config use-context kind-helm-vault-terraform-springboot
uninstall-cluster:
	kind delete cluster --name helm-vault-terraform-springboot	


install-vault:
	kubectl create namespace vault
	helm dependency build ./vault-chart
	helm install vault ./vault-chart -n vault	
get-unseal-key:
	kubectl logs vault-0 -n vault | grep 'Unseal Key'
	kubectl logs vault-0 -n vault | grep 'Root Token'
port-forward-vault:	
	kubectl port-forward svc/vault -n vault 8200:8200
port-forward-vault-ui:	
	kubectl port-forward svc/vault-ui -n vault 8201:8200	
kill-port-forward-vault:
	sudo kill -9 $(sudo lsof -t -i:8200)
	sudo kill -9 $(sudo lsof -t -i:8201)

app-install:
	kubectl create namespace app
	helm install app ./app-chart -n app
app-upgrade:
	helm upgrade app ./app-chart -n app
app-describe:
	kubectl describe pod -n app $(kubectl get pod -n app -l app=app -o jsonpath="{.items[0].metadata.name}")	
app-log:
	kubectl logs -n app $(kubectl get pod -n app -l app=app -o jsonpath="{.items[0].metadata.name}") -f
app-bash:
	kubectl exec -n app $(kubectl get pod -n app -l app=app -o jsonpath="{.items[0].metadata.name}") -it /bin/bash


execute-terraform:
	curl -X POST http://localhost:8081/terraform
