#!/bin/sh

[[ "$TRACE" ]] && set -x
set -eo pipefail

main() {
  echo "Installing to $HOME"

  # Backup /etc/skel provided files
  for file in bash_profile bashrc; do
    local target="$HOME/.$file"
    if [[ -f "$target" && ! -h "$target" ]]; then
      mv "$target" "$target.bak"
    fi
  done

  for file in bash_profile bashrc ctags cvsignore gitconfig tmux.conf; do
    linkfile "$file" "$HOME/.$file"
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
    ln -s "$HOME/.dotfiles/$file" "$target"
  fi
}

main
