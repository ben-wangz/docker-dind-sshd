#! /bin/bash

set -e
set -x

CONTAINER_NAME=${1:-docs}

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker run --rm --name ${CONTAINER_NAME} -p 8080:80 -v ${SCRIPT_DIRECTORY}/docs/:/usr/share/nginx/html:ro -v ${SCRIPT_DIRECTORY}/docs/default.conf:/etc/nginx/conf.d/default.conf:ro -d nginx:1.19.9-alpine
