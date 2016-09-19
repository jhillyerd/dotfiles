complete -f -c g4d -s f -d "Create if non-existent"
complete -f -c g4d -l multichange
complete -f -c g4d -l nomultichange
complete -x -c g4d -s u -d "User"
complete -x -c g4d -a "(/usr/bin/g4 -ztag clients -u $LOGNAME | grep 'Root ' | sed -e 's#.*Root /google/src/cloud/.*/\(.*\)\$#\1#' | sort)"
