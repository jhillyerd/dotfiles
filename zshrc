# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="yimmy"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias proxy='proxy.py'
alias h='fc -l 100'
alias la='ls -a'
alias ll='ls -l'

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# Customize to your needs...
# Set ls options
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --classify --color=tty' || alias ls='ls -GF'

# Smart path configuration - only add if exists
prepend_paths=($HOME/bin /opt/local/bin /opt/local/sbin)
append_paths=($HOME/devel/gocode/bin $HOME/devel/godeps/bin /usr/local/go/bin)
path=($prepend_paths $path $append_paths)
path=($^path(N))
typeset -U path

cdpath=(~/devel/gocode/src/github.com/jhillyerd)

export EDITOR=vim

# Go setup
export GOPATH=$HOME/devel/godeps:$HOME/devel/gocode
export GOBIN=$HOME/bin
if [ -d /usr/local/go ]; then
  export GOROOT=/usr/local/go
fi