function nix-stray-roots -d "list stray gcroots"
  nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/\w+-system|\{memory)'
end
