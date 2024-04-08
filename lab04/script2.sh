#!/bin/bash

docker volume create nodejs_data
docker run -d -t --name node_container -v nodejs_data:/app node:latest

echo "console.log('hello world')" > app.js
docker cp ./app.js node_container:/app
rm app.js

docker volume create all_volumes

docker run --rm -v nginx_data:/source -v all_volumes:/destination busybox cp -r /source/. /destination
docker run --rm -v nodejs_data:/source -v all_volumes:/destination busybox cp -r /source/. /destination

