# gitlab-package-push.cmake

Generates a make target to push the built binary package (see `deb-package.cmake` or `rpm-package.cmake`) to the GitLab 
container repository.

Hence, this is meant to be run by a GitLab CI/CD runner. As such it relies on having a CI_JOB_TOKEN set when run. 
Please pass on this job token to the cmake invocation, e.g. `cmake -DCI_JOB_TOKEN=$CI_JOB_TOKEN ..`


## Synopsis

In your `CMakeLists.txt` state
```
set(PROJECT_ID "12345678")
set(PACKAGE_GROUP "super-tool")

set(GITLAB_PACKAGE_BASE_URL "https://gitlab.com/api/v4/projects/${PROJECT_ID}/packages/generic/${PACKAGE_GROUP}")
set(PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}.rpm")
set(PACKAGE_FILE "${CMAKE_BINARY_DIR}/${PACKAGE_FILE_NAME}")
include(gitlab-package-push)
```

The `PROJECT_ID` is the numerical project id listened on the GitLab server, `PACKAGE_GROUP` is the group name to
collect the packages within the project.


## Options

* `GITLAB_PACKAGE_BASE_URL`: Full GitLab API 4 url to the project.
* `PACKAGE_FILE_NAME`: The name of the local built package file without parent folder.
* `PACKAGE_FILE`: Full path to the local built package file.


## Example

```
...
include(rpm-package)
include(CPack)

set(PROJECT_ID "12345678")
set(PACKAGE_GROUP "super-tool")

set(GITLAB_PACKAGE_BASE_URL "https://gitlab.com/api/v4/projects/${PROJECT_ID}/packages/generic/${PACKAGE_GROUP}")
set(PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}.deb")
set(PACKAGE_FILE "${CMAKE_BINARY_DIR}/${PACKAGE_FILE_NAME}")
include(gitlab-package-push)
```


---

Oliver Maurhart, <oliver.maurhart@headcode.space>  
(C)opyright 2020-2021 headcode.space  
[https://headcode.space](https://www.headcode.space)
