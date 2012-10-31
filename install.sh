#!/bin/sh

echo "Installing to $HOME"

for file in cvsignore gitconfig tmux.conf zshrc; do
    echo Linking $file
    ln -s ".dotfiles/$file" "$HOME/.$file"
done
