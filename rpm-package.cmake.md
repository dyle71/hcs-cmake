# rpm-package.cmake

Instructs CMake to include `package` target which builds a Debian package `.rpm`. Ideally the building machine and the 
target system are identical, i.e. using an Fedora 32 to build a package for Fedora 32. Cross-systems build are possible 
though.


## Synopsis

In your `CMakeLists.txt` state
```
set(PACKAGE_RPM_CONTROL_DIR "path-to-control-files")
include(rpm-package.cmake)
include(CPack)
```

## Options

Apply all usuall package variables introduced by CPack.

* `CPACK_PACKAGE_NAME`: Name of the package.
* `CPACK_PACKAGE_VERSION_MAJOR`: Version major number of the package to build.
* `CPACK_PACKAGE_VERSION_MINOR`: Version minor number of the package to build.
* `CPACK_PACKAGE_VERSION_PATCH`: Version patch level number of the package to build.
* `CPACK_PACKAGE_DESCRIPTION`: A short description for the package.
* `CPACK_PACKAGE_DESCRIPTION_SUMMARY`: A long description.
* `CPACK_PACKAGE_CONTACT`: Whom to contact in case of questions or errors.
* `CPACK_PACKAGE_VENDOR`: Organisation producing the package.
* `CPACK_PACKAGE_FILE_NAME`: File name (prefix part) of the poackage.

Especially noted:
* `CPACK_RPM_PACKAGE_REQUIRES`: you should fix the dependencies with by setting the `CPACK_RPM_PACKAGE_REQUIRES`.
* `PACKAGE_RPM_CONTROL_DIR`: Path to folder containing the RPM control scripts.

The control files are:
* `preinst`: pre-installation script.
* `postinst`: post-installation script.
* `prerm`: pre-removal script.
* `postrm`: post-removal script.


The folder `rpm-package` contains template files. Please copy these to somewhere to your project root folder and
modify them accordingly.


## Example

Having 
```bash
$ tree package/rpm/
package/rpm/
├── postinst
├── postrm
├── preinst
└── prerm
```

```
set(CPACK_PACKAGE_NAME "super-tool")
set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "2")
set(CPACK_PACKAGE_VERSION_PATCH "3")

set(CPACK_PACKAGE_DESCRIPTION "This is a super tool!")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "This super tool software does everything you need.")
set(CPACK_PACKAGE_CONTACT "John Doe <john.doe@supertool.software>")
set(CPACK_PACKAGE_VENDOR "SuperTool Software Inc.")
set(CPACK_PACKAGE_FILE_NAME "super-tool-${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}-${CMAKE_SYSTEM_PROCESSOR}")

set(CPACK_RPM_PACKAGE_REQUIRES "good-tool (>= 1.2)"
set(PACKAGE_RPM_CONTROL_DIR "package/rpm")

include(cmake/rpm-package.cmake)
include(CPack)
```


---

Oliver Maurhart, <oliver.maurhart@headcode.space>  
(C)opyright 2020 headcode.space  
[https://headcode.space](https://www.headcode.space)
