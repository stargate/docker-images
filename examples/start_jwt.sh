#!/bin/sh

COMPOSE_FILE=stargate-cass311-jwt.yml

# Make sure cass-1, the seed node, is up before bringing up other nodes and stargate
docker-compose -f stargate-cass311-jwt.yml up -d cass-1
# Wait until the seed node is up before bringing up more nodes
(docker-compose logs -f cass-1 &) | grep -q "Created default superuser role"

# Bring up the 2nd C* node
docker-compose -f stargate-cass311-jwt.yml up -d cass-2
(docker-compose logs -f cass-1 &) | grep -q "is now part of the cluster"
# Bring up the 3rd C* node
#docker-compose -f stargate-cass311-jwt.yml up -d cass-3
#(docker-compose logs -f cass-1 &) | grep -q "is now part of the cluster"

# Bring up the stargate
docker-compose -f stargate-cass311-jwt.yml up -d stargate-jwt
# Wait until stargate is up before bringing up the metrics tools
echo ""
echo "Waiting for stargate to start up..."
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:8082/health)" != "200" ]]; do
    printf '.' 
    sleep 5
done

# Bring up keycloak
docker-compose -f stargate-cass311-jwt.yml up -d keycloak
