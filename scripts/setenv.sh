#!/bin/bash

# Get absolute path to the root of the repo (assuming this script is in scripts/)
export APP_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export UNPACKERS_PATH="$APP_PATH/build/_deps/unpackers-src"

export APP_CMAKE_PREFIX_PATH="$APP_PATH/install"
export CMAKE_PREFIX_PATH="$APP_CMAKE_PREFIX_PATH:$CMAKE_PREFIX_PATH"

export ROOT_INCLUDE_PATH=$ROOT_INCLUDE_PATH:$APP_PATH/install/include:$(pkg-config --cflags nlohmann_json 2>/dev/null | sed 's/-I//g')
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$APP_PATH/install/lib
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$APP_PATH/install/lib

echo "Environment configured from $APP_PATH"
