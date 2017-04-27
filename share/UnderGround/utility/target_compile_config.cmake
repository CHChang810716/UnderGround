macro( ug_release_compile uname )
    target_compile_definitions( ${uname} PRIVATE  NDEBUG )
    target_compile_options( ${uname} PRIVATE -Ofast -Wno-multichar )
endmacro( ug_release_compile )

