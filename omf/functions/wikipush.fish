function wikipush -d "Commit and push ~/wiki"
  set -l msg (string join " " wiki from (hostname) on (date))
  cd ~/wiki; or return $status
  git add --all; or return $status
  git commit -m $msg; or return $status
  git push; or return $status
  cd -
end
