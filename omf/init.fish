# Path setup
if not contains . $CDPATH
  set -x CDPATH . $CDPATH
end

if test -d /usr/local/bin
  set -x PATH /usr/local/bin $PATH
end

if test -d $HOME/google-cloud-sdk/bin
  set -x PATH $HOME/google-cloud-sdk/bin $PATH
end

if test -d $HOME/bin
  set -x PATH $HOME/bin $PATH
end

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
