source /usr/share/cachyos-zsh-config/cachyos-config.zsh

. "$HOME/.local/bin/env"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

fpath=($HOME/.dotfiles/zshfunctions $fpath)
autoload -U load_rsa

