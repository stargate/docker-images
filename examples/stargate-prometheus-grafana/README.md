Five files to use docker-compose to start a small Cassandra 3.x cluster and one Stargate node:

* docker-compose.yaml: File that contains all parameters for starting multi-container environment.

* start_stargate-prometheus-grafana.sh: Shell script to start all nodes properly. Uses variables for docker image tags.

* .env: Project name for container naming

* prometheus.yml: File that contains parameters for setting interactions between prometheus and stargate.

* cqlsh-commands.txt: Commands that can be used to run a Cassandra Query Language (CQL) shell, cqlsh, in a container
for use with the multi-container environment.

**Be aware that running more than one of these multi-container environments on one host may require
changing the port mapping to be changed to avoid conflicts on the host machine.**
