# Bootstraps google test (gtest), links it correctly to desired target including compilation options
macro(burda_cmake_helpers_cpp_gtest_bootstrap_and_link _target _branch_or_tag _build_type)
    if (NOT MSVC AND ${_build_type} STREQUAL "Debug")
        message(STATUS "Compiling and linking gtest in the Debug mode is currenly only supported on MSVC, using Release")

        set(_build_type_resolved Release)
    else()
        set(_build_type_resolved ${_build_type})
    endif()

    message(STATUS "Running 'burda_cmake_helpers_cpp_gtest_bootstrap_and_link' with these params:
                    target='${_target}', branch/tag='${_branch_or_tag}', type='${_build_type_resolved}'")

    set(_source_dir_name gtest-src)
    set(_source_dir_base_path ${CMAKE_BINARY_DIR})
    set(_source_dir_path ${_source_dir_base_path}/${_source_dir_name})
    set(_cmake_generate_args -DBUILD_GMOCK:BOOL=OFF -DCMAKE_BUILD_TYPE=${_build_type_resolved})
    if (MSVC)
        list(APPEND _cmake_generate_args -Dgtest_force_shared_crt:BOOL=ON)
    endif()
    set(_cmake_build_args --build . --config ${_build_type_resolved})

    if(NOT EXISTS ${_source_dir_path})
        find_package(Git REQUIRED)

        execute_process(COMMAND ${GIT_EXECUTABLE} clone -b ${_branch_or_tag} --depth 1 --single-branch --progress --
                                                  https://github.com/google/googletest.git ${_source_dir_name}
                        WORKING_DIRECTORY ${_source_dir_base_path}
                        TIMEOUT 300)
    endif()

    message(STATUS "Will run cmake generate with these args: '${_cmake_generate_args}'")
    execute_process(COMMAND ${CMAKE_COMMAND} ${_cmake_generate_args} .
                    WORKING_DIRECTORY "${_source_dir_path}")

    message(STATUS "Will run cmake build with these args: '${_cmake_build_args}'")
    execute_process(COMMAND ${CMAKE_COMMAND} ${_cmake_build_args}
                    WORKING_DIRECTORY "${_source_dir_path}")

    set(GTEST_ROOT ${_source_dir_path}/googletest)

    if (MSVC)
        file(GLOB _gtest_binaries ${GTEST_ROOT}/${_build_type_resolved}/*.lib)
        file(COPY ${_gtest_binaries} DESTINATION ${GTEST_ROOT})
    endif()

    find_package(GTest REQUIRED)
    target_link_libraries(${_target} GTest::GTest GTest::Main)
endmacro()
