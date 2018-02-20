#!/bin/bash

printf "\nTransaction Logs in Database folder:\n"
docker-compose exec neo4j sh -c 'du -h /data/databases/graph.db/*action*'
