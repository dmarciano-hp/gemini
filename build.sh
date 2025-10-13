PRESET_NAME=cm4_build_dev

rm -rf build/$PRESET_NAME

mkdir -p build/$PRESET_NAME

# cmake -DCMAKE_MAKE_PROGRAM=/usr/bin/make --preset $PRESET_NAME

cmake --preset $PRESET_NAME
cmake --build build/$PRESET_NAME --target clean

# Build for CM4

# Build for CM7

# Python script to combine 2 binaries for flashing