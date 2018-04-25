#!/bin/bash

if [ '$(docker ps -qa --filter "name=ror-test")' != '' ]; then
    docker stop -t 0 ror-test
    docker rm ror-test
fi

./build.sh
docker create --name ror-test dtfuller-ror:latest
docker start ror-test
docker exec -it ror-test bash
