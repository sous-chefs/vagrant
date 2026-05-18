# Limitations

## Package Availability

HashiCorp publishes Vagrant 2.4.9 packages from the official downloads and releases sites.

### APT (Debian/Ubuntu)

* Debian and Ubuntu are supported through HashiCorp's APT repository and binary `.deb` downloads.
* The 2.4.9 release publishes `amd64` and `i686` Debian packages.

### DNF/YUM (RHEL family)

* RHEL/CentOS-compatible, Fedora, and Amazon Linux systems are supported through HashiCorp's RPM repositories and binary `.rpm` downloads.
* The 2.4.9 release publishes `x86_64` and `i686` RPM packages.

### macOS

* The 2.4.9 release publishes `darwin_amd64` and `darwin_arm64` DMG installers.

### Windows

* The 2.4.9 release publishes `windows_amd64` and `windows_i686` MSI installers.

### Generic Linux AppImage

* The 2.4.9 release publishes `linux_amd64.zip` for the AppImage-style install path used by this cookbook.
* The AppImage path requires FUSE support to be configured by the caller.

## Architecture Limitations

* The cookbook's automatic URL helper continues to target the amd64/x86_64 package names for Linux and macOS package installs.
* Windows package selection continues to use `node['kernel']['machine']` to choose amd64 or i686 packages.

## Source/Compiled Installation

This cookbook installs published Vagrant binaries only. It does not build Vagrant from source.

## Platform Lifecycle Notes

* Ubuntu 20.04, Debian 11, CentOS Linux 7, and CentOS Stream 8 are no longer in the active support matrix.
* Current Linux Kitchen coverage is aligned to non-EOL Debian/Ubuntu, RHEL-compatible, Fedora, and Amazon Linux platforms.
* macOS and Windows remain supported through the resource code and dedicated exec Kitchen configuration, but the default local verification gate for this migration uses Linux/Dokken.

## Sources Checked

* HashiCorp Vagrant install page: <https://developer.hashicorp.com/vagrant/install>
* HashiCorp Vagrant 2.4.9 release directory: <https://releases.hashicorp.com/vagrant/2.4.9/>
* endoflife.date Ubuntu, Debian, RHEL, CentOS, CentOS Stream, AlmaLinux, Rocky Linux, Oracle Linux, Amazon Linux, Fedora, macOS, and Windows Server pages.
