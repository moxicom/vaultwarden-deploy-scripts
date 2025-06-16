#!/bin/bash

GREY='\e[90m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
RESET='\e[0m'

if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running or you don't have permissions"
    echo "Trying to start Docker..."
    sudo systemctl start docker
fi

FOLDER_NAME="vaultwardenapp"
ADMIN_TOKEN=$1
GITHUB_REPO=$2
VAULTWARDEN_PORT="80"

CURRENT=${pwd}

echo
if [ -z "$ADMIN_TOKEN" ]; then
    echo "${YELLOW}empty ADMIN TOKEN RECEIVED .ADMIN_TOKEN=admin_token_3141${RESET}"
    ADMIN_TOKEN="admin_token_3141"
fi
echo "MAKING VOLUME AT /$FOLDER_NAME"

mkdir -p "$HOME/$FOLDER_NAME"
cd "$HOME/$FOLDER_NAME" || exit 1

# docker rm -f vaultwarden1 2>/dev/null
# add later

if [ -n "$GITHUB_REPO" ]; then
    echo "🔵 cloning $GITHUB_REPO..."
    git clone "$GITHUB_REPO" repo_tmp || exit 1

    SQL_FILE=$(find repo_tmp -type f -name "*.sqlite*" | head -n 1)

    if [ -n "$SQL_FILE" ]; then
        echo "🔵 Найден файл базы данных: $SQL_FILE"
        cp -v "$SQL_FILE" ./db.sqlite3
    else
        echo "🟠 not found *.sqlite*"
    fi

    rm -rf repo_tmp
fi

# Запускаем vaultwarden
echo "${GREY}"
echo "Starting vaultwarden..."
docker run --detach --name vaultwarden1 \
    --volume "$HOME/$FOLDER_NAME/:/data/" \
    -e ADMIN_TOKEN=$ADMIN_TOKEN \
    --restart unless-stopped \
    --publish $VAULTWARDEN_PORT:80 \
    vaultwarden/server:latest \
    || exit 1

echo "${RESET}"
echo "${GREEN}READY! Vaultwarden is running on port $VAULTWARDEN_PORT${RESET}"
echo
cd $CURRENT