#!/usr/bin/env bash

set -euo pipefail

if [ -z ${1+x} ]; then 
   echo "stargate version is a required argument"
   exit 1
fi

stargate_version=$1

for script in $(find . -type f -name 'build.sh'); do
    echo "Executing $script"
    bash "$script" $stargate_version

    echo ""
done
