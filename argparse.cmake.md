# argparse.cmake

Helper to pull in the argparse utility. This is a light-weighted (header only) argument parse (which, frankly, 
does everything one needs). 


## Synopsis

Install the argparse utility on the system and add the path to the includes.

* `ARGPARSE_SOURCE_DIR`: path to the argparse sources (anywhere you might have downloaded 
  https://github.com/p-ranav/argparse.git).
* `ARGPARSE_INCLUDE_DIR`: location of the argparse include files.

If you lack the above, then do a
```bash
$ mkdir 3rd
$ git submodule init
$ git submodule add https://github.com/p-ranav/argparse.git 3rd/argparse
```
in your project root. Finally point the `ARGPARSE_SOURCE_DIR` to this path in your `CMakeLists.txt`.


## Options


Define all of these: `ARGPARSE_SOURCE_DIR` *or* download the argparse into a subfolder as depicted above.


## Example

Download Google Test as submodule like this:

```bash
$ mkdir 3rd
$ git submodule init
$ git submodule add https://github.com/p-ranav/argparse.git 3rd/argparse
```

```
include(argparse)
include_directories(${ARGPARSE_INCLUDE_DIR})
```


---

Oliver Maurhart, <oliver.maurhart@headcode.space>  
(C)opyright 2020 headcode.space  
[https://headcode.space](https://www.headcode.space)
