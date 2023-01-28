#!/bin/bash
LANG=en_US.UTF-8

#export VAULT_ADDR="https://vault-url"
#unset VAULT_TOKEN
#TOKEN_TTL=$(vault token lookup -format=json 2>/dev/null | jq .data.ttl)
#if [ $? -eq 0 ]; then
#    if [ $TOKEN_TTL -lt 18000 ]; then
#        vault token renew
#    fi
#else
#    vault login -method=oidc -path=keycloak role=admin
#fi


# Root DB root User parameters:
DB_HOST="postgres.postgres"
DB_PORT="5432"
DB_ROOT_DATABASE="postgres"
DB_ROOT_USERNAME_ITEM_VALUE="admin"
DB_ROOT_PASSWORD_ITEM_VALUE="test123"
#DB_HOST=$(vault kv get --field host secret/db_root)
#DB_PORT=$(vault kv get --field port secret/db_root)
#DB_ROOT_USERNAME_ITEM_VALUE=$(vault kv get --field db_root_username secret/db_root)
#DB_ROOT_PASSWORD_ITEM_VALUE=$(vault kv get --field db_root_password secret/db_root)


# Tenant DB user parameters:
DB_DATABASE="test"
DB_USER_NAME="app"
DB_USER_PASSWORD="app123"


# New DB user parameters:
DB_NEW_USER_NAME="app1"
DB_NEW_USER_PASSWORD=$(openssl rand -base64 24)
DB_NEW_USER_EXPIRATION="2025-12-31 18:00:00"
DB_CONNECTION_LIMIT="20"


# Not change it
K8S_NAMESPACE="postgres-execute-script"
K8S_OBS_NAME="postgres-execute-script"



#-----------------------------


echo "Creating namespace $K8S_NAMESPACE"
kubectl create namespace $K8S_NAMESPACE


echo "Creating config map $K8S_OBS_NAME with the script to be executed:"
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: ${K8S_OBS_NAME}
  namespace: ${K8S_NAMESPACE}
  labels:
    app: ${K8S_OBS_NAME}
data:
  script-create-user.sql: |
    create user ${DB_NEW_USER_NAME} with PASSWORD '${DB_NEW_USER_PASSWORD}' VALID UNTIL '${DB_NEW_USER_EXPIRATION}' CONNECTION LIMIT ${DB_CONNECTION_LIMIT};
    grant connect on database ${DB_DATABASE} to ${DB_NEW_USER_NAME};
  script-grant-user.sql: |
    CREATE SCHEMA IF NOT EXISTS sales;

    CREATE TABLE sales.product
    (
        id UUID PRIMARY KEY,
        name VARCHAR NOT NULL,
        description VARCHAR,
        dt_criation TIMESTAMP,
        dt_modification TIMESTAMP
    );
    GRANT ALL PRIVILEGES ON DATABASE ${DB_DATABASE} TO ${DB_NEW_USER_NAME};
    GRANT ALL ON ALL TABLES IN SCHEMA sales TO ${DB_NEW_USER_NAME};
    GRANT ALL ON ALL SEQUENCES IN SCHEMA sales TO ${DB_NEW_USER_NAME};
    GRANT ALL ON ALL FUNCTIONS IN SCHEMA sales TO ${DB_NEW_USER_NAME};
EOF


echo "Creating pod $K8S_OBS_NAME to execute the script:"

cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${K8S_OBS_NAME}
  namespace: ${K8S_NAMESPACE}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ${K8S_OBS_NAME}
  template:
    metadata:
      labels:
        app: ${K8S_OBS_NAME}
    spec:
      containers:
      - name: ${K8S_OBS_NAME}
        image: alpine:3.12
        imagePullPolicy: IfNotPresent
        command: ["/bin/sh", "-c"]
        env:
          - name: PGPASSWORD
            value: "${DB_ROOT_PASSWORD_ITEM_VALUE}"
          - name: DB_USER_PASSWORD
            value: "${DB_USER_PASSWORD}"
        args:
          - >-
            apk add --no-cache postgresql-client &&
            echo "Connecting on ${DB_HOST}:${DB_PORT} - DB=${DB_ROOT_DATABASE} - user=${DB_ROOT_USERNAME_ITEM_VALUE}" &&
            psql -h ${DB_HOST} -U ${DB_ROOT_USERNAME_ITEM_VALUE} -d ${DB_ROOT_DATABASE} -p ${DB_PORT} -a -f /data/script-create-user.sql &&
            echo "Connecting on ${DB_HOST}:${DB_PORT} - DB=${DB_DATABASE} - user=${DB_USER_NAME}" &&
            export PGPASSWORD=\${DB_USER_PASSWORD} &&
            psql -h ${DB_HOST} -U ${DB_USER_NAME} -d ${DB_DATABASE} -p ${DB_PORT} -a -f /data/script-grant-user.sql &&
            sleep 30
        volumeMounts:
          - name: script-volume
            mountPath: /data
      volumes:
        - name: script-volume
          configMap:
            name: ${K8S_OBS_NAME}
EOF

sleep 10
echo "Pods´s Describe:"
kubectl describe pod -n  $K8S_NAMESPACE $(kubectl get pod -n  $K8S_NAMESPACE -l app=${K8S_OBS_NAME} -o jsonpath="{.items[0].metadata.name}")
echo "Pods´s Log:"
kubectl logs -n  $K8S_NAMESPACE  $(kubectl get pod -n  $K8S_NAMESPACE -l app=${K8S_OBS_NAME} -o jsonpath="{.items[0].metadata.name}")
echo "Pod status:"
kubectl get pods -n $K8S_NAMESPACE | grep ${K8S_OBS_NAME}


echo "Deleting namespace $NAMESPACE"
kubectl delete namespace $K8S_NAMESPACE
