cmake_minimum_required(VERSION 3.15)

set(PROJECT_NAME gemini)
project(${PROJECT_NAME} LANGUAGES C CXX ASM)

# set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/cmake/arm-gcc-toolchain.cmake")

# add_subdirectory(M4)
if(CFG_CORE STREQUAL "M4")
    message(STATUS "Configuring for M4 core")
    add_subdirectory(M4)
elseif(CFG_CORE STREQUAL "M7")
    message(STATUS "Configuring for M7 core")
    add_subdirectory(M7)
else()
    message(FATAL_ERROR "Unknown core specified. Please set CFG_CORE to either 'M7' or 'M4'.")
endif()