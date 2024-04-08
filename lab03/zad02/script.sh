#!/bin/bash

if [ $# -lt 2 ]; then
    echo "use: $0 PORT CONFIG_FILE_PATH"
    exit 1
fi

PORT="$1"
CONFIG_FILE_PATH="$2"

docker run -d -p "$PORT":80 --name custom-nginx-container -v "$CONFIG_FILE_PATH":/etc/nginx/conf.d/default.conf nginx