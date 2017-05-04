find_package( sdl2 CONFIG REQUIRED )
if( ${SDL2_FOUND} ) cmake config not support this variable
    add_custom_target(SDL2_CONFIG)
endif()
show_var ( SDL2_INCLUDE_DIRS   )
show_var ( SDL2_LIBRARIES      )
show_var ( SDL2_LIBDIR         )