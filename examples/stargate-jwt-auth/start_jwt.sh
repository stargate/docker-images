#!/bin/sh

export CASSTAG=3.11.10
export SGTAG=v1.0.7
export KCTAG=latest

SG_AUTH_DIR=/Users/lorina.poland/CLONES/stargate/docker-images/examples/stargate-jwt-auth

# Make sure cass-1, the seed node, is up before bringing up other nodes and stargate
echo "Start 1st Cassandra node"
docker-compose up -d cass-1
# Wait until the seed node is up before bringing up more nodes
(docker-compose logs -f cass-1 &) | grep -q "Created default superuser role"

# Bring up the 2nd C* node
#echo "Start 2nd Cassandra node"
#docker-compose up -d cass-2
#(docker-compose logs -f cass-1 &) | grep -q "is now part of the cluster"
# Bring up the 3rd C* node
#echo "Start 3rd Cassandra node"
#docker-compose up -d cass-3
#(docker-compose logs -f cass-1 &) | grep -q "is now part of the cluster"

# Run a cql script to insert data and grant permissions
#echo "Use nuvo/docker-cqlsh to run CQL script"
#docker run --rm -it -v $SG_AUTH_DIR/scripts:/scripts  \
#-v $SG_AUTH_DIR/cqlshrc:/.cassandra/cqlshrc  \
#--env CQLSH_HOST=host.docker.internal --env CQLSH_PORT=9049  nuvo/docker-cqlsh

# Bring up keycloak for handling JWTs
echo "Start Keycloak"
docker-compose up -d keycloak

# Bring up the stargate
echo "start Stargate node"
docker-compose up -d stargate-jwt
# Wait until stargate is up before bringing up the metrics tools
echo ""
echo "Waiting for stargate to start up..."
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:8082/health)" != "200" ]]; do
    printf '.' 
    sleep 5
done

# Run a cql script to insert data and grant permissions
echo "Use nuvo/docker-cqlsh to run CQL script"
docker run --rm -it -v $SG_AUTH_DIR/scripts:/scripts  \
-v $SG_AUTH_DIR/cqlshrc:/.cassandra/cqlshrc  \
--env CQLSH_HOST=host.docker.internal --env CQLSH_PORT=9049  nuvo/docker-cqlsh

