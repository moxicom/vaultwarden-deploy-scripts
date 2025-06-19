#!/bin/bash

GREY='\e[90m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
RESET='\e[0m'

FOLDER_NAME="vaultwardenapp"
ADMIN_TOKEN=$1
VAULTWARDEN_PORT=$2
CURRENT=${pwd}

echo "MAKING VOLUME AT /$FOLDER_NAME"

mkdir -p "$HOME/$FOLDER_NAME"
cd "$HOME/$FOLDER_NAME" || exit 1

# docker rm -f vaultwarden1 2>/dev/null

echo "${GREY}Starting vaultwarden..."
docker run --detach --name vaultwarden1 \
    --volume "$HOME/$FOLDER_NAME/:/data/" \
    -e ADMIN_TOKEN=$ADMIN_TOKEN \
    --restart unless-stopped \
    --publish $VAULTWARDEN_PORT:80 \
    vaultwarden/server:latest \
    || exit 1

echo "${GREEN}READY! Vaultwarden is running on port $VAULTWARDEN_PORT${RESET}"
cd $CURRENT