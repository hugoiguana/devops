# Insert Users on keycloak using Terraform

This terraform code aims to insert Users on a keycloak Helm.

## Step 1:
Set the kubernetes context to use the environment you want:
```
kubectl config use-context dev
kubectl config use-context qa
kubectl config use-context prod
```

## Step 2:
Make a port-forward to keycloak:
```
kubectl port-forward service/keycloak -n NAME_SPACE 8080:8080
```

## Step 3:
Configure the keycloak and User info in the file "config.auto.tfvars".

## Step 4:
Execute terraform to insert the Users on keycloak:
```
make start
```