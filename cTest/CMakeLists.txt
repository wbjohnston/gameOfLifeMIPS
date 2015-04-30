find_package(ncurses)


set(CMAKE_CXX_FLAGS "-Wextra -Wall -pedantic")
add_executable(gol gol.c)

