#!bin/bash

GREY='\e[90m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
RESET='\e[0m'

SERVER=$1
FOLDER_NAME="vaultwardenapp"

echo "${GREY}"

wget https://github.com/vwxyzjn/portwarden/releases/download/1.0.0/portwarden_linux_amd64 -O portwarden
chmod +x portwarden

echo "${RESET}"

if [ -n "$SERVER"]; then
    echo "${YELLOW}Server url is empty. Changed to http://localhost:80${RESET}"
    SERVER="http://localhost:80"
fi

sudo mv portwarden /usr/local/bin/portwarden
sudo chmod +x /usr/local/bin/portwarden

echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc

echo
echo 'Logging out'
bw logout
echo "Changing server url to "$SERVER""
bw config server $SERVER