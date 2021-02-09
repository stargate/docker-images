#!/bin/sh

export CASSTAG=3.11.8
export SGTAG=v1.0.7

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

# this is where a cql script must be run to insert data and grant permissions
docker run --rm -it -v /Users/lorina.poland/CLONES/stargate/docker-images/examples/stargate-jwt-auth/scripts:/scripts  \
-v /Users/lorina.poland/CLONES/stargate/docker-images/examples/stargate-jwt-auth/cqlshrc:/.cassandra/cqlshrc  \
--env CQLSH_HOST=host.docker.internal --env CQLSH_PORT=9045  nuvo/docker-cqlsh

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

