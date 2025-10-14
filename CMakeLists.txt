cmake_minimum_required(VERSION 3.15)

set(PROJECT_NAME gemini)
project(${PROJECT_NAME} LANGUAGES C CXX ASM)

add_executable(${PROJECT_NAME} ${CFG_CORE}/main.c)

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


if(CFG_CORE)
    message(STATUS "Configuring for ${CFG_CORE} core")
    add_subdirectory(${CFG_CORE})
else()
    message(FATAL_ERROR "Unknown core specified. Please set CFG_CORE to either 'M7' or 'M4'.")
endif()

target_sources(${PROJECT_NAME} PRIVATE
    "${CMAKE_SOURCE_DIR}/board/startup/startup_stm32h745xx.s"
    "${CMAKE_SOURCE_DIR}/lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal.c"
    "${CMAKE_SOURCE_DIR}/lib/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_gpio.c"
)

target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_SOURCE_DIR}/lib/CMSIS/Device/ST/STM32H7xx/Include
    ${CMAKE_SOURCE_DIR}/lib/CMSIS/Include
    ${CMAKE_SOURCE_DIR}/lib/STM32H7xx_HAL_Driver/Inc
)

include("cmake/compile_options/compile_options_${CFG_CORE}.cmake")

include("cmake/compile_options/common_options.cmake")

include("cmake/post_build.cmake")