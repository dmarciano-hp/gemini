#!/bin/bash

PRESET_NAME=cm4_build_dev

PRESET_OPTION=$1

if [ "$PRESET_OPTION" == "1" ]; then
    echo "Building for CM4 Build Development..."
    PRESET_NAME=cm4_build_dev
elif [ "$PRESET_OPTION" == "2" ]; then
    echo "Building for CM7 Build Development..."
    PRESET_NAME=cm7_build_dev
else
    echo "No valid preset option provided. Defaulting to CM4 Build Development."

    echo "Available options:"
    echo "  1: CM4 Build Development"
    echo "  2: CM7 Build Development"
fi

BUILD_DIR=build
OUTPUT_DIR=build/$PRESET_NAME

if [ ! -d "$BUILD_DIR" ]; then
    mkdir -p $BUILD_DIR
fi

# cmake --preset $PRESET_NAME
cmake -B $OUTPUT_DIR --preset $PRESET_NAME
cmake --build $OUTPUT_DIR --target all -- -j 8

# Python script to combine 2 binaries for flashing