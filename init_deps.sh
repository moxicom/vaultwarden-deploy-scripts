#!bin/bash

SERVER=$1
FOLDER_NAME="vaultwardenapp"

wget https://github.com/vwxyzjn/portwarden/releases/download/1.0.0/portwarden_linux_amd64 -O portwarden
chmod +x portwarden

sudo mv portwarden /usr/local/bin/portwarden
sudo chmod +x /usr/local/bin/portwarden

echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc

echo 'changing server url to ' + $1
bw config server $SERVER