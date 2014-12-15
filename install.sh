#!/bin/sh

[[ "$TRACE" ]] && set -x
set -eo pipefail

echo "Installing to $HOME"

# Backup /etc/skel provided files
for file in bash_profile bashrc; do
  target="$HOME/.$file"
  if [[ -f "$target" && ! -h "$target" ]]; then
    mv "$target" "$target.bak"
  fi
done

for file in bash_profile bashrc ctags cvsignore gitconfig tmux.conf zshrc zsh-custom; do
  target="$HOME/.$file"
  if [ -e "$target" ]; then
    echo "$target exists; skipping"
  else
    echo "Linking $file to $target"
    ln -s ".dotfiles/$file" "$target"
  fi
done
