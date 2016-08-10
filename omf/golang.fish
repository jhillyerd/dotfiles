# Setup Go-lang environment

set -l gocode $HOME/devel/gocode
set -l godeps $HOME/devel/godeps
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

if test -d $godeps
  if test -d $godeps/bin; and not contains $godeps/bin $PATH
    set -x PATH $godeps/bin $PATH
  end

  set -g -x GOPATH $HOME/devel/godeps:$HOME/devel/gocode

  if not contains $mycdpath $CDPATH
    set -U CDPATH $mycdpath $CDPATH
  end
end
