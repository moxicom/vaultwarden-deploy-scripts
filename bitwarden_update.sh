#!/bin/bash

SERVER=$1

if [ -z "$SERVER" ]; then
    echo "${YELLOW}Server url is empty. Changed to http://localhost:80${RESET}"
    SERVER="http://localhost:80"
fi

echo
echo 'Logging out'
bw logout
echo "Changing server url to "$SERVER""
bw config server $SERVER