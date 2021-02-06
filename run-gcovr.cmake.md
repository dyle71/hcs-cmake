# run-gcovr.cmake

Helper to pull in code coverage based on gcovr.


## Synopsis

Include this `cmake` and enable the `PROFILING_MODE_ENABLED` option.

This will then instrument your code and collect runtime information with gcovr. 
After nuilding the code base and invoking all tests, you can run this code 
coverage selection by 

```bash
$ make run-gcovr
```

in your build folder.

This will prepare:
* gcovr-coverage.info
* gcovr-report.xml
* gcovr-sonarqube-report.xml (to be uploaded to a SonarQube server)
* coverage-html (folder to locally browse coverage information)


## Example

```bash
$ cd build
$ cmake -D PROFILING_MODE_ENABLED=on ..
$ make 
$ make test
$ make run-gcovr
```


---

Copyright (C) 2021 headcode.space e.U.  
Oliver Maurhart <info@headcode.space>  
[https://headcode.space](https://www.headcode.space)  
