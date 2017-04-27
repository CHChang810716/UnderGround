
function ( ug_py_unit2 
    uname 
    pyver
    cxxpath
    include_dirs 
    lnk_lib 
    dep_units 
)
    add_library( ${pyver}${uname} SHARED ${cxxpath} )
    if ( ${pyver} MATCHES "py2" )
        target_compile_definitions( ${pyver}${uname} PRIVATE MODULE_NAME=${pyver}${uname} ${PROJECT_NAME}_PY_VER=2 )
        target_include_directories( ${pyver}${uname} PUBLIC 
            ${PYTHON2_INCLUDE_DIRS} 
            ${include_dirs}
        )
        target_link_libraries( ${pyver}${uname} 
            ${Boost_PYTHON_LIBRARY_RELEASE} 
            ${PYTHON2_LIBRARIES} 
        )
        if( ${SHOW_DEPS} )
            message("dep : ${pyver}${uname} <- Python2")
        endif()
        add_dependencies( ${pyver}${uname} Python2 )
    elseif( ${pyver} MATCHES "py3" )
        target_compile_definitions( ${pyver}${uname} PRIVATE MODULE_NAME=${pyver}${uname} ${PROJECT_NAME}_PY_VER=3 )
        target_include_directories( ${pyver}${uname} PUBLIC 
            ${PYTHON3_INCLUDE_DIRS} 
            ${include_dirs}
        )
        target_link_libraries( ${pyver}${uname} 
            ${Boost_PYTHON3_LIBRARY_RELEASE} 
            ${PYTHON3_LIBRARIES} 
        )
        if ( ${SHOW_DEPS} )
            message("dep : ${pyver}${uname} <- Python3")
        endif()
        add_dependencies( ${pyver}${uname} Python3 )
    endif()
    set_target_properties( ${pyver}${uname} PROPERTIES PREFIX "" )
    if( WIN32 )
        set_target_properties( ${pyver}${uname} PROPERTIES SUFFIX ".pyd" )
    endif()
    ug_custom_type_unit("${pyver}${uname}" "${include_dirs}" "${lnk_lib}" "${dep_units}" )
    
    
endfunction()

function ( ug_py_release_unit2 
    uname 
    pyver
    cxxpath
    include_dirs 
    lnk_lib 
    dep_units 
)
    ug_py_unit2( "${uname}" "${pyver}" "${cxxpath}" "${include_dirs}" 
        "${lnk_lib}" "${dep_units}" 
    )
    ug_release_compile( "${pyver}${uname}" )
endfunction()

function ( ug_py_unit 
    uname 
    pyver
    include_dirs 
    lnk_lib 
    dep_units 
)
    ug_py_unit2( ${uname} ${pyver} "src/${PROJECT_NAME}/application/${uname}/py_module.cpp" "${include_dirs}" "${lnk_lib}" "${dep_units}")
endfunction()

function ( ug_py_release_unit 
    uname 
    pyver
    include_dirs 
    lnk_lib 
    dep_units 
)
    ug_py_unit( "${uname}" "${pyver}" "${include_dirs}" 
        "${lnk_lib}" "${dep_units}" 
    )
    ug_release_compile( "${pyver}${uname}" )
endfunction()
