message( "ExteralProject - GTEST" )
ep_option( GTEST_EP_SRC       ${DEFAULT_EP_SRC} )
if      ( ${GTEST_EP_SRC} STREQUAL "PRE_BUILD" )
    ep_option( GTEST_INSTALL_PATH ${DEFAULT_EP_INSTALL_PATH} )
    ep_option_fset( GTEST_BUILD_SHARED OFF )
    set( GTEST_ROOT ${GTEST_INSTALL_PATH} )
    add_custom_target( GTEST_BUILD ALL
        ${CMAKE_COMMAND} 
            -DFILE_TO_CHECK="${CMAKE_BINARY_DIR}/GTEST/pre-build-done"
            -DPREBUILD_NAME="GTEST"
            -DPREBUILD_DIR="${UNDER_GROUND_PREBUILD}/gtest"
            -DDES_DIR=${GTEST_INSTALL_PATH}
            -DSYS_MARCH=${SYS_MARCH}
            -DCMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}
            -DCMAKE_CXX_COMPILER_ID=${CMAKE_CXX_COMPILER_ID}
            -P ${UNDER_GROUND_CMAKE_DIR}/install_prebuild.cmake
    )
elseif ( ${GTEST_EP_SRC} STREQUAL "SYSTEM" )
    find_package( GTEST REQUIRED )
    if ( ${GTEST_FOUND} )
        add_custom_target( GTEST_BUILD )
    endif()
    ep_option_fset( GTEST_INSTALL_PATH "(deprecated)" )
    ep_option_fset( GTEST_BUILD_SHARED OFF )
elseif ( ${GTEST_EP_SRC} STREQUAL "REMOTE_SOURCE" )
    ep_option( GTEST_INSTALL_PATH ${DEFAULT_EP_INSTALL_PATH} )
    ep_option_fset( GTEST_BUILD_SHARED OFF )
    set ( GTEST_FOUND OFF )
    set ( GTEST_URL "https://github.com/google/googletest/archive/master.zip" )
    set ( GTEST_STATICLIB NOT ${GTEST_BUILD_SHARED} )
    ExternalProject_add(GTEST_BUILD
        PREFIX ${CMAKE_BINARY_DIR}/GTEST/
        DOWNLOAD_DIR ${CMAKE_BINARY_DIR}/GTEST/download
        SOURCE_DIR ${CMAKE_BINARY_DIR}/GTEST/source
        BINARY_DIR ${CMAKE_BINARY_DIR}/GTEST/build
        URL ${GTEST_URL}
        UPDATE_COMMAND ""
        CMAKE_GENERATOR ${gen}
        CMAKE_ARGS
            -DCMAKE_INSTALL_PREFIX:PATH=${GTEST_INSTALL_PATH}
        INSTALL_DIR ${GTEST_INSTALL_PATH}
    )
    set( GTEST_ROOT ${GTEST_INSTALL_PATH} )
else ()
    unknow_variable_exception( GTEST_EP_SRC )
endif ()
