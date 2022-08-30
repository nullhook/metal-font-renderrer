#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "msdfgen-standalone::msdfgen" for configuration "RelWithDebInfo"
set_property(TARGET msdfgen-standalone::msdfgen APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(msdfgen-standalone::msdfgen PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/msdfgen"
  )

list(APPEND _IMPORT_CHECK_TARGETS msdfgen-standalone::msdfgen )
list(APPEND _IMPORT_CHECK_FILES_FOR_msdfgen-standalone::msdfgen "${_IMPORT_PREFIX}/bin/msdfgen" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
