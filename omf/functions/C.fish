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
    xclip -selection c < $snipdir/$name
    echo "$name copied!"
  end
end
