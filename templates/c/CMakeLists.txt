cmake_minimum_required(VERSION 3.5)

project(template LANGUAGES C) #CXX

# Set the C/C++ standard required
# set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD 11)

# set clang-format flags
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# set cmake debug target
set(CMAKE_BUILD_TYPE Debug)

# set flags to compiler
# set(CMAKE_CXX_FLAGS ...)
set(CMAKE_C_FLAGS 
	"${CMAKE_C_FLAGS} -Wall -Wextra -Wuninitialized \
	-Wmissing-prototypes")

# Ensure the build and source directory exists
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR})
file(MAKE_DIRECTORY "src")
# grabs all source files
file(GLOB_RECURSE SOURCES "${CMAKE_SOURCE_DIR}/src/*.c") # /*.cpp")

add_executable(main ${SOURCES})

option(TESTING "Enable tests." OFF)

if(TESTING)
  enable_testing()
  add_subdirectory(test)
endif()

install(TARGETS main DESTINATION bin)
