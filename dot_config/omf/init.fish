# Path setup
if test -d $HOME/devel
  set -xg CDPATH . $HOME/devel
end

function _bin_path -a path -d "Prepend path if not already present"
  if not string match -q $path $PATH; and test -d $path
    set -x PATH $path $PATH
  end
end

_bin_path /usr/local/bin
_bin_path $HOME/google-cloud-sdk/bin
_bin_path $HOME/go/bin
_bin_path $HOME/.cargo/bin
_bin_path $HOME/.scripts
_bin_path $HOME/bin
functions -e _bin_path

# Environment setup
if test "$TERM" = "xterm"
  set -xg TERM "xterm-256color"
end

if test -n "$WSL_DISTRO_NAME"
  set -xg BROWSER "/mnt/c/Program Files/Mozilla Firefox/firefox.exe"
end

set -xg EDITOR nvim
set -xg VISUAL nvim

# Abbreviations
abbr -ag -- - cd -

abbr -ag cm chezmoi
abbr -ag cma chezmoi apply -v
abbr -ag cmcd chezmoi cd
abbr -ag cmu chezmoi update -v

abbr -ag dk docker
abbr -ag dkclean docker container prune --force
abbr -ag dke docker exec -it
abbr -ag dki docker run -itP --rm

abbr -ag ghb gh browse
abbr -ag ghwatch "gh pr checks --watch; notify-send 'PR checks done'"

abbr -ag kk kubectl kustomize
abbr -ag lg lazygit
abbr -ag tf terraform

abbr -ag nfish "nix-shell --command 'SHELL=fish; exec fish'"
abbr -ag nfish! "nix-shell -I nixpkgs=/home/james/nixpkgs --command 'SHELL=fish; exec fish'"

abbr -ag hdel history delete --case-sensitive --exact \$history[1]

abbr -ag run-inbucket "tmux neww -n inbucketd $HOME/dev-start.sh \; set remain-on-exit failed \; splitw"

if command -q bat
  abbr -ag cat bat
end

# Key bindings
bind \co nvim-last-file
bind \cp fzf-file-widget

if command -q direnv
  direnv hook fish | source
end
