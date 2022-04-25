function cme -a editpath -d "Chezmoi edit file; prompts with fzf"
  if test -z "$editpath"
    set editpath (chezmoi managed --include files --no-pager | fzf)
  end

  pushd ~
  chezmoi edit --apply $editpath
  popd
end
