function __relative_complete_dir -a path
  cd $path
  find . -maxdepth 1 -type d | string replace -f -r '\./(.*)' '$1' |sort
end
