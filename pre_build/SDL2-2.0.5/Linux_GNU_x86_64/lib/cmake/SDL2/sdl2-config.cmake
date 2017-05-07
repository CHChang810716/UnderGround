# sdl2 cmake project-config input for ./configure scripts

set(prefix "${SDL2_ROOT}") 
set(exec_prefix "${prefix}")
set(libdir "${exec_prefix}/lib")
set(SDL2_PREFIX "${SDL2_ROOT}")
set(SDL2_EXEC_PREFIX "${SDL2_ROOT}")
set(SDL2_LIBDIR "${exec_prefix}/lib")
set(SDL2_INCLUDE_DIRS "${prefix}/include")
set(SDL2_LIBRARIES ${SDL2_LIBDIR}/libSDL2main.a ${SDL2_LIBDIR}/libSDL2.so )
string(STRIP "${SDL2_LIBRARIES}" SDL2_LIBRARIES)
set(SDL2_FOUND ON)
