message( "ExteralProject - Boost" )
ep_option( BOOST_EP_SRC       ${DEFAULT_EP_SRC} )
show_var( BOOST_EP_SRC )
if      ( ${BOOST_EP_SRC} STREQUAL "PRE_BUILD" )
    ep_option( BOOST_INSTALL_PATH ${DEFAULT_EP_INSTALL_PATH} ) 
    ep_option_fset( BOOST_BUILD_SHARED "(deprecated)" )
    set( BOOST_ROOT ${BOOST_INSTALL_PATH} )
    add_custom_target( BOOST_BUILD ALL
        ${CMAKE_COMMAND} 
            -DFILE_TO_CHECK="${CMAKE_BINARY_DIR}/BOOST/pre-build-done"
            -DPREBUILD_NAME="BOOST"
            -DPREBUILD_DIR="${UNDER_GROUND_PREBUILD}/boost1_63"
            -DDES_DIR=${BOOST_INSTALL_PATH}
            -DSYS_MARCH=${SYS_MARCH}
            -DCMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}
            -DCMAKE_CXX_COMPILER_ID=${CMAKE_CXX_COMPILER_ID}
            -P ${UNDER_GROUND_CMAKE_DIR}/install_prebuild.cmake
    )
elseif ( ${BOOST_EP_SRC} STREQUAL "SYSTEM" )
    find_boost()
    ep_option_fset( BOOST_INSTALL_PATH ${BOOST_ROOT} )
    ep_option_fset( BOOST_BUILD_SHARED "(deprecated)" )
    add_custom_target( BOOST_BUILD )
elseif ( ${BOOST_EP_SRC} STREQUAL "REMOTE_SOURCE" )
    ep_option( BOOST_INSTALL_PATH ${DEFUALT_EP_INSTALL_PATH} )
    ep_option( BOOST_BUILD_SHARED ${DEFUALT_BUILD_SHARED} )
    # download 
    set( Boost_Bootstrap_Command )
    if( UNIX )
        set( Boost_Bootstrap_Command cd ${CMAKE_BINARY_DIR}/BOOST/source && ./bootstrap.sh && cd ${CMAKE_BINARY_DIR} )
        set( Boost_b2_Command ./b2 )
        set( Boost_URL "https://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.bz2" )
    else()
        if( WIN32 )
            if(${CMAKE_GENERATOR} MATCHES "MinGW" )
                set(boost_b2_args toolset=gcc define=_hypot=hypot define=HAVE_SNPRINTF=1 link=shared)
                set(boost_bootstrap_args gcc)
            endif()
            set( Boost_Bootstrap_Command cd ${CMAKE_BINARY_DIR}/BOOST/source && bootstrap.bat ${boost_bootstrap_args} && cd ${CMAKE_BINARY_DIR} )
            set( Boost_b2_Command b2.exe ${boost_b2_args} )
            set( Boost_URL "https://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.7z" )
        endif()
    endif()
    set ( BOOST_STATICLIB NOT ${BOOST_BUILD_SHARED} )
    message( "boost will install : ${BOOST_INSTALL_PATH}" )
    ExternalProject_Add(BOOST_BUILD
        PREFIX ${CMAKE_BINARY_DIR}/BOOST/
        SOURCE_DIR ${CMAKE_BINARY_DIR}/BOOST/source
        BINARY_DIR ${CMAKE_BINARY_DIR}/BOOST/build
        URL ${Boost_URL}
        UPDATE_COMMAND ""
        PATCH_COMMAND ${CMAKE_COMMAND} -E copy 
            ${UNDER_GROUND_CMAKE_DIR}/boost/python3.5/user-config.jam 
            ${CMAKE_BINARY_DIR}/BOOST/source/tools/build/src/
        CONFIGURE_COMMAND ${Boost_Bootstrap_Command}
        BUILD_COMMAND  cd ${CMAKE_BINARY_DIR}/BOOST/source &&
            ${Boost_b2_Command} install
            --debug-configuration
            --prefix=${BOOST_INSTALL_PATH}
            -j2 && 
            cd ${CMAKE_BINARY_DIR}
    INSTALL_COMMAND ""
        INSTALL_DIR ${BOOST_INSTALL_PATH}
    )
    ExternalProject_Add_Step( BOOST_BUILD python2_compile
        DEPENDEES install
        COMMAND ${Boost_b2_Command} --clean &&
        ${CMAKE_COMMAND} -E copy 
            ${UNDER_GROUND_CMAKE_DIR}/boost/python2.7/user-config.jam 
        ${CMAKE_BINARY_DIR}/BOOST/source/tools/build/src/ &&
            ${Boost_b2_Command} install
                --debug-configuration
                --prefix=${BOOST_INSTALL_PATH}
                --with-python
                -j2 
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/BOOST/source
    )
    set ( BOOST_ROOT ${BOOST_INSTALL_PATH} )
else ()
    unknow_variable_exception( BOOST_EP_SRC )
endif()
