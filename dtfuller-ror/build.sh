#!/bin/bash
if [[ $BUILD_WITH_CACHE = 'false' ]]; then
    echo "building without cache."
    docker build --no-cache -f dtfuller-ror.dockerfile -t dtfuller-ror:latest .
else
    echo "building with cache."
    docker build -f dtfuller-ror.dockerfile -t dtfuller-ror:latest . 
fi
