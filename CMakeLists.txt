cmake_minimum_required(VERSION 3.22)

project(font-renderer-metal)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17 -fno-objc-arc")

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_subdirectory(lib/msdfgen)
add_subdirectory(lib/metal-cmake)

# Assets
file(COPY resources DESTINATION ${CMAKE_BINARY_DIR})

# Executable
add_executable(font-renderer-metal "main.cpp")
target_link_libraries(font-renderer-metal msdfgen::msdfgen-core msdfgen::msdfgen-ext METAL_CPP)
