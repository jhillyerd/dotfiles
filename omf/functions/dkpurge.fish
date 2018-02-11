function dkpurge -d "Kill and remove all Docker containers and images"
  echo "Killing any running containers..."
  docker ps -q | xargs -r docker kill

  echo "Deleting all containers..."
  docker ps -qa | xargs -r docker rm --volumes

  echo "Deleting all images..."
  while true
    set -l images (docker images -qa)
    if test (count $images) -eq 0
      break
    end
    docker rmi $images[1]
  end
end
