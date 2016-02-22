set fish_greeting (uname -a | cut -d' ' -f1-3)'; load:' \
  (cat /proc/loadavg | cut -d' ' --output-delimiter=', ' -f1-3)

# Environment setup
if not set -q EDITOR
  set -x EDITOR vim
end

if test -d $HOME/bin
  set -x PATH $HOME/bin $PATH
end

#echo INIT $SHLVL
source $OMF_CONFIG/golang.fish

abbr -a dk sudo docker