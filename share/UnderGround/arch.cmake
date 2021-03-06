macro ( config_bit_by_void_p )
    math(EXPR BITS "8*${CMAKE_SIZEOF_VOID_P}")
endmacro()
macro ( config_arch )
    if( NOT DEFINED SYS_MARCH )
        if ( UNIX ) 
            EXECUTE_PROCESS( COMMAND uname -m COMMAND tr -d '\n' OUTPUT_VARIABLE SYS_MARCH )
            message( STATUS "Architecture: ${SYS_MARCH}" )
        elseif ( WIN32 )
            config_bit_by_void_p()
            set ( SYS_MARCH ${BITS} )
        endif()
    endif()
endmacro()
