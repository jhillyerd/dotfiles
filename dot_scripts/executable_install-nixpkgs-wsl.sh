#!/bin/sh

nix profile install \
  nixpkgs#bat \
  nixpkgs#chezmoi \
  nixpkgs#ctags \
  nixpkgs#direnv \
  nixpkgs#fzf \
  nixpkgs#gitAndTools.gh \
  nixpkgs#gitAndTools.git-absorb \
  nixpkgs#jq \
  nixpkgs#lazygit \
  nixpkgs#lf \
  nixpkgs#sumneko-lua-language-server \
  nixpkgs#neovim \
  nixpkgs#nixfmt \
  nixpkgs#nmap \
  nixpkgs#nodejs \
  nixpkgs#mosh \
  nixpkgs#starship \
  nixpkgs#ripgrep \
  nixpkgs#tmux \
  nixpkgs#tree \
  nixpkgs#whois
