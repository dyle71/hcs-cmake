# gitlab-package-push.cmake

Generates a make target to push the built binary package (see `deb-package.cmake` or `rpm-package.cmake`) to the GitLab 
container repository.

Hence, this is meant to be run by a GitLab CI/CD runner. As such it relies on having a CI_JOB_TOKEN set when run.


## Synopsis

In your `CMakeLists.txt` state
```
set(GITLAB_PROJECT_ID "1234567890")
set(GITLAB_PACKAGE_GROUP_NAME "super-project")
set(GITLAB_PACKAGE_URL "https://gitlab.com/api/v4/projects/${GITLAB_PROJECT_ID}/packages/generic/${GITLAB_PACKAGE_GROUP_NAME}")
set(PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}.rpm")
set(PACKAGE_FILE "${CMAKE_BINARY_DIR}/${PACKAGE_FILE_NAME}")
include(gitlab-package-push)
```

The `GITLAB_PROJECT_ID` is the numerical project id listened on the GitLab server. 


## Options

* `GITLAB_PROJECT_ID`: The numerical id of the project at the GitLab server.
* `GITLAB_PACKAGE_GROUP_NAME`: The name package of the package group.
* `GITLAB_PACKAGE_URL`: Full GitLab API 4 url to the project.
* `PACKAGE_FILE_NAME`: The name of the local built package file without parent folder.
* `PACKAGE_FILE`: Full path to the local built package file.


## Example

```
...
include(rpm-package)
include(CPack)
set(GITLAB_PACKAGE_URL "https://gitlab.com/api/v4/projects/33778880090/packages/generic/super-tool")
set(PACKAGE_FILE_NAME "${CPACK_PACKAGE_FILE_NAME}.rpm")
set(PACKAGE_FILE "${CMAKE_BINARY_DIR}/${PACKAGE_FILE_NAME}")
include(gitlab-package-push)
```


---

Oliver Maurhart, <oliver.maurhart@headcode.space>  
(C)opyright 2020 headcode.space  
[https://headcode.space](https://www.headcode.space)
