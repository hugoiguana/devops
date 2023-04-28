#!/bin/bash

echo "This is a test"
#sleep 5
echo "ok-1"
sleep 1
echo "ok-2"
sleep 1
echo "ok-3"
sleep 1
echo "ok-4"

echo "VAULT_ADDR=$VAULT_ADDR"
echo "VAULT_TOKEN=$VAULT_TOKEN"


cd terraform
ls
rm -rf .terraform
rm .terraform*
rm terraform.tfstate
terraform init
terraform apply  -auto-approve -parallelism=2