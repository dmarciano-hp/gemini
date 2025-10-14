target_link_options(${PROJECT_NAME} PRIVATE
    -nostartfiles
    -Wl,--gc-sections
)