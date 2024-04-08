#!/bin/bash

mkdir -p html
echo "<h1>elo</h1>" > html/index.html
docker run -d -p 80:80 -v $(pwd)/html:/usr/share/nginx/html nginx
