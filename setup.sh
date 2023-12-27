#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 [-t] playbook.yml [extra ansible arguments...]"
  exit 1
fi

while getopts ":t" opt; do
  case $opt in
    t)
      MODE="test"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))
PLAYBOOK=$1
shift 1

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y ansible git

if [ "$MODE" == "test" ]; then
  echo "Using local playbook"
  ansible-playbook -v "$PLAYBOOK" "$@"
else
  echo "Using playbook from repository"
  ansible-pull -v -U https://github.com/kapilgain/bootstrap.git "$PLAYBOOK" "$@"
fi
