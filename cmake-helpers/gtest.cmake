# Place this macro after the "add_executable" or "add_library" call
macro(_gtest_bootstrap_and_link _target _tag)
    set(_source_dir_name "gtest-src")
    set(_source_dir "${CMAKE_BINARY_DIR}/${_source_dir_name}")

    add_custom_target("gtest" SOURCES "")

    if(NOT EXISTS "${_source_dir}")
        find_package(git REQUIRED)

        # cannot do shallow clone because of later force checkout
        execute_process(COMMAND "${GIT_EXECUTABLE} clone -b ${_tag} --depth 1 --single-branch --progress -- https://github.com/google/googletest.git ${_source_dir}"
                        TIMEOUT 300)
    endif()

    execute_process(                       COMMAND ${CMAKE_COMMAND} -DBUILD_GMOCK:BOOL=OFF -DBUILD_GTEST:BOOL=ON -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} .
                       WORKING_DIRECTORY ${_source_dir})
    execute_process(                       COMMAND ${CMAKE_COMMAND} --build . --config ${_GTEST_BUILD_VARIANT}
                       WORKING_DIRECTORY ${_source_dir})

    #set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

    set(GTEST_ROOT ${_source_dir})
    find_package(GTest REQUIRED)
endmacro()
