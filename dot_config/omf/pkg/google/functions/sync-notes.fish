function sync-notes
  pushd $HOME/logseq
  set -l dirs notes work-notes

  for dir in $dirs
    pushd $dir
    echo "###" (pwd)
    ./quicksync.sh
    popd
  end

  popd
end

