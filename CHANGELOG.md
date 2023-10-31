# Changelog

All notable changes to this project will be documented in this file.

This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## 4.0.15 - *2023-10-31*

## 4.0.14 - *2023-09-29*

## 4.0.13 - *2023-09-11*

## 4.0.12 - *2023-07-10*

## 4.0.11 - *2023-05-17*

## 4.0.10 - *2023-04-17*

## 4.0.9 - *2023-04-07*

Standardise files with files in sous-chefs/repo-management

## 4.0.8 - *2023-04-01*

## 4.0.7 - *2023-04-01*

## 4.0.6 - *2023-04-01*

Standardise files with files in sous-chefs/repo-management

## 4.0.5 - *2023-03-20*

Standardise files with files in sous-chefs/repo-management

## 4.0.4 - *2023-03-15*

Standardise files with files in sous-chefs/repo-management

## 4.0.3 - *2023-02-24*

## 4.0.2 - *2023-02-23*

Standardise files with files in sous-chefs/repo-management

## 4.0.1 - *2023-02-14*

Standardise files with files in sous-chefs/repo-management

## 4.0.0 - *2022-12-23*

- Update default version to install to 2.3.4
- Logic fixes for installing >= 2.3.0
- CI and Cookstyle fixes
- Update tested platforms
- Standardize helper library and clean it up
- Cleanup and modernize unit tests
- Fix up generic installation

## 3.0.2 - *2022-12-13*

- Standardise files with files in sous-chefs/repo-management

## 3.0.1 - *2022-02-17*

- Standardise files with files in sous-chefs/repo-management

## 3.0.0 - *2021-11-01*

- Enabled `unified_mode` for all resources.
- Dropped compatibility with Chef versions < 15.3.
- Updated Vagrant default version to 2.2.18 (previously was 2.2.4).

## 2.0.6 - *2021-08-30*

- Standardise files with files in sous-chefs/repo-management

## 2.0.5 - *2021-06-01*

- Standardise files with files in sous-chefs/repo-management

## 2.0.4 - *2020-12-31*

- resolved cookstyle error: metadata.rb:31:1 convention: `Layout/TrailingEmptyLines`

## 2.0.3 2020-07-14

- Install plugins in the root user home directory for inspec testing.  The plugin location varies depending on environment variables unless explicitly set.
- Test using ubuntu 20.04
- Use build_essential to install vagrant-libvirt

## 2.0.2 2020-06-02

- resolved cookstyle error: test/fixtures/cookbooks/wintest/resources/authorize_service.rb:11:1 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`

## [2.0.1] 2020-02-01

- Updated tests to work with root user (as is the case on docker machines)
- Style Fixes
- Simplify platform checks
- Migrated to Github Actions for testing

## [2.0.0] 2019-10-11

- Breaking change. Fail if Vagrant install is attempted on an unsupported OS.
- Add. Allow the install of the appimage version of Vagrant.
- Remove. Rubocop.yml doesn'tt need to protect the dangerfile any more.
- Change. Use the latest cookstyle rules

## 1.0.0

- Convert the resources to custom resources
- Add an env property to the plugin resource to allow for setting environment variables.
- Add an example of installing the vagrant-libvirt plugin, this plugin requires specific environment variable settings. See [vagrant-libvirt/issues/891](https://github.com/vagrant-libvirt/vagrant-libvirt/issues/891)
- Add mac test instructions.
- Update the testing documentation

## 0.9.1

- Update the README to describe the new vagrant resource

## 0.9.0

- Create a custom resource to install vagrant.  Fix issue #69

## 0.8.1

- Change the source respository name
- Add the authorize_service resource for setting up windows testing
- Use environment variable VAGRANT_HOME as the location to install plugins

## 0.8.0

- Add tests for chef-client 14
- Drop testing for chef-client 12
- Fix the calculation of the plugin directory location
- Fixes for Windows 2012R2:
   - The Vagrant installer needs to reboot windows, but the MSI does this in a way that chef can't handle. As an alternative, we make chef interrupt itself and reboot the instance.
   - Related to the above, the MSI returns two specific exit codes when it finishes (but not 0...) that chef needs to know about.
   - Testing windows requires user 'vagrant' to hold the 'Replace a process level token' and 'Adjust Memory Quotas for a process' permissions. At the moment those setting must be made using the secpol.msc interface. A furtur task is to configure the vagrant user via the test cookbook.
   - Vagrant version 1.9.7 suffers from the issue described in #82 (Expected process to exit with [0], but received '-1073741515'). For unknown reasons, this problem is resolved by using 2.0.3 (Perhaps also earlier versions, but they were not tested.)

## 0.7.2

- The package extension for the vagrant mac package changed.
  After version 1.9.2 the extension is _x86_64.dmg.
- The package extension for the vagrant windows package changed.
  After version 1.9.5 the extension is machinetype.msi.
- Added support for amazon linux
- Make the inspec tests run. Move them to the correct directories.

## 0.7.1

- Fixes for Chef 13 compat
- Install Vagrant 1.9.7 by default

## 0.7.0

- Fix #67: Remove depends constraint on Windows 1.x cookbook.

## 0.6.0

- Install Vagrant 1.8.5 by default

## 0.5.0

- Install Vagrant 1.8.1 by default
- Switch to [InSpec verifier](https://github.com/chef/inspec) for test-kitchen

## 0.4.2 - January 7, 2016

- Fix regression in `fetch_platform_checksums_for_version` method. Release 0.4.1 changed the checksums URL to the new Hashicorp location and introduced a regression. The `fetch_platform_checksums_for_version` method now returns the correct URL.

Thanks to Jeff Bachtel for the PR.

## 0.4.1 - January 6, 2016

- Hashicorp has moved Vagrant package downloads from bintray.com to hashicorp.com. Download Vagrant packages from new location.

## 0.4.0 - December 21, 2015

- Bump default Vagrant version to 1.7.4
- Cookbook no longer fails during compile phase if <https://dl.bintray.com> is unavailable. You can override `node['vagrant']['url']` and `node['vagrant']['checksum']` if you need to download Vagrant from a different location.
- Fix idempotency when installing Vagrant Windows package.
- Refactor Vagrant::Helpers and add test coverage
- `vagrant_plugin` resource correctly installs vagrant plugins as another user on Windows.
- Refactor LWRP and add unit tests.

### Dev environment changes

- Add ChefSpec [Custom Matchers](https://github.com/sethvargo/chefspec#packaging-custom-matchers)
  for `vagrant_plugin`.
- Add Rakefile for testing/style checks.
- Add Travis-CI integration for style and unit tests
- Move vagrant_sha256sum mock to spec/support/shared_context.rb
- Refactor ChefSpec tests - move platform recipe specs into their own spec files

## 0.3.1

- #25, #31 Don't evaluate attributes on unsupported platforms

## 0.3.0

- #11 Custom plugin sources
- #14 Implement user-specific plugin installation
- #20, #21, Fix plugin version detection
- #28 Improve cross platform support

## 0.2.2

- Fix platform_family, `redhat` is not a family, `rhel` is. (#18)

## 0.2.0

- Add `uninstall_gem` recipe to remove vagrant (1.0) gem.

## 0.1.1

- Initial release of vagrant
