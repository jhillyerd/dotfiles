function ghclone -a repo directory -d "Clone a github repo"
  # -s argument uses ssh instead of https
  if test $repo = "-s"
    set repo $argv[2]
    if test (count $argv) -ge 3
      set directory $argv[3]
    else
      set -e directory
    end
    git clone "git@github.com:"$repo".git" $directory
  else
    git clone "https://jhillyerd@github.com/$repo" $directory
  end
end
