#!/bin/bash

image_name="truckee-xyz"
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
* server - run the development container so you can see the changes in a webpage on localhost:8080
* build_debug - build the dev-container in debug mode so you can get a shell
* run_debug - run the development container in debug mode so you get a bash shell in it
* build_ssg - build the hugo static site generator container, useful if we need to update hugo
* run_ssg - generate the static files with hugo to be pushed to https://github.com/truckee-xyz/truckee.xyz repository
'
  echo "$help_string"
}

build_dev_container(){
  dev_image_tag="${image_name}:dev_${current_datetime}"
  docker build . -t "${dev_image_tag}" --target dev
}

run_dev_container(){
  latest_dev_tag="$(docker images truckee-xyz:dev* | \
    tail -n 1 | \
    awk '{print $2}')"
  docker run --rm -it -p 8080:8080 truckee-xyz:"${latest_dev_tag}"
}

build_debug_container(){
  debug_image_tag="${image_name}:debug_${current_datetime}"
  docker build . -t "${debug_image_tag}" --target debug
}

run_debug_container(){
  latest_debug_tag="$(docker images truckee-xyz:debug* | \
    tail -n 1 | \
    awk '{print $2}')"
  docker run --rm -it -p 8080:8080 truckee-xyz:"${latest_debug_tag}"
}

build_ssg_container(){
  static_build_image_tag="${image_name}:ssg_${current_datetime}"
  docker build . -t "${static_build_image_tag}" --target ssg
}

run_ssg_container(){
  latest_ssg_tag="$(docker images truckee-xyz:ssg* | \
    tail -n 1 | \
    awk '{print $2}')"
  outdir="$(mktemp -d -p ./generated_site build.XXXXXXXXXX)"
  docker run --rm -it -v "${outdir}":/app/public truckee-xyz:"${latest_ssg_tag}"
  echo "find generated filed in ${outdir}"
}

case "${1}" in
  build_dev) build_dev_container;;
  run_dev) run_dev_container;;
  build_debug) build_debug_container;;
  run_debug) run_debug_container;;
  build_ssg) build_ssg_container;;
  run_ssg) run_ssg_static;;
  help) print_help;;
  *) print_help;;
esac
