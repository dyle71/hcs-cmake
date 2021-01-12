# hcs-mem.cmake

Helper to pull in the headcode.space mem utilities.


## Synopsis

Install the headcode.space mem utilities on the system and add the path to the includes.

* `HCS_MEM_SOURCE_DIR`: path to the headcode.space mem sources.
* `HCS_MEM_INCLUDE_DIR`: location of the headcode.space mem include files.

If you lack the above, add the headcode.space to your project and do a
```bash
$ mkdir 3rd
$ git submodule init
$ git submodule add https://gitlab.com/headcode.space/memtool.git 3rd/hcs-mem
```
in your project root. Finally point the `HCS_MEM_SOURCE_DIR` to this path in your `CMakeLists.txt`.


## Options

Define all of these: `HCS_MEM_SOURCE_DIR` *or* download the headcode.space mem into a subfolder as 
depicted above.


## Example

Download Google Test as submodule like this:

```bash
$ mkdir 3rd
$ git submodule init
$ git submodule add https://gitlab.com/headcode.space/memtool.git 3rd/hcs-mem
```

```
include(hcs-mem)
include_directories(${HCS_MEM_INCLUDE_DIR})
```


---

Oliver Maurhart, <oliver.maurhart@headcode.space>  
Copyright (C) 2020-2021 headcode.space
[https://headcode.space](https://www.headcode.space)
