#!/bin/bash

DATE=`date '+%Y-%m-%d-%H-%M-%S'`

portwarden --passphrase 1234 --filename backup$DATE.portwarden encrypt
portwarden --passphrase 1234 --filename backup$DATE.portwarden decrypt