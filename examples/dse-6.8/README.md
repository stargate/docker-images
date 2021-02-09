Three files to use docker-compose to start a small DataStax Enterprise 6.8 cluster and one Stargate node:

docker-compose.yaml: File that contains all parameters for starting multi-container environment.

start_dse_68.sh: Shell script to start all nodes properly. Uses variables for docker image tags.

.env: Project name for container naming
