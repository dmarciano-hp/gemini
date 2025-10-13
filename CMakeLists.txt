cmake_minimum_required(VERSION 3.15)

set(PROJECT_NAME gemini)
project(${PROJECT_NAME} LANGUAGES C CXX ASM)

if(CFG_BUILD_TYPE STREQUAL "DEV")
    message(STATUS "Configuring for Development build")
    add_compile_definitions(DEV_BUILD)
elseif(CFG_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "Configuring for Debug build")
    add_compile_definitions(DEBUG_BUILD)
elseif(CFG_BUILD_TYPE STREQUAL "Release")
    message(STATUS "Configuring for Release build")
    add_compile_definitions(RELEASE_BUILD)
else()
    message(FATAL_ERROR "Unknown build type specified. Please set CFG_BUILD_TYPE to either 'DEV', 'Debug', or 'Release'.")
endif()

if(CFG_CORE STREQUAL "M4")
    message(STATUS "Configuring for M4 core")
    add_subdirectory(m4)
elseif(CFG_CORE STREQUAL "M7")
    message(STATUS "Configuring for M7 core")
    add_subdirectory(m7)
else()
    message(FATAL_ERROR "Unknown core specified. Please set CFG_CORE to either 'M7' or 'M4'.")
endif()

target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_SOURCE_DIR}/lib/CMSIS/Device/ST/STM32H7xx/Include
    ${CMAKE_SOURCE_DIR}/lib/CMSIS/Include
    ${CMAKE_SOURCE_DIR}/lib/STM32H7xx_HAL_Driver/Inc
)