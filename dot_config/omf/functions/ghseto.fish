function ghseto -a repo -d "Set origin to my github account, -s for ssh"
  # -s argument uses ssh instead of https
  if test $repo = "-s"
    set repo $argv[2]
    git remote set-url origin "git@github.com:"$repo".git"
  else
    git remote set-url origin "https://jhillyerd@github.com/$repo"
  end
end
