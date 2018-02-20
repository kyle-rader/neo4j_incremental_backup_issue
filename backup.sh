#!/bin/bash

docker-compose exec neo4j mkdir -p /backups
docker-compose exec neo4j bin/neo4j-admin backup --backup-dir=/backups --name=backup.db
