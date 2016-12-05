# Setup Go-lang environment

set -l gocode $HOME/go
set -l mycdpath $gocode/src/github.com/jhillyerd

if not set -q GOROOT
  set -x GOROOT /usr/local/go
end

if test -d $GOROOT/bin
  if not contains $GOROOT/bin $PATH
    set -x PATH $GOROOT/bin $PATH
  end
else
  set -e GOROOT
end

if test -d $gocode
  if test -d $gocode/bin; and not contains $gocode/bin $PATH
    set -x PATH $gocode/bin $PATH
  end

  set -g -x GOPATH $gocode

  if not contains $mycdpath $CDPATH
    set -U CDPATH $mycdpath $CDPATH
  end
end
