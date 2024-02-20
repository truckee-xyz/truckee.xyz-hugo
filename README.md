![truckee-xyz-background-3x-scale](https://github.com/truckee-xyz/truckee.xyz-hugo/assets/24551292/f8ccf6f8-be54-4c2a-8b58-bcc3f8462b98)
# truckee.xyz-hugo
The Hugo static site generator files and build scripts for truckee.xyz

## to build dev containers locally
the `./docker.sh` script is a wrapper around some docker commands to build all the requisite containers you need

### build hugo dev container
```
./docker.sh build
```

### run hugo local dev server and visit it on localhost:8080 in a browser
```
./docker.sh server
```

### run a debug container get a bash shell in the hugo container
```
./docker.sh debug
```

### generate the static files in ./truckee.xyz/public
```
./docker.sh ssg
```

## to build the containers in github

create a new tag with the following prepended to the name `build-docker`. anything can follow the `build-docker` as the github workflow is looking at the regex `build-docker*`

## deploy the site to staging.truckee.xyz

create a new tag with the following prepended to the name `deploy-staging`. anything can follow the `deploy-staging` as the github workflow is looking at the regex `deploy-staging*`
