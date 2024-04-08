#!/bin/bash

docker run -dit -p 8080:8080 --name express-node node:14
docker exec express-node sh -c 'mkdir app'
docker cp server.js express-node:/app/
docker cp package.json express-node:/app/
docker exec express-node sh -c 'cd /app && npm install && node server.js'

