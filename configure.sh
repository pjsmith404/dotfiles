#!/usr/bin/env bash

set -exuo pipefail

# Copy our various application config files
cp configs/.* "$HOME/"

# Mount home NAS
mnt_dir="/mnt/nas/"
mnt_str="192.168.1.4:/volume1/Data    $mnt_dir    nfs    defaults    0 0"
if ! $(grep -Fxq "$mnt_str" /etc/fstab); then
	mkdir -p "$mnt_dir"
	echo "$mnt_str" | sudo tee -a /etc/fstab
	sudo mount /mnt/nas
fi

AWS_CONFIG_DIR="$HOME/.aws"
if ! [[ -f "$AWS_CONFIG_DIR/config" ]]; then
	eval $(op signin)
	mkdir -p "$AWS_CONFIG_DIR"

	op read --out-file "$AWS_CONFIG_DIR/config" "op://Private/AWS SSO Config/notesPlain"
fi

arduino-cli config init || true
arduino-cli core update-index

SSH_DIR="$HOME/.ssh"
if ! [[ -f "$SSH_DIR/id_rsa" ]]; then
	eval $(op signin)
	mkdir -p "$SSH_DIR"

	chmod 700 "$SSH_DIR"

	op read --out-file "$SSH_DIR/id_rsa" "op://Private/id_rsa/private key"
	op read --out-file "$SSH_DIR/id_rsa.pub" "op://Private/id_rsa/public key"
	
	cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"
	
	chmod 600 "$SSH_DIR/authorized_keys"
fi

