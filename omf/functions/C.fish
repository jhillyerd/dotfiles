function C -d "List files and prompt for selection, copies to clipboard"
  set -l snipdir $HOME/Copy

  # List files
  set -l snipfiles (ls $snipdir)
  for i in (seq (count $snipfiles))
    echo "$i. $snipfiles[$i]"
  end

  # Prompt & copy
  read -P "Snippet to copy: " choice
  if test -z $choice
    exit
  end
  set -l name $snipfiles[$choice]
  if test -n $name
    set -l file $snipdir/$name
    # Get extension
    set -l matches (string match -r '\.([^.]+)$' $name)
    set -l ext txt
    if test (count $matches) -gt 1
      set ext $matches[2]
    end
    if contains -- -e $argv
      set -l tfile (mktemp --tmpdir Cedit.XXXXXXXXXX.$ext)
      cp -f $file $tfile
      set file $tfile
      vim $file
    end
    xclip -selection c < $file
    echo "$name copied from $file!"
  end
end
