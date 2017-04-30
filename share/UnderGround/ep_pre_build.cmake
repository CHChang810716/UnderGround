include ( ${UNDER_GROUND_CMAKE_DIR}/arch.cmake )
config_arch()
show_var( SYS_MARCH )
macro( INSTALL_PREBUILD  
# if ( NOT EXISTS "${CMAKE_BINARY_DIR}/ENV_PRE_BUILD-done")
#     add_custom_target(ENV_PRE_BUILD
#         COMMAND ${CMAKE_COMMAND} -E copy_directory 
#             ${UNDER_GROUND_ENV_DIR}/${CMAKE_SYSTEM_NAME}_${CMAKE_CXX_COMPILER_ID}_${SYS_MARCH} 
#     	    ${CMAKE_SOURCE_DIR}/bin/install
#     )
#     add_custom_command(TARGET ENV_PRE_BUILD POST_BUILD 
#         COMMAND ${CMAKE_COMMAND} -E touch ${CMAKE_BINARY_DIR}/ENV_PRE_BUILD-done
#     )
# else()
# 	add_custom_target(ENV_PRE_BUILD)
# endif()
