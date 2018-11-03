include("${CMAKE_SOURCE_DIR}/cmake-helpers/warnings.cmake")

_warnings_add_pedantic_level(${PROJECT_NAME})
_warnings_supress(${PROJECT_NAME} "keyword-macro")
