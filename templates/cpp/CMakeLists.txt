cmake_minimum_required(VERSION 3.25)
# Set project name and version
project(main VERSION 0.1)

# set clang-format flags
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
# set cmake debug target
set(CMAKE_BUILD_TYPE Debug)

# Set CPP Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# gathers all source code files
file(GLOB_RECURSE SRCS CONFIGURE_DEPENDS "src/*.cpp")
add_executable(${PROJECT_NAME} ${SRCS})
target_compile_options(
  ${PROJECT_NAME}
  PRIVATE $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wall
          -Wextra
          -pedantic
          -Wshadow
          -Wuninitialized
          -Wconversion
          -Wsign-conversion
          -Werror>)
target_include_directories(${PROJECT_NAME} PUBLIC "include")

# https://cmake.org/cmake/help/latest/manual/cmake-modules.7.html
# find_package(Curses REQUIRED)
#
# target_include_directories(${PROJECT_NAME} PUBLIC ${CURSES_INCLUDE_DIRS})
#
# target_link_libraries(${PROJECT_NAME} ${CURSES_LIBRARIES})
# ...............................................................

# compiles to executable

install(TARGETS ${PROJECT_NAME} DESTINATION bin)
