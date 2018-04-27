#!/bin/bash

docker stop -t 0 test-ps
docker rm test-ps 

if [[ -z $BUILD_WITH_CACHE || $BUILD_WITH_CACHE = 'true' ]]; then
    echo "Building with cache."
    docker build -f ./dtfuller-postgresql.dockerfile -t dtfuller/postgresql:latest . 
elif [[ $BUILD_WITH_CACHE = 'false' ]]; then 
    echo "Building without cache."
    docker build --no-cache -f ./dtfuller-postgresql.dockerfile -t dtfuller/postgresql:latest . 
else
    return 1
fi

docker create --name test-ps dtfuller/postgresql:latest
docker start test-ps
docker exec -it test-ps bash
