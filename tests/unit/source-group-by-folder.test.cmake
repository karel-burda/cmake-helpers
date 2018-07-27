include("${BASE_PATH}/source-group-by-folder.cmake")

set(TEST_FILES "a.cpp" "include/b.cpp" "src/src/c.hpp")
_source_group_by_folder(${TEST_FILES})
