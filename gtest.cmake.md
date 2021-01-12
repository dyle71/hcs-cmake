# gtest.cmake

Helper to either rely on an installed or git submodule Google Test across different nested git submodules.


## Synopsis

Install Google Test on your operating system and let these CMake variables point to the locations:

* `GTEST_INCLUDE_DIR`: location of the Google Test include files.
* `GTEST_INCLUDE_DIR`: path to `libgtest.a`.
* `GTEST_INCLUDE_DIR`: path to `libgtest_main.a`.
* `GMOCK_LIBRARY`: path to `libgmock.a`.
* `GMOCK_MAIN_LIBRARY`: path to `libgmock_main.a`.

If you lack any of the above, add Google Test to your project and do a 
```bash
$ mkdir 3rd
$ git submodule init
$ git submodule add https://github.com/google/googletest 3rd/googletest
```
in your project root. Finally point the `GTEST_SOURCE_DIR` to this path in your `CMakeLists.txt`.


## Options


Define all of these: `GTEST_INCLUDE_DIR`, `GTEST_INCLUDE_DIR`, `GTEST_INCLUDE_DIR`, `GMOCK_LIBRARY` and 
`GMOCK_MAIN_LIBRARY` *or* download the Google Test into a subfolder as depicted above.


## Example

Download Google Test as submodule like this:

```bash
$ mkdir 3rd
$ git submodule init
$ git submodule add https://github.com/google/googletest 3rd/googletest
```

```
ENABLE_TESTING()

set(GTEST_SOURCE_DIR "${CMAKE_SOURCE_DIR}/3rd/googletest")
include(cmake/gtest.cmake)
```


---

Copyright (C) 2020-2021 headcode.space e.U.  
Oliver Maurhart <info@headcode.space>  
[https://headcode.space](https://www.headcode.space)  
