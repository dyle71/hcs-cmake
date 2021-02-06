# hcs-logger.cmake

Helper to pull in the headcode.space logger utilities.


## Synopsis

Install the headcode.space logger utilities on the system and add the path to the includes.

* `HCS_LOGGER_SOURCE_DIR`: path to the headcode.space logger sources.
* `HCS_LOGGER_INCLUDE_DIR`: location of the headcode.space logger include files.

If you lack the above, add the headcode.space to your project and do a
```bash
$ mkdir 3rd
$ git submodule init
$ git submodule add https://gitlab.com/headcode.space/logger.git 3rd/hcs-logger
```
in your project root. Finally point the `HCS_LOGGER_SOURCE_DIR` to this path in your `CMakeLists.txt`.

This will also prepare a `HCS_LOGGER_LIB` which holds the path to the `libhcs-logger.a` to link against.


## Options

Define all of these: `HCS_LOGGER_SOURCE_DIR` *or* download the headcode.space logger into a subfolder as 
depicted above.


## Example

Download Google Test as submodule like this:

```bash
$ mkdir 3rd
$ git submodule init
$ git submodule add https://gitlab.com/headcode.space/memtool.git 3rd/hcs-mem
```

```
include(hcs-logger)
include_directories(${HCS_LOGGER_INCLUDE_DIR})
if ("${HCS_LOGGER_LIB}" STREQUAL "")
    message(FATAL_ERROR "Could not build or locate hcs-logger library.")
endif ()
set(CMAKE_REQUIRED_LIBRARIES "${HCS_LOGGER_LIB};${CMAKE_REQUIRED_LIBRARIES}")
```


---

Copyright (C) 2021 headcode.space e.U.  
Oliver Maurhart <info@headcode.space>  
[https://headcode.space](https://www.headcode.space)  
