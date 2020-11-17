backend-1
docker run --rm -it nuvo/docker-cqlsh cqlsh host.docker.internal 9044 --cqlversion=3.4.4

stargate:
docker run --rm -it nuvo/docker-cqlsh cqlsh host.docker.internal 9045 --cqlversion=3.4.5 -u cassandra -p cassandra
