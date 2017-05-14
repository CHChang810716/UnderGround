function ( ug_test_unit2 
    uname 
    cxxpath
    include_dirs 
    lnk_lib 
    dep_units 
)
    add_executable( 
        ${PROJECT_NAME}_${uname}_test 
        ${cxxpath}
    )
    ug_custom_type_unit( 
        "${PROJECT_NAME}_${uname}_test" 
        "${include_dirs}" 
        "${lnk_lib}" 
        "${dep_units}" 
    )
    add_test( 
        ${PROJECT_NAME}_${uname}_test 
        ${EXECUTABLE_OUTPUT_PATH}/${PROJECT_NAME}_${uname}_test 
    )
endfunction()

function ( ug_test_unit 
    uname 
    include_dirs 
    lnk_lib 
    dep_units 
)
    ug_test_unit2(
        "${uname}" 
        "unit_test/${PROJECT_NAME}/${uname}_test.cpp"
        "${include_dirs}" 
        "${lnk_lib}" 
        "${dep_units}"  
    )
endfunction()

macro( path_to_module module_name path_str )
    string( REPLACE "/" "-" ${module_name} ${path_str})
    string( REPLACE ".cpp" "" ${module_name} ${${module_name}})
    set( ${module_name} ${${module_name}}_test )
endmacro()
function ( ug_module_test_unit 
    output_module_name
    uname 
    include_dirs 
    lnk_lib 
    dep_units 
)
    path_to_module( module_name ${uname} )
    message(STATUS "configure test module : ${module_name}")
    add_executable( 
        ${module_name}
        ${CMAKE_SOURCE_DIR}/unit_test/${uname}
    )
    ug_custom_type_unit( 
        "${module_name}"
        "${include_dirs}" 
        "${lnk_lib}" 
        "${dep_units}" 
    )
    add_test( 
        ${module_name}
        ${EXECUTABLE_OUTPUT_PATH}/${module_name} 
    )
    set(${output_module_name} ${module_name} PARENT_SCOPE)
endfunction()

