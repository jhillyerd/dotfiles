#!/bin/bash

DOTFILES="$HOME/.dotfiles"

[[ "$TRACE" ]] && set -x
set -eo pipefail

main() {
  cd "$DOTFILES"
  echo "Installing to $HOME"

  # Backup /etc/skel provided files
  for file in bash_profile bashrc; do
    local target="$HOME/.$file"
    if [[ -f "$target" && ! -h "$target" ]]; then
      mv "$target" "$target.bak"
    fi
  done

  for file in bash_profile bashrc ctags cvsignore gitconfig tmux.conf \
    Xresources; do
    linkfile "$file" "$HOME/.$file"
  done

  linkfile "omf" "$HOME/.config/omf"

  for dir in config/*; do
    local basename="${dir##*/}"
    linkfile "$dir" "$HOME/.config/$basename"
  done
}

linkfile() {
  declare file="$1" target="$2"
  local dirname="${target%/*}"

  if [[ ! -d "$dirname" ]]; then
    mkdir -p "$dirname"
  fi

  if [ -e "$target" ]; then
    echo "$target exists; skipping"
  else
    echo "Linking $file to $target"
    ln -s "$DOTFILES/$file" "$target"
  fi
}

main
