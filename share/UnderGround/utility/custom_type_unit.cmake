
function ( ug_custom_type_unit 
    uname 
    include_dirs 
    lnk_lib 
    dep_units 
)
    target_link_libraries( ${uname} ${lnk_lib} )
    target_include_directories( ${uname} PUBLIC ${include_dirs})
    if( WIN32 )
        target_link_libraries( ${uname} ws2_32 )
    endif()
    add_dependencies( ${uname} ${dep_units} )
    if ( ${SHOW_DEPS} )
        message(STATUS "dep : ${uname} <- ${dep_units}")
    endif()
endfunction()

