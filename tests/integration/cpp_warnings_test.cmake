include(${CMAKE_CURRENT_SOURCE_DIR}/../../cmake-helpers/cpp_warnings.cmake)

burda_cmake_helpers_cpp_warnings_add_pedantic_level(${PROJECT_NAME} PRIVATE)
burda_cmake_helpers_cpp_warnings_suppress(${PROJECT_NAME} keyword-macro PUBLIC)
