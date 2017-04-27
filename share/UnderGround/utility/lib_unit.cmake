if( NOT DEFINED LIB_PREFIX )
    message( WARNING "LIB_PREFIX variable unset, use \"ug\" as default value" )
    set( LIB_PREFIX "ug_" )
else()
    set( LIB_PREFIX "${LIB_PREFIX}_" )
endif()

function ( ug_lib_unit 
    uname 
    build_type
    include_dirs 
    lnk_lib 
    dep_units 
)
    add_library( 
        ${LIB_PREFIX}${uname} 
        ${build_type} 
        src/${PROJECT_NAME}/application/${uname}/lib.cpp 
    )
    ug_custom_type_unit( "${LIB_PREFIX}${uname}" "${include_dirs}" "${lnk_lib}" "${dep_units}" )
    target_compile_definitions( ${LIB_PREFIX}${uname} PRIVATE BUILDING_DLL )
endfunction()


function ( ug_lib_unit2
    uname 
    cxxpath
    build_type
    include_dirs 
    lnk_lib 
    dep_units 
)
    add_library( ${LIB_PREFIX}${uname} ${build_type} ${cxxpath} )
    ug_custom_type_unit( "${LIB_PREFIX}${uname}" "${include_dirs}" "${lnk_lib}" "${dep_units}" )
    target_compile_definitions( ${LIB_PREFIX}${uname} PRIVATE BUILDING_DLL )
endfunction()

