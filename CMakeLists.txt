cmake_minimum_required(VERSION 3.14) # b/c of FetchContent_MakeAvailable
project(CMakePPCore VERSION 1.0.0 LANGUAGES NONE)

option(BUILD_TESTING "Should we build and run the unit tests?" OFF)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" CACHE STRING "" FORCE)

if("${BUILD_TESTING}")
    include(CTest)
    add_subdirectory(tests)
endif()
