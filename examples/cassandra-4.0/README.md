# Docker Compose scripts for Stargate with Cassandra 4.0

Three files to use docker-compose to start a small Cassandra 4.0 cluster and one Stargate node:

* docker-compose.yaml: File that contains all parameters for starting multi-container environment.

* start_cass40.sh: Shell script to start all nodes properly. Uses variables for docker image tags.

* .env: Project name for container naming

**Be aware that running more than one of these multi-container environments on one host may require
changing the port mapping to be changed to avoid conflicts on the host machine.**
