#!/bin/bash

SERVER_URL=$1

GREY='\e[90m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
RESET='\e[0m'

echo -e "${YELLOW}ENSURE THAT U ARE USING CORRECT TOKEN FOR YOUR GIT${RESET}"
echo -e "INITIALING APP..."

sh ./installbitwarden.sh

sh ./init_folder.sh
