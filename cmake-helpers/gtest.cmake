macro(_gtest_bootstrap_and_link _target _tag _build_type)
    set(_source_dir_name "gtest-src")
    set(_source_dir_base_path "${CMAKE_BINARY_DIR}")
    set(_source_dir_path "${_source_dir_base_path}/${_source_dir_name}")

    #add_custom_target(googletest SOURCES "")

    if(NOT EXISTS "${_source_dir_path}")
        find_package(git REQUIRED)

        execute_process(COMMAND ${GIT_EXECUTABLE} clone -b ${_tag} --depth 1 --single-branch -- https://github.com/google/googletest.git ${_source_dir_name}
                        WORKING_DIRECTORY ${_source_dir_base_path}
                        TIMEOUT 300)
    endif()

    execute_process(COMMAND ${CMAKE_COMMAND} -DBUILD_GMOCK:BOOL=OFF -DCMAKE_BUILD_TYPE=${_build_type} .
                    WORKING_DIRECTORY "${_source_dir_path}")
    execute_process(COMMAND ${CMAKE_COMMAND} --build . --config ${_build_type}
                    WORKING_DIRECTORY "${_source_dir_path}")

    set(GTEST_ROOT "${_source_dir_path}/googletest")
    if (MSVC)
        file(GLOB _gtest_binaries "${_source_dir_path}/googletest/${_build_type}/*.lib")
    endif()

    find_package(GTest REQUIRED)
    
    target_link_libraries(${_target} GTest::GTest GTest::Main)
endmacro()
