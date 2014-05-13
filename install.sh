#!/bin/sh

echo "Installing to $HOME"

for file in ctags cvsignore gitconfig tmux.conf zshrc zsh-custom; do
  target="$HOME/.$file"
  if [ -e "$target" ]; then
    echo "$target exists; skipping"
  else
    echo "Linking $file to $target"
    ln -s ".dotfiles/$file" "$target"
  fi
done
