#!/bin/sh

echo "Installing to $HOME"

for file in gitconfig tmux.conf zshrc; do
    echo Linking $file
    ln -s ".dotfiles/$file" "$HOME/.$file"
done
