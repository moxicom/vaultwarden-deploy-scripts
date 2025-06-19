#!/bin/bash

VAULTWARDEN_PORT=$1
VAULTWARDEN_ADMIN_TOKEN=$2

DEFAULT_VAULTWARDEN_PORT=8081
DEFAULT_ADMIN_TOKEN=admin_token_3141

GREY='\e[90m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
RESET='\e[0m'

# START

echo "${YELLOW}ENSURE THAT U ARE USING CORRECT TOKEN FOR YOUR GIT${RESET}"
echo "Initializing app..."

whoami

# if ! command -v docker &>/dev/null; then
#     echo "${RED}Docker not found in user path ${RESET}"
#     echo "Убедитесь что:"
#     echo "1. Docker установлен для пользователя (--user)"
#     echo "2. ~/.docker/bin добавлен в PATH"
#     exit 1
# fi

# if ! docker info >/dev/null 2>&1; then
#     echo "${RED}Failed to connect to docker daemon${RESET}"
#     echo "Попробуйте запустить Docker вручную:"
#     echo "  ~/.docker/bin/dockerd-rootless-setuptool.sh install"
#     echo "  ~/.docker/bin/dockerd-rootless-setuptool.sh start"
#     exit 1
# fi

if [ -z "$VAULTWARDEN_PORT" ]; then
    echo "${YELLOW}VAULTWARDEN_PORT is empty. Changed to $DEFAULT_VAULTWARDEN_PORT${RESET}"
    VAULTWARDEN_PORT=$DEFAULT_VAULTWARDEN_PORT
fi

echo
if [ -z "$ADMIN_TOKEN" ]; then
    echo "${YELLOW}Empty ADMIN VAULTWARDEN_ADMIN_TOKEN received. Set to default ${DEFAULT_ADMIN_TOKEN}${RESET}"
    VAULTWARDEN_ADMIN_TOKEN=$DEFAULT_ADMIN_TOKEN
fi

sh ./installdeps.sh || exit 1

sh ./init_folder.sh $VAULTWARDEN_ADMIN_TOKEN $VAULTWARDEN_PORT || exit 1

sh ./bitwarden_update.sh $VAULTWARDEN_PORT || exit 1
