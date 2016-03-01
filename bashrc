# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Color + human ls
ls --color -d . &>/dev/null 2>&1 && alias ls='ls -Fh --color=tty' || alias ls='ls -GF'

# User specific aliases and functions
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"
alias -- -="cd -"
alias h=history
alias l="ls -la"
alias la="ls -la"
alias ll="ls -l"
alias t="tmux a || tmux"

# Git aliases
alias g=git
alias ga="git add"
alias gbr="git branch"
alias gba="git branch -a"
alias gc="git commit -v"
alias gca="git commit -a -v"
alias gco="git checkout"
alias gcm="git checkout master"
alias gd="git diff"
alias gl="git pull"
alias glog="git log --oneline --decorate --color --graph"
alias gp="git push"
alias gpoat="git push origin --all; and git push origin --tags"
alias gss="git status -s"

# Functions
settitle() {
  printf "\033k$1\033\\"
}

ssh() {
  settitle "$*"
  command ssh "$@"
  settitle "bash"
}
