#!/usr/bin/env bash

set -exuo pipefail

# Install 1Password
if ! [ -x "$(command -v 1password)" ]; then
	curl -sSO https://downloads.1password.com/linux/tar/stable/x86_64/1password-latest.tar.gz
	sudo tar -xf 1password-latest.tar.gz
	sudo mkdir -p /opt/1Password
	sudo mv 1password-*/* /opt/1Password
	rm -rf 1password-*
	sudo /opt/1Password/after-install.sh
	# Launch 1password so we can configure the account
	1password > /dev/null 2>&1 & 
fi

if ! [ -x "$(command -v op)" ]; then
	wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.30.0/op_linux_amd64_v2.30.0.zip" -O op.zip && \
	unzip -d op op.zip && \
	sudo mv op/op /usr/local/bin/ && \
	rm -r op.zip op && \
	sudo groupadd -f onepassword-cli && \
	sudo chgrp onepassword-cli /usr/local/bin/op && \
	sudo chmod g+s /usr/local/bin/op
fi

