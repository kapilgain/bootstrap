#!/usr/bin/env bash

if [ -t 1 ]; then
  DOCKER_OPTS="-it"
else
  # Disable interactive mode in CI
  DOCKER_OPTS=""
fi

docker run $DOCKER_OPTS kapilgain/bootstrap "$@"
