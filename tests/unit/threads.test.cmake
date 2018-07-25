include("threads.cmake")

#set(PROJECT_NAME threads-test)
project(threads-test LANGUAGES CXX)

_link_threads_if_available()

# TODO: Inspect according to platform
