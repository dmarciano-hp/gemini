
# M7 specific flags
target_compile_options(${PROJECT_NAME} PRIVATE
    -mcpu=cortex-m7
    -mthumb
    -mfpu=fpv5-d16
    -mfloat-abi=softfp
    -DCORE_CM7=1
    -DUSE_HAL_DRIVER
    -DSTM32H745xx
)