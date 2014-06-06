# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme yimmy

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
set fish_plugins git proxy

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/.dotfiles/oh-my-fish

# Environment setup
if not set -q EDITOR
  set -x EDITOR vim
end

if test -d $HOME/bin
  set -x PATH $HOME/bin $PATH
end

# Host specific
switch (hostname -s)
  case jamehi03lx noardestls01
    set proxy_host proxysg.noa.com:8080
    set proxy_user jamehi03
end

# Load oh-my-fish configuration.
source $fish_path/oh-my-fish.fish
