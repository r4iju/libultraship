if(SOH_APPLE_TARGET STREQUAL "tvos")
    if(CMAKE_OSX_SYSROOT MATCHES "simulator")
        set(PLATFORM "SIMULATORARM64_TVOS")
    else()
        set(PLATFORM "TVOS")
    endif()
elseif(NOT DEFINED PLATFORM OR PLATFORM STREQUAL "")
    set(PLATFORM "OS64COMBINED")
endif()
include(FetchContent)
FetchContent_Declare(iostoolchain
    GIT_REPOSITORY https://github.com/leetal/ios-cmake
    GIT_TAG 06465b27698424cf4a04a5ca4904d50a3c966c45
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
)
FetchContent_GetProperties(iostoolchain)
if(NOT iostoolchain_POPULATED)
    FetchContent_Populate(iostoolchain)
endif()
set(CMAKE_IOS_TOOLCHAIN_FILE ${iostoolchain_SOURCE_DIR}/ios.toolchain.cmake)
set_property(GLOBAL PROPERTY IOS_TOOLCHAIN_FILE ${CMAKE_IOS_TOOLCHAIN_FILE})
# The toolchain caches its SDK separately. Let it resolve the requested platform
# again when reconfiguring an existing simulator or device build directory.
unset(CMAKE_OSX_SYSROOT_INT CACHE)
unset(CMAKE_OSX_SYSROOT_INT)
unset(ENV{_CMAKE_OSX_SYSROOT_INT})
include(${CMAKE_IOS_TOOLCHAIN_FILE})
