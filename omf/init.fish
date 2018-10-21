function _bin_path -a path -d "Add PATH if not already present"
  if not string match -q $path $PATH; and test -d $path
    set -x PATH $path $PATH
  end
end

# Path setup
set -x CDPATH . $HOME/devel

_bin_path /usr/local/bin
_bin_path /usr/local/node/bin
_bin_path $HOME/google-cloud-sdk/bin
_bin_path $HOME/.dotfiles/bin
_bin_path $HOME/bin

# Environment setup
if test $TERM = 'xterm'
  set -xg TERM 'xterm-256color'
end

if test -z $EDITOR
  set -xg EDITOR vim
end

source $OMF_CONFIG/golang.fish

# Abbreviations
abbr --add dc docker-compose
abbr --add dk docker
abbr --add dkclean docker container prune --force
abbr --add dke docker exec -it
abbr --add dki docker run -itP

# Cleanup
functions -e _bin_path
