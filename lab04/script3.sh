#!/bin/bash

volumes=$(docker volume ls --quiet)

for volume in $volumes; do
    echo "Volume: $volume"
    docker volume inspect --format='{{.Mountpoint}}' "$volume" | xargs df -h | awk 'NR==2 {print "Usage: " $5}'
done
