#!/bin/bash
LANG=en_US.UTF-8


export DBSQL_DATABASE="test"
export DBSQL_HOST="postgres.postgres"
export DBSQL_PORT="5432"
export DBSQL_USER="app"
export DBSQL_PASSWORD="app123"

kubectl run dbsql --rm --tty -i --restart='Never' --namespace postgres --image docker.io/bitnami/postgresql:11.7.0-debian-10-r9 --env="PGPASSWORD=$DBSQL_PASSWORD" --command -- psql $DBSQL_DATABASE --host $DBSQL_HOST -U $DBSQL_USER -d $DBSQL_DATABASE -p $DBSQL_PORT