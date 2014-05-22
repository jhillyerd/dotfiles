# To use, set ZSH_PROXY_HOST and optionally ZSH_PROXY_USER in your zshrc.
# ZSH_PROXY_HOST should be in the format of "host:port"

if [ -n "$ZSH_PROXY_HOST" ]; then
    function _zsh_proxy_set() {
        proxy_envars=(http_proxy ftp_proxy https_proxy all_proxy no_proxy HTTP_PROXY
            HTTPS_PROXY FTP_PROXY NO_PROXY ALL_PROXY)

        for envar in ${proxy_envars[@]}; do
            if [ -n "$1" ]; then
                export $envar=$1
            else
                unset $envar
            fi
        done
    }

    function proxy() {
        user="$ZSH_PROXY_USER"
        if [ -z "$user" ]; then
            read "user?Proxy User: "
        fi
        read -s "pass?Password: " && echo
        # URL encode password
        setopt localoptions extendedglob
        pchars=( ${(s::)pass} )
        pass="${(j::)pchars/(#b)([^A-Za-z0-9_.!~*\'\(\)-])/%$(([##16]#match))}"
        proxy_val="http://$user:$pass@$ZSH_PROXY_HOST"
        _zsh_proxy_set "$proxy_val"
    }

    function noproxy() {
        _zsh_proxy_set ""
    }

    # Initial proxy setup - no auth info
    _zsh_proxy_set "http://$ZSH_PROXY_HOST"
fi

# vi:sw=4:ts=4:et
