#!/bin/bash

SERVER_URL=$1
VAULTWARDEN_ADMIN_TOKEN=$2


GREY='\e[90m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
RESET='\e[0m'

echo -e "${YELLOW}ENSURE THAT U ARE USING CORRECT TOKEN FOR YOUR GIT${RESET}"
echo -e "INITIALING APP..."

sh ./installdeps.sh || exit 1

sh ./init_folder.sh $VAULTWARDEN_ADMIN_TOKEN || exit 1

sh ./bitwarden_update.sh $SERVER_URL || exit 1
