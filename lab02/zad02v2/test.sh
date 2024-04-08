#!/bin/bash

response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)

if [ $response -eq 200 ]; then
    echo "Server is running successfully. Test passed!"
else
    echo "Server is not running. Test failed!"
fi
