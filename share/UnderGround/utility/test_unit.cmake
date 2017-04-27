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

