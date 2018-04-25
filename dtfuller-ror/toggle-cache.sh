#!/bin/bash
if [[ "$BUILD_WITH_CACHE" = 'true' ]]; then
    BUILD_WITH_CACHE='false' 
else
    BUILD_WITH_CACHE='true' 
fi 

export BUILD_WITH_CACHE
echo "BUILD_WITH_CACHE set to $BUILD_WITH_CACHE";

alias t=". ./toggle-cache.sh"
alias b="./build.sh"
alias d="./deploy.sh"
