macro(_gtest_bootstrap_and_link _target _branch_or_tag _build_type)
    message(STATUS "Running '_gtest_bootstrap_and_link' with these params: target='${_target}', branch/tag='${_branch_or_tag}', type='${_build_type}'")

    set(_source_dir_name "gtest-src")
    set(_source_dir_base_path "${CMAKE_BINARY_DIR}")
    set(_source_dir_path "${_source_dir_base_path}/${_source_dir_name}")

    if(NOT EXISTS "${_source_dir_path}")
        find_package(git REQUIRED)

        execute_process(COMMAND ${GIT_EXECUTABLE} clone -b ${_branch_or_tag} --depth 1 --single-branch --progress -- https://github.com/google/googletest.git ${_source_dir_name}
                        WORKING_DIRECTORY ${_source_dir_base_path}
                        TIMEOUT 300)
    endif()

    execute_process(COMMAND ${CMAKE_COMMAND} -DBUILD_GMOCK:BOOL=OFF -DCMAKE_BUILD_TYPE=${_build_type} -Dgtest_force_shared_crt:BOOL=ON .
                    WORKING_DIRECTORY "${_source_dir_path}")
    execute_process(COMMAND ${CMAKE_COMMAND} --build . --config ${_build_type}
                    WORKING_DIRECTORY "${_source_dir_path}")

    set(GTEST_ROOT "${_source_dir_path}/googletest")
    if (MSVC)
        file(GLOB _gtest_binaries "${_source_dir_path}/googletest/${_build_type}/*.lib")
        file(COPY ${_gtest_binaries} DESTINATION ${GTEST_ROOT})
    endif()

    find_package(GTest REQUIRED)
    target_link_libraries(${_target} GTest::GTest GTest::Main)
endmacro()
