#!/bin/sh

export CASSTAG=3.11.8
export SGTAG=v1.0.7

# Make sure backend-1, the seed node, is up before bringing up other nodes and stargate

docker-compose up -d backend-1

# Wait until the seed node is up before bringing up more nodes

(docker-compose logs -f backend-1 &) | grep -q "Created default superuser role"

# Bring up the 2nd C* node

docker-compose up -f $COMPOSE_FILE -d backend-2
(docker-compose logs -f backend-2 &) | grep -q "is now part of the cluster"

# Bring up the 3rd C* node

docker-compose up -f $COMPOSE_FILE -d backend-3
(docker-compose logs -f backend-3 &) | grep -q "is now part of the cluster"

# Bring up the stargate

docker-compose up -d stargate

# Wait until stargate is up before bringing up zeppelin

echo ""
echo "Waiting for stargate to start up..."
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:8082/health)" != "200" ]]; do
    printf '.'
    sleep 5
done
