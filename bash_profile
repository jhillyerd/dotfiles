# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export PATH=$PATH:$HOME/bin
export EDITOR=vim

set -o emacs

# Proxy config
if [[ "$(uname -s)" == "Linux" ]]; then
  if hostname --fqdn | egrep 'nintendo|noa' > /dev/null; then
    proxy_host=proxysg.noa.com:8080
    http_proxy=$proxy_host
    https_proxy=$proxy_host
    HTTP_PROXY=$proxy_host
    HTTPS_PROXY=$proxy_host
    export http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
  fi
fi

# Handle unsupported terminal types
if ! infocmp "$TERM" &>/dev/null; then
  if [[ "$TERM" == *screen* ]]; then
    export TERM=screen
  else
    export TERM=xterm-color
  fi
fi

parse_git_branch() {
  ref="$(git symbolic-ref HEAD 2> /dev/null)" || return
  echo "("${ref#refs/heads/}")"
}

normal="\[\033[m\]"
red="\[\033[0;31m\]"
green="\[\033[0;32m\]"
cyan="\[\033[0;36m\]"
white="\[\033[0;37m\]"
gray="\[\033[1;36m\]"
brwhite="\[\033[1;37m\]"

PS1="$red┌$cyan\u$white@$cyan\h $gray\W $green\$(parse_git_branch) \n$red└$normal\\\$ "
