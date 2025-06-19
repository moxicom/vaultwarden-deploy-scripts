#!bin/bash

GREY='\e[90m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
RESET='\e[0m'

FOLDER_NAME="vaultwardenapp"

echo "Installing bw (bitwarden CLI)...${GREY}"
sudo snap install bw

echo "${GREEN}Bitwarden CLI installed successfully${RESET}"

echo "Downloading and installing portwarden${GREY}"

if ! command -v portwarden >/dev/null 2>&1
then
    wget https://github.com/vwxyzjn/portwarden/releases/download/1.0.0/portwarden_linux_amd64 -O portwarden
    chmod +x portwarden  
    echo "${RESET}"

    sudo mv portwarden /usr/local/bin/portwarden
    sudo chmod +x /usr/local/bin/portwarden
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
fi