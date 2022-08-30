# Generated by CMake

if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.6)
   message(FATAL_ERROR "CMake >= 2.6.0 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.6...3.20)
#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

if(CMAKE_VERSION VERSION_LESS 3.0.0)
  message(FATAL_ERROR "This file relies on consumers using CMake 3.0.0 or greater.")
endif()

# Protect against multiple inclusion, which would fail when already imported targets are added once more.
set(_targetsDefined)
set(_targetsNotDefined)
set(_expectedTargets)
foreach(_expectedTarget msdfgen::msdfgen-core msdfgen::msdfgen-ext msdfgen::msdfgen-all)
  list(APPEND _expectedTargets ${_expectedTarget})
  if(NOT TARGET ${_expectedTarget})
    list(APPEND _targetsNotDefined ${_expectedTarget})
  endif()
  if(TARGET ${_expectedTarget})
    list(APPEND _targetsDefined ${_expectedTarget})
  endif()
endforeach()
if("${_targetsDefined}" STREQUAL "${_expectedTargets}")
  unset(_targetsDefined)
  unset(_targetsNotDefined)
  unset(_expectedTargets)
  set(CMAKE_IMPORT_FILE_VERSION)
  cmake_policy(POP)
  return()
endif()
if(NOT "${_targetsDefined}" STREQUAL "")
  message(FATAL_ERROR "Some (but not all) targets in this export set were already defined.\nTargets Defined: ${_targetsDefined}\nTargets not yet defined: ${_targetsNotDefined}\n")
endif()
unset(_targetsDefined)
unset(_targetsNotDefined)
unset(_expectedTargets)


# Create imported target msdfgen::msdfgen-core
add_library(msdfgen::msdfgen-core STATIC IMPORTED)

set_target_properties(msdfgen::msdfgen-core PROPERTIES
  INTERFACE_COMPILE_DEFINITIONS "MSDFGEN_USE_CPP11"
  INTERFACE_COMPILE_FEATURES "cxx_std_11"
  INTERFACE_INCLUDE_DIRECTORIES "/Users/taher/github/sdf-font/lib/msdfgen/"
)

# Create imported target msdfgen::msdfgen-ext
add_library(msdfgen::msdfgen-ext STATIC IMPORTED)

set_target_properties(msdfgen::msdfgen-ext PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "/Users/taher/github/sdf-font/lib/msdfgen"
  INTERFACE_LINK_LIBRARIES "msdfgen::msdfgen-core;Freetype::Freetype"
)

# Create imported target msdfgen::msdfgen-all
add_library(msdfgen::msdfgen-all INTERFACE IMPORTED)

set_target_properties(msdfgen::msdfgen-all PROPERTIES
  INTERFACE_LINK_LIBRARIES "msdfgen::msdfgen-core;msdfgen::msdfgen-ext"
)

# Import target "msdfgen::msdfgen-core" for configuration "Release"
set_property(TARGET msdfgen::msdfgen-core APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(msdfgen::msdfgen-core PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "/Users/taher/github/sdf-font/lib/msdfgen/libmsdfgen-core.a"
  )

# Import target "msdfgen::msdfgen-ext" for configuration "Release"
set_property(TARGET msdfgen::msdfgen-ext APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(msdfgen::msdfgen-ext PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "/Users/taher/github/sdf-font/lib/msdfgen/libmsdfgen-ext.a"
  )

# This file does not depend on other imported targets which have
# been exported from the same project but in a separate export set.

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)
