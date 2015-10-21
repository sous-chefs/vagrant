# Vagrant Cookbook Changelog

## Unreleased

* Add ChefSpec [Custom Matchers](https://github.com/sethvargo/chefspec#packaging-custom-matchers)
for `vagrant_plugin`.
* Add Rakefile for testing/style checks.
* Fix idempotency when installing Vagrant Windows package.
* Bump default Vagrant version to 1.7.4
* #32 Properly parse existing vagrant plugins in plugins provider.

## 0.3.1:

* #25, #31 Don't evaluate attributes on unsupported platforms

## 0.3.0:

* #11 Custom plugin sources
* #14 Implement user-specific plugin installation
* #20, #21, Fix plugin version detection
* #28 Improve cross platform support

## 0.2.2:

* Fix platform_family, redhat is not a family, rhel is. (#18)

## 0.2.0:

* Add `uninstall_gem` recipe to remove vagrant (1.0) gem.

## 0.1.1:

* Initial release of vagrant
