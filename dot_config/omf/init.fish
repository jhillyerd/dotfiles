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

set -xg GOPATH $HOME/go

# Environment setup
if test "$TERM" = 'xterm'
  set -xg TERM 'xterm-256color'
end

set -xg EDITOR nvim
set -xg VISUAL nvim

# Abbreviations
abbr -a -g cm chezmoi
abbr -a -g cma chezmoi apply -v
abbr -a -g cmcd chezmoi cd
abbr -a -g cme chezmoi edit --apply --diff
abbr -a -g cmu chezmoi update -v

abbr -a -g dc docker-compose
abbr -a -g dk docker
abbr -a -g dkclean docker container prune --force
abbr -a -g dke docker exec -it
abbr -a -g dki docker run -itP --rm

abbr -a -g nfish "nix-shell --command 'SHELL=fish; exec fish'"
abbr -a -g nfish! "nix-shell -I nixpkgs=/home/james/nixpkgs --command 'SHELL=fish; exec fish'"

abbr -a -g hdel history delete --case-sensitive --exact \$history[1]

# Key bindings
bind \cp fzf-file-widget

# Cleanup
functions -e _bin_path
