![truckee-xyz-background-3x-scale](https://github.com/truckee-xyz/truckee.xyz-hugo/assets/24551292/f8ccf6f8-be54-4c2a-8b58-bcc3f8462b98)
# truckee.xyz-hugo
The Hugo static site generator files and build scripts for truckee.xyz

## to build dev containers locally
the `./docker.sh` script is a wrapper around some docker commands to build all the requisite containers you need

### build and run hugo dev container so you can view it on localhost:8080
```
./docker.sh build_dev
./docker.sh run_dev
```

### build and run a debug container get a bash shell in the hugo container
```
./docker.sh build_debug
./docker.sh run_debug
```

### build the container to generate the static files and run the container to generate the static files
```
./docker.sh build_ssg
./docker.sh run_ssg
```

## to build the containers in github

create a new tag with the following prepended to the name `build-docker`. anything can follow the `build-docker` as the github workflow is looking at the regex `build-docker*`

## generate the static site files in github

create a new tag with the following prepended to the name `build-site`. anything can follow the `build-site` as the github workflow is looking at the regex `build-site*`
