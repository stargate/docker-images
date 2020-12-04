#!/bin/sh

# Make sure cass-1, the seed node, is up before bringing up other nodes and stargate
docker-compose up -d cass-1
# Wait until the seed node is up before bringing up more nodes
(docker-compose logs -f cass-1 &) | grep -q "Created default superuser role"

# Bring up the 2nd C* node
docker-compose up -d cass-2
(docker-compose logs -f cass-1 &) | grep -q "is now part of the cluster"
# Bring up the 3rd C* node
docker-compose up -d cass-3
(docker-compose logs -f cass-1 &) | grep -q "is now part of the cluster"

docker run --rm -it nuvo/docker-cqlsh cqlsh host.docker.internal 9045 --cqlversion=3.4.4 -u cassandra -p cassandra

# Bring up keycloak for handling JWTs
docker-compose up -d keycloak

# Bring up the stargate
docker-compose up -d stargate-jwt
# Wait until stargate is up before bringing up the metrics tools
echo ""
echo "Waiting for stargate to start up..."
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:8082/health)" != "200" ]]; do
    printf '.' 
    sleep 5
done

