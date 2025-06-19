## Vaultwarden deploy & autobackup scripts

```shell
# for run
sh ./run.sh

# to save backup
sh ./backup.sh
#
# sh run.sh 8081 123
#
``` 

VOLUME creates at `/vaultwardenapp`

## TODO
- [X] Bitwarden cli install
- [X] Portwarden linux amd64 install
- [X] Docker container
- [ ] Auto backup using github


## manual backup

```shell
portwarden --passphrase 1234 --filename backup.portwarden encrypt
portwarden --passphrase 1234 --filename backup.portwarden decrypt
```

 ## manual ecryption

 ```shell
  tar czf - backup.portwarden.decrypted/ | openssl enc -aes-256-cbc -salt -pbkdf2 -k "mypass" -out encrypted.enc
 ```

 ## manual decryptyon
 ```shell
 openssl enc -d -aes-256-cbc -pbkdf2 -k "mypass" -in encrypted.enc | tar xzf -
 ```

## extra info

core dependencies:
 - linux
 - docker
 - portwarden

 Decryption:
 - https://github.com/vwxyzjn/portwarden/blob/v1.0.0/encryption.go#L22
 - https://github.com/vwxyzjn/portwarden/blob/v1.0.0/encryption.go#L40

 ```go
func DeriveKey(passphrase string) []byte {
	return pbkdf2.Key([]byte(passphrase), []byte(Salt), 4096, 32, sha256.New)
}

 func DecryptBytes(data []byte, passphrase string) ([]byte, error) {
	key := DeriveKey(passphrase)
	block, err := aes.NewCipher(key)
	if err != nil {
		return []byte{}, err
	}
	gcm, err := cipher.NewGCM(block)
	if err != nil {
		return []byte{}, err
	}
	nonceSize := gcm.NonceSize()
	nonce, ciphertext := data[:nonceSize], data[nonceSize:]
	plaintext, err := gcm.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		if err.Error() == ErrMessageAuthenticationFailed {
			return []byte{}, errors.New(ErrWrongBackupPassphrase)
		}
		return []byte{}, err
	}
	return plaintext, nil
}
 ```
