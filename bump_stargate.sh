#!/usr/bin/env bash

set -euo pipefail

if [ -z ${1+x} ]; then 
   echo "stargate version is a required argument"
   exit 1
fi

STARGATE_VERSION=$1
find . -name "Dockerfile" -exec perl -i -pe "s|ARG STARGATE_VERSION=.*|ARG STARGATE_VERSION=${STARGATE_VERSION}|" {} \;
find . -name "start_*.sh" -exec perl -i -pe "s|export SGTAG=.*|export SGTAG=${STARGATE_VERSION}|" {} \;
