#!/bin/bash

docker volume create nginx_data

docker run -d -p 80:80 --name lab4zad1 -v $(pwd)/nginx_data:/usr/share/nginx/html nginx
