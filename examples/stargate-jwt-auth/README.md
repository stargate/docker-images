This directory includes an example to start a keycloak server along with a Cassandra cluster and a Stargate node.

Use the `start_jwt.sh` shell script to run `docker-compose.yml` to start all the services, along with a `docker run` command
to insert some CQL data for use with the example.

The `stargate-realm.json` file is used by the keycloak service. 

The CQL files in the `scripts` directory are mounted and run using a docker-cqlsh image.
The `cqlshrc` file gives the docker-cqlsh image user permissions to insert the data.

`cqlsh_Dockerfile` and `cqlsh_entrypoint.sh` are WIP to create a cqlsh docker image to use with Stargate.
