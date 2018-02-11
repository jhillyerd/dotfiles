function dkclean -d "Remove non-running docker containers"
  docker ps --quiet --filter status=exited | xargs -r docker rm --volumes
end
