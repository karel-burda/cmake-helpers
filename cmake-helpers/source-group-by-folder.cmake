# Groups given files automatically according to their path in the file-system
# Usage: source_group_by_folder("${ALL_FILES}")
macro(source_group_by_folder files_to_group)
    set(SOURCE_GROUP_DELIMITER "/")
    set(last_dir "")
    set(files "")
    foreach(file ${files_to_group})
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
