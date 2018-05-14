# Vagrant Cookbook Changelog

## 0.9.1
* Update the README to describe the new vagrant resource

## 0.9.0
* Create a custom resource to install vagrant.  Fix issue #69

## 0.8.1
* Change the source respository name
* Add the authorize_service resource for setting up windows testing
* Use environment variable VAGRANT_HOME as the location to install plugins

## 0.8.0
* Add tests for chef-client 14
* Drop testing for chef-client 12
* Fix the calculation of the plugin directory location
* Fixes for Windows 2012R2:
  * The Vagrant installer needs to reboot windows, but the MSI does this in a way that chef can't handle. As an alternative, we make chef interrupt itself and reboot the instance.
  * Related to the above, the MSI returns two specific exit codes when it finishes (but not 0...) that chef needs to know about.
  * Testing windows requires user 'vagrant' to hold the 'Replace a process level token' and 'Adjust Memory Quotas for a process' permissions. At the moment those setting must be made using the secpol.msc interface. A furtur task is to configure the vagrant user via the test cookbook.
  * Vagrant version 1.9.7 suffers from the issue described in #82 (Expected process to exit with [0], but received '-1073741515'). For unknown reasons, this problem is resolved by using 2.0.3 (Perhaps also earlier versions, but they were not tested.)

## 0.7.2

* The package extension for the vagrant mac package changed. 
  After version 1.9.2 the extension is _x86_64.dmg.
* The package extension for the vagrant windows package changed. 
  After version 1.9.5 the extension is <machinetype>.msi.
* Added support for amazon linux
* Make the inspec tests run. Move them to the correct directories.

## 0.7.1

* Fixes for Chef 13 compat
* Install Vagrant 1.9.7 by default

## 0.7.0

* Fix #67: Remove depends constraint on Windows 1.x cookbook.

## 0.6.0

* Install Vagrant 1.8.5 by default

## 0.5.0

* Install Vagrant 1.8.1 by default
* Switch to [InSpec verifier](https://github.com/chef/inspec) for test-kitchen

## 0.4.2 - January 7, 2016

* Fix regression in `fetch_platform_checksums_for_version` method. Release 0.4.1
changed the checksums URL to the new Hashicorp location and introduced a regression.
The `fetch_platform_checksums_for_version` method now returns the correct URL.

Thanks to Jeff Bachtel for the PR.

## 0.4.1 - January 6, 2016

* Hashicorp has moved Vagrant package downloads from bintray.com to hashicorp.com. Download Vagrant packages from new location.

## 0.4.0 - December 21, 2015

* Bump default Vagrant version to 1.7.4
* Cookbook no longer fails during compile phase if <https://dl.bintray.com> is
unavailable. You can override `node['vagrant']['url']` and
`node['vagrant']['checksum']` if you need to download Vagrant from a different
location.
* Fix idempotency when installing Vagrant Windows package.
* Refactor Vagrant::Helpers and add test coverage
* `vagrant_plugin` resource correctly installs vagrant plugins as another user on Windows.
* Refactor LWRP and add unit tests.

#### Dev environment changes
* Add ChefSpec [Custom Matchers](https://github.com/sethvargo/chefspec#packaging-custom-matchers)
  for `vagrant_plugin`.
* Add Rakefile for testing/style checks.
* Add Travis-CI integration for style and unit tests
* Move vagrant_sha256sum mock to spec/support/shared_context.rb
* Refactor ChefSpec tests - move platform recipe specs into their own spec files

## 0.3.1:

* #25, #31 Don't evaluate attributes on unsupported platforms

## 0.3.0:

* #11 Custom plugin sources
* #14 Implement user-specific plugin installation
* #20, #21, Fix plugin version detection
* #28 Improve cross platform support

## 0.2.2:

* Fix platform_family, `redhat` is not a family, `rhel` is. (#18)

## 0.2.0:

* Add `uninstall_gem` recipe to remove vagrant (1.0) gem.

## 0.1.1:

* Initial release of vagrant
