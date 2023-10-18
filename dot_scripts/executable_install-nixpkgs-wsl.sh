#!/bin/sh

nix profile install \
  nixpkgs#bat \
  nixpkgs#chezmoi \
  nixpkgs#ctags \
  nixpkgs#gitAndTools.gh \
  nixpkgs#gitAndTools.git-absorb \
  nixpkgs#jq \
  nixpkgs#lazygit \
  nixpkgs#neovim \
  nixpkgs#nixfmt \
  nixpkgs#nmap \
  nixpkgs#nodejs \
  nixpkgs#starship \
  nixpkgs#ripgrep \
  nixpkgs#tmux \
  nixpkgs#tree \
  nixpkgs#whois
