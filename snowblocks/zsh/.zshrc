function docker-build () {
  docker build -t "$1" -f "$1/Dockerfile" .
}

function docker-clean () {
  docker stop $(docker ps -aq)
  docker rm $(docker ps -aq)
  docker rmi $(docker images -q)
}

function docker-push-image () {
  docker tag "$1" "${DOCKER_ID_USER}/$1"
  docker push "${DOCKER_ID_USER}/$1"
}

function ext-sha256 () {
  # 1 = publisher
  # 2 = extension
  # 3 = version
  curl "https://$1.gallery.vsassets.io/_apis/public/gallery/publisher/$1/extension/$2/$3/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage" -o tmp.vsix

  printf "%s" $(sha256sum tmp.vsix)
  rm -f tmp.vsix
}
