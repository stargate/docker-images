#!/bin/bash

# defaults for cqlsh
export CQLVERSION=${CQLVERSION:-"3.4.4"}
export CQLSH_HOST=${CQLSH_HOST:-"host.docker.internal"}
export CQLSH_PORT=${CQLSH_PORT:-"9045"}

cqlsh=( cqlsh --cqlversion ${CQLVERSION} )

# test connection to cassandra
echo "Checking connection to cassandra..."
for i in {1..5}; do
  if "${cqlsh[@]}" -e "show host;" 2> /dev/null; then
    break
  fi
  echo "Can't establish connection, will retry again in $i sconds"
  sleep $i
done

if [ "$i" = 5 ]; then
  echo >&2 "Failed to connect to cassandra at ${CQLSH_HOST}:${CQLSH_PORT}"
  exit 1
fi

# iterate over the cql files in /scripts folder and execute each one
for file in /scripts/*.cql; do
  [ -e "$file" ] || continue
  echo "Executing $file..."
  "${cqlsh[@]}" -f "$file"
done

echo "Done."

exit 0
