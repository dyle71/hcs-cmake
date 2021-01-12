# deb-package.cmake

Instructs CMake to include `package` target which builds a Debian package `.deb`. Ideally the building machine and the 
target system are identical, i.e. using an Ubuntu 20.04 LTS to build a package for Ubuntu 20.04. Cross-systems
build are possible though.


## Synopsis

In your `CMakeLists.txt` state
```
set(PACKAGE_DEB_CONTROL_DIR "path-to-control-files")
include(deb-package.cmake)
include(CPack)
```

## Options

Apply all usual package variables introduced by CPack.

* `CPACK_PACKAGE_NAME`: Name of the package.
* `CPACK_PACKAGE_VERSION_MAJOR`: Version major number of the package to build.
* `CPACK_PACKAGE_VERSION_MINOR`: Version minor number of the package to build.
* `CPACK_PACKAGE_VERSION_PATCH`: Version patch level number of the package to build.
* `CPACK_PACKAGE_DESCRIPTION`: A short description for the package.
* `CPACK_PACKAGE_DESCRIPTION_SUMMARY`: A long description.
* `CPACK_PACKAGE_CONTACT`: Whom to contact in case of questions or errors.
* `CPACK_PACKAGE_VENDOR`: Organisation producing the package.
* `CPACK_PACKAGE_FILE_NAME`: File name (prefix part) of the poackage.
* `CPACK_SYSTEM_NAME`: This will hold the target operating system name.

Especially noted:
* `CPACK_DEBIAN_PACKAGE_DEPENDS`: you should fix the dependencies with by setting the `CPACK_DEBIAN_PACKAGE_DEPENDS`.
* `PACKAGE_DEB_CONTROL_DIR`: Path to folder containing the DEB control files.

The control files are:
* `conffiles`:  The configuration files of this package, line by line.
* `preinst`: pre-installation script.
* `postinst`: post-installation script.
* `prerm`: pre-removal script.
* `postrm`: post-removal script.


The folder `deb-package` contains template files. Please copy these to somewhere to your project root folder and
modify them accordingly.


## Example

Having 
```bash
$ tree package/deb/
package/deb/
├── conffiles
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

set(CPACK_SYSTEM_NAME "super-OS_123")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "good-tool (>= 1.2)")
set(PACKAGE_DEB_CONTROL_DIR "package/deb")

include(cmake/deb-package.cmake)
include(CPack)
```


---

Oliver Maurhart, <oliver.maurhart@headcode.space>  
Copyright (C) 2020-2021 headcode.space
[https://headcode.space](https://www.headcode.space)
