cmake_minimum_required(VERSION 3.5)
include_directories(src/include)

project(AniScript LANGUAGES C)

add_executable(AniScript src/lex.l src/errormsg.c src/util.c src/driver.c src/include/errormsg.h src/include/tokens.h src/include/util.h)

install(TARGETS AniScript
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
