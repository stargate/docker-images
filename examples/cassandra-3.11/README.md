# Docker Compose scripts for Stargate with Cassandra 3.11

Three files to use docker-compose to start a small Cassandra 3.11 cluster and one Stargate node:

* docker-compose.yaml: File that contains all parameters for starting multi-container environment.

* start_cass311.sh: Shell script to start all nodes properly. Uses variables for docker image tags.

* .env: Project name for container naming

**Be aware that running more than one of these multi-container environments on one host may require 
changing the port mapping to be changed to avoid conflicts on the host machine.**

> **Warning:** Support for Cassandra 3.11 is considered deprecated and will be removed in the Stargate v3 release: [details](https://github.com/stargate/stargate/discussions/2242).
