#!/bin/sh

nix-env -iA nixpkgs.bat
nix-env -iA nixpkgs.chezmoi
nix-env -iA nixpkgs.ctags
nix-env -iA nixpkgs.gitAndTools.gh
nix-env -iA nixpkgs.gitAndTools.git-absorb
nix-env -iA nixpkgs.jq
nix-env -iA nixpkgs.neovim
nix-env -iA nixpkgs.nodejs
nix-env -iA nixpkgs.starship
nix-env -iA nixpkgs.ripgrep
nix-env -iA nixpkgs.tmux
nix-env -iA nixpkgs.tree
