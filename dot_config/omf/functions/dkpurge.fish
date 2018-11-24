function dkpurge -d "Kill and remove all Docker containers and images"
  echo "Killing any running containers..."
  docker ps -q | xargs -r docker container kill

  echo "Deleting all containers..."
  docker container prune --force

  echo "Deleting all images..."
  docker image prune --all --force
end
