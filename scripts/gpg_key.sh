#!/bin/bash

# config gpg keys
set_gpg_key(){
  echo -e "\n${BLUE}==> Set GPG Key${GRAY}"
  set_gpg_key
  set_gpg_self
}

#gpg key for spotify
set_spotify() {
  echo -e "\n${BLUE}  -> set gpg key for spotify${GRAY}"

  curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --import
}

#generate gpg keys
set_gpg_self() {
  echo -e "\n${BLUE}  -> set own gpg key${GRAY}"

  #gpg --full-generate-key 
  gpg --batch --gen-key <<EOF
  %echo Generate GPG key
  Key-Type: RSA
  Key-Length: 4096
  Subkey-Type: RSA
  Subkey-Length: 4096
  Name-Real: "$USER_INPUT"
  Name-Comment: "Key for sign"
  Name-Email: "$EMAIL_INPUT"
  Expire-Date: 0
  Passphrase: "$PASS_INPUT"
  %commit
  %echo Key generated successfully
EOF
}