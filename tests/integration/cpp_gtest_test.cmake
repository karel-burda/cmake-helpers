include(${CMAKE_CURRENT_SOURCE_DIR}/../../cmake-helpers/cpp_gtest.cmake)

burda_cmake_helpers_cpp_gtest_bootstrap_and_link(${PROJECT_NAME} "release-1.8.1" ${CMAKE_BUILD_TYPE})
