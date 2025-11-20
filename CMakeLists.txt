cmake_minimum_required(VERSION 4.1)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include(vcpkg)

set(VERSION "0.0.1")
set(PROJECT_NAME "Battleship")

project(${PROJECT_NAME} VERSION ${VERSION} LANGUAGES CXX)

include(Warnings)
include(Sanitizers)
include(Coverage)
include(BuildType)
include(CheckLTO)
set_default_buildtype()
enable_warnings()
enable_sanitizers()
enable_coverage()

set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_CXX_STANDARD 23 CACHE STRING "The C++ standard version to target")
set(CMAKE_CXX_STANDARD_REQUIRED true)

add_subdirectory(lib)
add_subdirectory(src)

include(CTest)
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
