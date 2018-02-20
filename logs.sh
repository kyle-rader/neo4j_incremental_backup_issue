#!/bin/bash

docker-compose exec neo4j tail -f logs/debug.log
