# docker-images

## docker compose

[Examples directory](./examples) contains some [docker compose](https://docs.docker.com/compose/) files for stargate with different backends (3 nodes): 
- [with Apache Cassandra 3.11](./examples/cassandra-3.11/docker-compose.yml)
- [with Apache Cassandra 4.0](./examples/cassandra-4.0/docker-compose.yml)
- [with DSE 6.8](./examples/dse-6.8/docker-compose.yml)


### Configuration

Correct settings in the `environment` section are essential for successful Stargate confirguration.
```
    environment:
      # cluster name must match backend cluster name
      # version must match backend version, e.g. 3.11 / 4.0
      - CLUSTER_NAME=backend
      - CLUSTER_VERSION=3.11
      # at least one seed node
      - SEED=backend-1
      # rack and datacenter names must match backend rack name, 
      # please notice that Apache Cassandra defaults differs from DSE defaults
      - RACK_NAME=rack1
      - DATACENTER_NAME=dc1
```

### Starting

Backend (C* or DSE) will not start immediately after container is up.
This can lead to some potential issue with backend not being ready during stargate start. 
```
docker-compose --file <compose-file.yml> up
```

Safe order of running is to run backend seed nodes first and then continue with stargate / rest of backend nodes
```
docker-compose --file <compose-file.yml> --detach up backend-1 -d
sleep 60
docker-compose --file <compose-file.yml> --detach up stargate backend-2 -d
sleep 60
docker-compose --file <compose-file.yml> --detach up backend-3 -d
```

Same approach should be used when starting multiple Stargate nodes. 

For more precise checks `sleep` can be replaced by checking if native protocol clients port (default 9042) is open e.g. using approach proposed in [this guide](https://docs.docker.com/compose/startup-order/).
