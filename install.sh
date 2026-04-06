#!/usr/bin/env bash

set -exuo pipefail

sudo pacman -Syu

PACKAGE_DIR="./packages"
BASIC_PACKAGES="$PACKAGE_DIR/basic"

# Any packages that can be installed with a basic pacman command just go in a basic list
install_basic() {
	while read -r pkg; do
		sudo pacman --noconfirm -S $pkg
	done < "$BASIC_PACKAGES"
}

# Any installs that require special handling should go in the package dir as a shell script
install_custom() {
	for file in "$PACKAGE_DIR"/*.sh; do
		$file
	done
}

install_basic
install_custom

