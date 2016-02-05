function ghclone -a repo args -d "Clone a github repo"
  git clone "https://jhillyerd@github.com/$repo" $args
end
