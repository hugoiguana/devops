## Links
- [ ] [Install Vault](https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-install)
- [ ] [Init Vault server on a DEV mode](https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-dev-server)
- [ ] [Create a first Vault secret](https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-first-secret)


## Kind - Cluster k8s:
```
kind create cluster --config kind.yml --name helm-vault-terraform-springboot
kind delete cluster --name helm-vault-terraform-springboot
kind get clusters
kind get nodes
kubectl get nodes
docker ps | grep kind
cat ~/.kube/conf
```

## Docker:
```
docker ps | grep helm-vault-terraform-springboot
```

## Kubernetes config:
```
kubectl config get-contexts
kubectl config use-context kind-helm-vault-terraform-springboot
```


## Install apps:
```
chmod 777 install-apps.sh
./install-apps.sh
```


## Steps:
```
  make install-cluster
  make install-vault
  kubectl get po -n vault
  kubectl get service -n vault
  kubectl logs vault-0 -n vault
  make get-unseal-key
  export VAULT_ADDR='http://127.0.0.1:8200'
	export VAULT_TOKEN="root"
  make port-forward-vault-ui
  kubectl exec -n vault vault-0 vault status
  kubectl exec -n vault vault-0 --stdin --tty sh
  make app-install
  kubectl get all -n app
  make app-describe
  make app-log
```

## Kubernetes commands:
```
  kubectl get po -n vault
  kubectl logs vault-0 -n vault
```  

## Vault Login(Root):
```
vault status
vault kv put -mount=secret hello foo=world


export VAULT_ADDR="http://localhost:8201"
export VAULT_TOKEN="root"
vault login token=root
vault kv put secret/mysql/webapp db_name="users" username="admin" password="passw0rd"
```

## Vault - Config approle auth method and create policy and Role:
```
vault auth enable approle

vault write auth/approle/role/jenkins \
    secret_id_ttl=10m \
    token_num_uses=0 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    bind_secret_id=true

vault read auth/approle/role/jenkins
vault read auth/approle/role/jenkins/role-id
vault write -f auth/approle/role/jenkins/secret-id


vault policy write jenkins -<<EOF
# Read-only permission on secrets stored at 'secret/data/mysql/webapp'
path "secret/data/mysql/webapp" {
  capabilities = [ "read" ]
}
EOF

vault write auth/approle/role/jenkins token_policies="jenkins" token_ttl=1h token_max_ttl=4h
```


## Vault - Create a static secret:
```
vault token create -policy="jenkins" -field=token
```


## Vault - login with Approle:
```
export VAULT_ADDR="http://localhost:8201"
export VAULT_TOKEN="STATIC_SECRET_CREATED_ABOVE"
vault kv get secret/mysql/webapp
vault kv delete secret/mysql/webapp
```

  
## APP:
```
curl -X POST http://localhost:8081/terraform
./mvnw clean package
echo PASSWORD | docker login -u hugoiguana --password-stdin
docker build -t hugoiguana/vault-terraform-springboot:0.0.1 .
docker push hugoiguana/vault-terraform-springboot:0.0.1
docker images | grep vault-terraform-springboot
kubectl exec -n app $(kubectl get pod -n app -l app=app -o jsonpath="{.items[0].metadata.name}") -it /bin/bash
```












