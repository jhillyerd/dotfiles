# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"
alias -- -="cd -"
alias h=history
alias l="ls -lah"

# Git aliases
alias g=git
alias ga="git add"
alias gb="git branch"
alias gba="git branch -a"
alias gc="git commit -v"
alias gca="git commit -a -v"
alias gco="git checkout"
alias gd="git diff"
alias gl="git pull"
alias gp="git push"
alias gpoat="git push origin --all; and git push origin --tags"
alias gss="git status -s"
