if(CMAKE_EXTRA_GENERATOR)
    set(gen "${CMAKE_EXTRA_GENERATOR} - ${CMAKE_GENERATOR}")
else()
    set(gen "${CMAKE_GENERATOR}" )
endif()
