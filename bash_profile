# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs
export PATH="$PATH:$HOME/bin"
export EDITOR=vim

set -o emacs

# Proxy config
if [[ "$(uname -s)" == "Linux" ]]; then
  if hostname --fqdn | egrep 'nintendo|noa' > /dev/null; then
    proxy_host=proxysg.noa.com
    proxy_port=8080
    proxy_hostport=$proxy_host:$proxy_port
    http_proxy=$proxy_hostport
    https_proxy=$proxy_hostport
    HTTP_PROXY=$proxy_hostport
    HTTPS_PROXY=$proxy_hostport
    export http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
    export GRAILS_OPTS="-Dhttp.proxyHost=$proxy_host -Dhttp.proxyPort=$proxy_port -Dhttps.proxyHost=$proxy_host -Dhttps.proxyPort=$proxy_port"
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
gray="\[\033[m\]"
brwhite="\[\033[1;37m\]"

PS1="$red┌$cyan\u$white@$cyan\h $gray\W $green\$(parse_git_branch)"$'\n'"$red└$normal\\\$ "

# Grails setup
if [[ -d "$HOME/grails" ]]; then
  export GRAILS_HOME="$HOME/grails"
  export PATH="$PATH:$GRAILS_HOME/bin"
fi

# Maven setup
if [[ -d "/opt/apache-maven" ]]; then
  export PATH="$PATH:/opt/apache-maven/bin"
fi

# Setup Go-lang environment
GOROOT="/usr/local/go"
if [ -d "$GOROOT" ]; then
  export GOROOT
  export PATH="$PATH:$GOROOT/bin"
  export GOPATH="$HOME/devel/gocode"
  export CDPATH="$CDPATH:$GOPATH/src/github.com/jhillyerd"
fi
