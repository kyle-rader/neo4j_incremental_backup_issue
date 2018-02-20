#!/bin/bash

printf "\nTransaction Logs in Backup folder:\n"
docker-compose exec neo4j sh -c 'du -h /backups/backup.db/*action*'
