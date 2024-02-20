#!/bin/bash

image_name="truckee.xyz-hugo"
current_datetime="$(date +%Y%m%d%H%M%S)"

print_help(){
  help_string='docker.sh - utility to build and develop on the site locally

  SYNOPSIS
This script is mostly a wrapper around docker to provide quality of life improvements around developing the truckee-xyz site.

  USAGE
./docker.sh [COMMAND]

  EXAMPLE
./docker.sh help
./docker.sh build
./docker.sh debug
./docker.sh server
./docker.sh run_ssg


  COMMANDS
* build - build the docker container to have a running hugo server
* debug - run the development container in debug mode so you get a bash shell in it
* server - run the development container so you can see the changes in a webpage on localhost:8080
* ssg - generate the static files with hugo to be pushed to https://github.com/truckee-xyz/truckee.xyz repository
'
  echo "$help_string"
}

build_container(){
  image_tag="${image_name}:${current_datetime}"
  docker build . -t "${image_tag}"
}

run_debug(){
  latest_image_tag="$(docker images truckee.xyz-hugo:* | \
    tail -n 1 | \
    awk '{print $2}')"
      docker run --rm -it -v $(pwd)/truckee.xyz:/app -p 8080:8080 truckee.xyz-hugo:"${latest_image_tag}" /bin/bash
}

run_server(){
  latest_image_tag="$(docker images truckee.xyz-hugo:* | \
    tail -n 1 | \
    awk '{print $2}')"
  docker run --rm -it -v $(pwd)/truckee.xyz:/app -p 8080:8080 truckee.xyz-hugo:"${latest_image_tag}" /bin/bash -c 'cd /app ; hugo server --bind 0.0.0.0 --port 8080'
}

run_ssg(){
  latest_image_tag="$(docker images truckee.xyz-hugo:* | \
    tail -n 1 | \
    awk '{print $2}')"
  docker run --rm -it \
    -v $(pwd)/truckee.xyz:/app \
    -p 8080:8080 \
    truckee.xyz-hugo:"${latest_image_tag}" /bin/bash -c 'cd /app ; /usr/bin/hugo'
}

case "${1}" in
  build) build_container;;
  debug) run_debug;;
  server) run_server;;
  ssg) run_ssg;;
  help) print_help;;
  *) print_help;;
esac
