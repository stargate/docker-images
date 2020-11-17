#!/bin/sh

COMPOSE_FILE=stargate-prometheus-grafana.yml

# Make sure backend-1, the seed node, is up before bringing up other nodes and stargate
docker-compose --file $COMPOSE_FILE up -d backend-1
sleep 60
# Bring up the 2nd C* node
#docker-compose --file $COMPOSE_FILE up -d backend-2
#sleep 60
# Bring up the 3rd C* node
#docker-compose --file $COMPOSE_FILE up -d backend-3
#sleep 60
# Bring up the stargate
docker-compose --file $COMPOSE_FILE up -d stargate
sleep 60
# Bring up prometheus and grafana
docker-compose --file $COMPOSE_FILE up -d prometheus grafana
