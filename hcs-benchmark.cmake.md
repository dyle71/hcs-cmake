# hcs-benchmark.cmake

Helper to pull in the headcode.space benchmark utilities.


## Synopsis

Install the headcode.space benchmark utilities on the system and add the path to the includes.

* `HCS_BENCHMARK_SOURCE_DIR`: path to the headcode.space benchmark sources.
* `HCS_BENCHMARK_INCLUDE_DIR`: location of the headcode.space benchmark include files.

If you lack the above, add the headcode.space to your project and do a
```bash
$ mkdir 3rd
$ git submodule init
$ git submodule add https://gitlab.com/headcode.space/benchmark.git 3rd/hcs-benchmark
```
in your project root. Finally point the `HCS_BENCHMARK_SOURCE_DIR` to this path in your `CMakeLists.txt`.


## Options


Define all of these: `HCS_BENCHMARK_SOURCE_DIR` *or* download the headcode.space benchmark into a subfolder as 
depicted above.


## Example

Download headcode.space benchmakr as submodule like this:

```bash
$ mkdir 3rd
$ git submodule init
$ git submodule add https://gitlab.com/headcode.space/benchmark.git 3rd/hcs-benchmark
```

```
include(hcs-benchmark)
include_directories(${HCS_BENCHMARK_INCLUDE_DIR})
```


---

Copyright (C) 2020-2021 headcode.space e.U.  
Oliver Maurhart <info@headcode.space>  
[https://headcode.space](https://www.headcode.space)  
