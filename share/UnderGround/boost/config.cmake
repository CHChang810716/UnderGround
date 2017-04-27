show_var( BOOST_ROOT )
find_package( Boost REQUIRED COMPONENTS 
    date_time 
    program_options 
    filesystem 
    system 
    serialization 
    regex 
    thread 
    iostreams 
)
if ( ${Boost_FOUND} )
    add_custom_target( BOOST_CONFIG )
endif()
