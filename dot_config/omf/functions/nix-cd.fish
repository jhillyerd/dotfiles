function nix-cd -d "cd to store owning specified file in path"
  set -l pathels (string split / (readlink -f (which $argv[1])))
  cd (string join / $pathels[1..-3])
end
