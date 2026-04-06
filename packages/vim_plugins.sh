#!/usr/bin/env bash

set -exuo pipefail

if ! [[ -d "$HOME/.vim/pack/tpope/start/fugitive" ]]; then
	mkdir -p "$HOME/.vim/pack/tpope/start"
	cd "$HOME/.vim/pack/tpope/start"
	git clone https://tpope.io/vim/fugitive.git
	vim -u NONE -c "helptags fugitive/doc" -c q
fi

