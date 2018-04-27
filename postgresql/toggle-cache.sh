#!/bin/bash 
if [[ -z $BUILD_WITH_CACHE || $BUILD_WITH_CACHE = 'false' ]]; then
    BUILD_WITH_CACHE='true'
else
    BUILD_WITH_CACHE='false'
fi

echo "BUILD_WITH_CACHE is $BUILD_WITH_CACHE";
export BUILD_WITH_CACHE;
