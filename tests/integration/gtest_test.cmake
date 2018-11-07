include(${CMAKE_CURRENT_SOURCE_DIR}/../../cmake-helpers/gtest.cmake)

 _gtest_bootstrap_and_link(${PROJECT_NAME} "release-1.8.1" ${CMAKE_BUILD_TYPE})
