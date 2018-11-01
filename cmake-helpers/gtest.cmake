macro(_gtest_bootstrap_and_link _target _tag)
    set(_source_dir_name "gtest-src")
    set(_source_dir_path "${CMAKE_BINARY_DIR}")

    add_custom_target(gtest SOURCES "")

    if(NOT EXISTS "${_source_dir}")
        find_package(git REQUIRED)

        execute_process(COMMAND "${GIT_EXECUTABLE} clone -b ${_tag} --depth 1 --single-branch -- https://github.com/google/googletest.git ${_source_dir_name}"
                        WORKING_DIRECTORY ${_source_dir_path}
                        TIMEOUT 300)
    endif()

    execute_process(COMMAND ${CMAKE_COMMAND} -DBUILD_GMOCK:BOOL=OFF -DBUILD_GTEST:BOOL=ON -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} .
                    WORKING_DIRECTORY "${_source_dir}/${_source_dir_name}")
    execute_process(COMMAND ${CMAKE_COMMAND} --build . --config ${_GTEST_BUILD_VARIANT}
                    WORKING_DIRECTORY "${_source_dir}/${_source_dir_name}")

    #set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

    #set(GTEST_ROOT ${_source_dir})
    find_package(GTest REQUIRED)

    add_dependencies(${_target} gtest)
endmacro()
