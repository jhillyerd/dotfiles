# Environment setup
if not set -q EDITOR
  set -x EDITOR vim
end

if not contains . $CDPATH
  set -x CDPATH . $CDPATH
end

if test -d /usr/local/bin
  set -x PATH /usr/local/bin $PATH
end

if test -d $HOME/bin
  set -x PATH $HOME/bin $PATH
end

if test $TERM = 'xterm'
  set -xg TERM 'xterm-256color'
end

#echo INIT $SHLVL
source $OMF_CONFIG/golang.fish

abbr -a dk docker
