function sync-notes
  pushd $HOME/logseq
  set -l dirs notes work-notes

  for dir in $dirs
    if ! test -x $dir/quicksync.sh
      echo "### Skipping: $dir"
      continue
    end

    pushd $dir
    echo "### Syncing: $dir"
    ./quicksync.sh
    popd
  end

  popd
end

