#!/bin/bash

FOLDER_NAME="vaultwardenapp"
GITHUB_REPO="$1"
ADMIN_TOKEN=$2

if [ -n $ADMIN_TOKEN]; then
    echo 'empty ADMIN TOKEN RECEIVED'
    echo 'ADMIN_TOKEN="admin_token_3141"'
    ADMIN_TOKEN="admin_token_3141"
fi

mkdir -p "$HOME/$FOLDER_NAME"
cd "$HOME/$FOLDER_NAME" || exit 1

# docker rm -f vaultwarden1 2>/dev/null

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
echo "Starting vaultwarden..."
docker run --detach --name vaultwarden1 \
    --volume "$HOME/$FOLDER_NAME/:/data/" \
    -e ADMIN_TOKEN=$ADMIN_TOKEN
    --restart unless-stopped \
    --publish 80:80 \
    vaultwarden/server:latest

echo "✅ READY! Vaultwarden is running."
if [ -n "$GITHUB_REPO" ]; then
    echo "Database was imported from repo."
else
    echo "Database was not imported (no repository at args)."
fi