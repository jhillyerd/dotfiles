function ghseto -a repo -d "Set origin to my github account, -s for ssh"
  set -l name_url origin "https://jhillyerd@github.com/$repo"

  if test $repo = "-s"
    # -s argument uses ssh instead of https
    set repo $argv[2]
    set name_url origin "git@github.com:"$repo".git"
  end

  git remote set-url $name_url 2>/dev/null; or git remote add $name_url
end
