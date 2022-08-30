# Install script for directory: /Users/taher/github/sdf-font/lib/msdfgen

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/Users/taher/github/sdf-font/lib/msdfgen/libmsdfgen-core.a")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmsdfgen-core.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmsdfgen-core.a")
    execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmsdfgen-core.a")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/msdfgen/core" TYPE FILE FILES
    "/Users/taher/github/sdf-font/lib/msdfgen/core/Bitmap.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/Bitmap.hpp"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/BitmapRef.hpp"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/Contour.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/EdgeColor.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/EdgeHolder.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/MSDFErrorCorrection.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/Projection.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/Scanline.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/Shape.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/ShapeDistanceFinder.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/ShapeDistanceFinder.hpp"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/SignedDistance.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/Vector2.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/arithmetics.hpp"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/bitmap-interpolation.hpp"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/contour-combiners.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/edge-coloring.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/edge-segments.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/edge-selectors.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/equation-solver.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/generator-config.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/msdf-error-correction.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/pixel-conversion.hpp"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/rasterization.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/render-sdf.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/save-bmp.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/save-tiff.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/sdf-error-estimation.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/core/shape-description.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/msdfgen" TYPE FILE FILES "/Users/taher/github/sdf-font/lib/msdfgen/msdfgen.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/Users/taher/github/sdf-font/lib/msdfgen/libmsdfgen-ext.a")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmsdfgen-ext.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmsdfgen-ext.a")
    execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmsdfgen-ext.a")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/msdfgen/ext" TYPE FILE FILES
    "/Users/taher/github/sdf-font/lib/msdfgen/ext/import-font.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/ext/import-svg.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/ext/resolve-shape-geometry.h"
    "/Users/taher/github/sdf-font/lib/msdfgen/ext/save-png.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/msdfgen" TYPE FILE FILES "/Users/taher/github/sdf-font/lib/msdfgen/msdfgen-ext.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/msdfgen/msdfgenTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/msdfgen/msdfgenTargets.cmake"
         "/Users/taher/github/sdf-font/lib/msdfgen/CMakeFiles/Export/lib/cmake/msdfgen/msdfgenTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/msdfgen/msdfgenTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/msdfgen/msdfgenTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/msdfgen" TYPE FILE FILES "/Users/taher/github/sdf-font/lib/msdfgen/CMakeFiles/Export/lib/cmake/msdfgen/msdfgenTargets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/msdfgen" TYPE FILE FILES "/Users/taher/github/sdf-font/lib/msdfgen/CMakeFiles/Export/lib/cmake/msdfgen/msdfgenTargets-release.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/taher/github/sdf-font/lib/msdfgen/msdfgen")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/msdfgen" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/msdfgen")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" -u -r "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/msdfgen")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/msdfgen/msdfgenBinaryTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/msdfgen/msdfgenBinaryTargets.cmake"
         "/Users/taher/github/sdf-font/lib/msdfgen/CMakeFiles/Export/lib/cmake/msdfgen/msdfgenBinaryTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/msdfgen/msdfgenBinaryTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/msdfgen/msdfgenBinaryTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/msdfgen" TYPE FILE FILES "/Users/taher/github/sdf-font/lib/msdfgen/CMakeFiles/Export/lib/cmake/msdfgen/msdfgenBinaryTargets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/msdfgen" TYPE FILE FILES "/Users/taher/github/sdf-font/lib/msdfgen/CMakeFiles/Export/lib/cmake/msdfgen/msdfgenBinaryTargets-release.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/msdfgen" TYPE FILE FILES
    "/Users/taher/github/sdf-font/lib/msdfgen/lib/cmake/msdfgen/msdfgenConfig.cmake"
    "/Users/taher/github/sdf-font/lib/msdfgen/msdfgenConfigVersion.cmake"
    )
endif()

