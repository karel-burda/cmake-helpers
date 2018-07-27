# Groups given files automatically according to their path in the file-system
# Usage: _source_group_by_folder("${ALL_FILES}")
macro(_source_group_by_folder _FILES_TO_GROUP)
    set(SOURCE_GROUP_DELIMITER "/")
    set(last_dir "")
    set(files "")
    foreach(file ${_FILES_TO_GROUP})
        if(NOT IS_ABSOLUTE ${file})
            get_filename_component(file "${file}" ABSOLUTE)
        endif()

        file(RELATIVE_PATH relative_file "${PROJECT_SOURCE_DIR}/${target}" ${file})
        get_filename_component(dir "${relative_file}" PATH)

        if (NOT "${dir}" STREQUAL "${last_dir}")
            if (files)
                source_group("${last_dir}" FILES ${files})
            endif()

            set(files "")
        endif()

        set(files ${files} ${file})
        set(last_dir "${dir}")
    endforeach()

    if (files)
        source_group("${last_dir}" FILES ${files})
    endif()
endmacro()
