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

# Key bindings
bind \co nvim-last-file
bind \cp fzf-file-widget

# Abbreviations
abbr -ag -- - cd -
abbr -ag hdel history delete --case-sensitive --exact \$history[1]

abbr -ag cm chezmoi
abbr -ag cma chezmoi apply --interactive
abbr -ag cmcd chezmoi cd
abbr -ag cmra chezmoi re-add --interactive
abbr -ag cmu chezmoi update -v

abbr -ag dk docker
abbr -ag dke docker exec -it
abbr -ag dki docker run -itP --rm

abbr -ag ghb gh browse
abbr -ag ghwatch "gh pr checks --watch; notify-send 'PR checks done'"

abbr -ag hermes ssh -t hermes@hermes.home.arpa hermes chat
abbr -ag hermes? ssh -t hermes@hermes.home.arpa hermes sessions browse
abbr -ag lg lazygit
abbr -ag oc opencode --port
abbr -ag occ opencode --port --continue
abbr -ag vim nvim

# 1Password SSH agent for `ssh-add -l`, etc.
set op_sock $HOME/.1password/agent.sock
if test -z "$SSH_AUTH_SOCK"
  and test -S $op_sock
  and env SSH_AUTH_SOCK=$op_sock ssh-add -l >/dev/null 2>&1
  set -xg SSH_AUTH_SOCK $op_sock
end

# We forward port 9999 for plannotator, so set an environment variable to let
# it know when we're in an SSH session.
if set -q SSH_TTY
  set -xg PLANNOTATOR_REMOTE 1
  set -xg PLANNOTATOR_PORT 9999
end

if command -q bat
  abbr -ag cat bat
end

if command -q direnv
  direnv hook fish | source
end
