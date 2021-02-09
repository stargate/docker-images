#!/bin/sh

#COMPOSE_FILE=stargate-prometheus-grafana.yml

# Make sure backend-1, the seed node, is up before bringing up other nodes and stargate
docker-compose up -d backend-1
# Wait until the seed node is up before bringing up more nodes
(docker-compose logs -f backend-1 &) | grep -q "Created default superuser role"

# Bring up the 2nd C* node
docker-compose up -d backend-2
(docker-compose logs -f backend-1 &) | grep -q "is now part of the cluster"
# Bring up the 3rd C* node
docker-compose up -d backend-3
(docker-compose logs -f backend-1 &) | grep -q "is now part of the cluster"

# Bring up the stargate
docker-compose up -d stargate

# Wait until stargate is up before bringing up the metrics tools
echo ""
echo "Waiting for stargate to start up..."
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:8082/health)" != "200" ]]; do
    printf '.' 
    sleep 5
done

# Bring up prometheus and grafana
docker-compose up -d prometheus grafana
