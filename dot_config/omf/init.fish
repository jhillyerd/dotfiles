function _bin_path -a path -d "Prepend path if not already present"
  if not string match -q $path $PATH; and test -d $path
    set -x PATH $path $PATH
  end
end

# Path setup
if test -d $HOME/devel
  set -xg CDPATH . $HOME/devel
end

_bin_path /usr/local/bin
_bin_path /usr/local/node/bin
_bin_path $HOME/google-cloud-sdk/bin
_bin_path $HOME/.cargo/bin
_bin_path $HOME/.scripts
_bin_path $HOME/bin

# Environment setup
if test $TERM = 'xterm'
  set -xg TERM 'xterm-256color'
end

set -xg EDITOR vim
set -xg VISUAL vim

source $OMF_CONFIG/golang.fish

# Abbreviations
abbr --add ccd chezmoi cd
abbr --add cea chezmoi edit --apply --diff
abbr --add cu chezmoi update -v
abbr --add dc docker-compose
abbr --add dk docker
abbr --add dkclean docker container prune --force
abbr --add dke docker exec -it
abbr --add dki docker run -itP --rm
abbr --add nfish "nix-shell --command 'SHELL=fish; exec fish'"
abbr --add nfish! "nix-shell -I nixpkgs=/home/james/nixpkgs --command 'SHELL=fish; exec fish'"

# Key bindings
bind \cp fzf-file-widget

# Cleanup
functions -e _bin_path
