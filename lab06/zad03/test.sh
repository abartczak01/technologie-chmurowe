#!/bin/bash
correct=true
if ! docker exec frontend ping -c1 -q backend > /dev/null; then
    echo "Can't connect from frontend to backend"
    correct=false
fi

if ! docker exec backend ping -c1 -q database > /dev/null; then
    echo "Can't connect from backend to database"
    correct=false
fi

if docker exec frontend ping -c1 -q database > /dev/null 2>&1; then
    echo "Can connect from frontend to database"
    correct=false
fi

$correct && echo "Everything works correctly"