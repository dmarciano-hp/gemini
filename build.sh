rm -rf build/

cmake -S . -B build/
cmake --build build/ --target all -- -j 8

# Build for CM4

# Build for CM7

# Python script to combine 2 binaries for flashing