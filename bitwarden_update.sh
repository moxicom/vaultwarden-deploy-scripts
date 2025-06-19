#!/bin/bash

VAULTWARDEN_PORT=$1

echo 'Logging out'
bw logout
echo "Changing server url to "http://localhost:$VAULTWARDEN_PORT""
bw config server http://localhost:$VAULTWARDEN_PORT