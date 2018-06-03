macro(_print_status_message MESSAGE)
    message(STATUS "${PROJECT_NAME}: ${MESSAGE}")
endmacro()

macro(_print_project_version)
    _print_status_message("${PROJECT_NAME} is in version: ${PROJECT_VERSION}")
endmacro()
