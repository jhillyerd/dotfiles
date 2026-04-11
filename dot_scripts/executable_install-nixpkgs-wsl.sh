#!/bin/sh

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
nixconf=$XDG_CONFIG_HOME/nix/nix.conf

if [ ! -f $nixconf ]; then
  mkdir -p "$(dirname $nixconf)"
  echo "extra-experimental-features = nix-command flakes" > $nixconf
  echo "Created $nixconf"
fi

nix profile add \
  nixpkgs#bat \
  nixpkgs#chezmoi \
  nixpkgs#ctags \
  nixpkgs#direnv \
  nixpkgs#fzf \
  nixpkgs#gh \
  nixpkgs#glow \
  nixpkgs#jq \
  nixpkgs#lazygit \
  nixpkgs#lua-language-server \
  nixpkgs#neovim \
  nixpkgs#nixfmt \
  nixpkgs#nmap \
  nixpkgs#nodejs \
  nixpkgs#sesh \
  nixpkgs#starship \
  nixpkgs#ripgrep \
  nixpkgs#tmux \
  nixpkgs#tree \
  nixpkgs#watchexec \
  nixpkgs#whois \
  nixpkgs#yazi \
  nixpkgs#zoxide
