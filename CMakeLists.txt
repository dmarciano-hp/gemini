cmake_minimum_required(VERSION 3.15)
project(stm32h745_dualcore_cmake C CXX ASM)

set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/cmake/arm-gcc-toolchain.cmake")

if(${CFG_CORE} STREQUAL "M7")
(
    message(STATUS "Configuring for M7 core")
    add_subdirectory(M7)
)
elseif(${CFG_CORE} STREQUAL "M4")
(
    message(STATUS "Configuring for M4 core")
    add_subdirectory(M4)
)
else()
(
    message(FATAL_ERROR "Unknown core specified. Please set CFG_CORE to either 'M7' or 'M4'.")
)