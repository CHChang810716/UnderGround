function ( ug_exe_unit 
    uname 
    include_dirs 
    lnk_lib 
    dep_units 
)
    add_executable( ${uname} src/${PROJECT_NAME}/application/${uname}/main.cpp )
    ug_custom_type_unit( 
        "${uname}" 
        "${include_dirs}" 
        "${lnk_lib}" 
        "${dep_units}" 
    )
endfunction()

function ( ug_exe_unit2 
    uname 
    cxxpath
    include_dirs 
    lnk_lib 
    dep_units 
)
    add_executable( ${uname} ${cxxpath} )
    ug_custom_type_unit( 
        "${uname}" 
        "${include_dirs}" 
        "${lnk_lib}" 
        "${dep_units}" 
    )
endfunction()

