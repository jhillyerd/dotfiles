function _bin_path -a path -d "Add PATH if not already present"
  if not string match -q $path $PATH; and test -d $path
    set -x PATH $path $PATH
  end
end

# Path setup
if not contains . $CDPATH
  set -x CDPATH . $CDPATH
end

_bin_path /usr/local/bin
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

if test -r /google/data/ro/teams/fish/google.fish
  source /google/data/ro/teams/fish/google.fish
end

# Abbreviations
abbr -a dk docker

# Cleanup
functions -e _bin_path
