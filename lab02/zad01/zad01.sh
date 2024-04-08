#!/bin/bash
docker run -p 8080:8080 -v ./server.js:/server.js node:12 node /server.js
