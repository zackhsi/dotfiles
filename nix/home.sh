#!/usr/bin/env bash
set -e

if [[ $(hostname) != st* ]]; then
  echo "home.sh is only for Stripe laptop"
  exit 1
fi

ln -sf ~/dotfiles/nix/sources/ghostty_config ~/Library/Application\ Support/com.mitchellh.ghostty/config
ln -sf ~/dotfiles/nix/sources/zshrc ~/.zshrc
ln -sf ~/dotfiles/nix/sources/tmux.conf ~/.tmux.conf

command -v starship > /dev/null || brew install starship
[[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] || brew install zsh-autosuggestions
