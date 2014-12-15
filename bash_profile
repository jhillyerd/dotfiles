# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export PATH=$PATH:$HOME/bin
export EDITOR=vim

# Proxy config
if hostname --fqdn | egrep 'nintendo|noa'; then
  proxy_host=proxysg.noa.com:8080
  http_proxy=$proxy_host
  https_proxy=$proxy_host
  HTTP_PROXY=$proxy_host
  HTTPS_PROXY=$proxy_host
  export http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
fi

# Handle unsupported terminal types
if ! infocmp "$TERM" >/dev/null; then
  if [[ "$TERM" == *screen* ]]; then
    export TERM=screen
  else
    export TERM=xterm-color
  fi
fi
