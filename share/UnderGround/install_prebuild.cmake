if(EXISTS ${FILE_TO_CHECK})
    message( STATUS "${PREBUILD_NAME} exist, install step skip" )
else()
    message( STATUS "Pre-build directory : ${PREBUILD_DIR}/${CMAKE_SYSTEM_NAME}_${CMAKE_CXX_COMPILER_ID}_${SYS_MARCH}")
    FILE(GLOB TO_BE_COPY 
        ${PREBUILD_DIR}/${CMAKE_SYSTEM_NAME}_${CMAKE_CXX_COMPILER_ID}_${SYS_MARCH}/*
    )
    FILE(COPY ${TO_BE_COPY} DESTINATION ${DES_DIR})
    FILE(WRITE ${FILE_TO_CHECK} "")
endif()
