message( "ExteralProject - SDL2" )
ep_option( SDL2_EP_SRC       ${DEFAULT_EP_SRC} )
if      ( ${SDL2_EP_SRC} STREQUAL "PRE_BUILD" )
    ep_option( SDL2_INSTALL_PATH ${DEFAULT_EP_INSTALL_PATH} )
    ep_option_fset( SDL2_BUILD_SHARED OFF )
    set( SDL2_ROOT ${SDL2_INSTALL_PATH} )
    add_custom_target( SDL2_BUILD ALL
        ${CMAKE_COMMAND} 
            -DFILE_TO_CHECK="${CMAKE_BINARY_DIR}/SDL2/pre-build-done"
            -DPREBUILD_NAME="SDL2"
            -DPREBUILD_DIR="${UNDER_GROUND_PREBUILD}/SDL2-2.0.5"
            -DDES_DIR=${SDL2_INSTALL_PATH}
            -DSYS_MARCH=${SYS_MARCH}
            -DCMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}
            -DCMAKE_CXX_COMPILER_ID=${CMAKE_CXX_COMPILER_ID}
            -P ${UNDER_GROUND_CMAKE_DIR}/install_prebuild.cmake
    )
    set( sdl2_DIR "${SDL2_ROOT}/lib/cmake/SDL2")
    show_var(sdl2_DIR)
elseif ( ${SDL2_EP_SRC} STREQUAL "SYSTEM" )
    find_package( SDL2 REQUIRED )
    if ( ${SDL2_FOUND} )
        add_custom_target( SDL2_BUILD )
    endif()
    ep_option_fset( SDL2_INSTALL_PATH "(deprecated)" )
    ep_option_fset( SDL2_BUILD_SHARED OFF )
elseif ( ${SDL2_EP_SRC} STREQUAL "REMOTE_SOURCE" )
    message( FATAL "Remote source of SDL2 is not yet support.")
    # ep_option( SDL2_INSTALL_PATH ${DEFAULT_EP_INSTALL_PATH} )
    # ep_option_fset( SDL2_BUILD_SHARED OFF )
    # set ( SDL2_FOUND OFF )
    # set ( SDL2_URL "https://github.com/google/googletest/archive/master.zip" )
    # set ( SDL2_STATICLIB NOT ${SDL2_BUILD_SHARED} )
    # ExternalProject_add(SDL2_BUILD
    #     PREFIX ${CMAKE_BINARY_DIR}/SDL2/
    #     DOWNLOAD_DIR ${CMAKE_BINARY_DIR}/SDL2/download
    #     SOURCE_DIR ${CMAKE_BINARY_DIR}/SDL2/source
    #     BINARY_DIR ${CMAKE_BINARY_DIR}/SDL2/build
    #     URL ${SDL2_URL}
    #     UPDATE_COMMAND ""
    #     CMAKE_GENERATOR ${gen}
    #     CMAKE_ARGS
    #         -DCMAKE_INSTALL_PREFIX:PATH=${SDL2_INSTALL_PATH}
    #     INSTALL_DIR ${SDL2_INSTALL_PATH}
    # )
    # set( SDL2_ROOT ${SDL2_INSTALL_PATH} )
else ()
    unknow_variable_exception( SDL2_EP_SRC )
endif ()
