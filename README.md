vagrant Cookbook
================

Installs vagrant and manages vagrant plugins w/ a custom resource.

* Vagrant: http://www.vagrantup.com/

Requirements
------------

Tested on Chef 11:

* Debian 6
* CentOS 6.3

May work on other Debian/RHEL family distributions with or without
modification.

Support exists for Windows and OS X but this has not yet been tested.

The URL and Checksum attributes must be set, see __Attributes__

Attributes
----------

The following attributes *must* be set.

* `node['vagrant']['url']` - URL to the Vagrant installation package.
* `node['vagrant']['checksum']` - SHA256 checksum of the Vagrant
  installation package.

If the node is Windows, the MSI version must be set. This is used by
the `windows_package` resource to determine if the package is
installed.

* `node['vagrant']['msi_version']` - Version string of the installed
  MSI "package" on Windows.

The following attribute is optional.

* `node['vagrant']['plugins']` - An array of plugins. The elements in
  the array can be a string or a hash. String elements should be the
  names of plugins to install. Hash elements should have two keys,
  "name" and "version", for the plugin name and its version to
  install. This is used by the `vagrant_plugin` resource in the
  default recipe.

Resources
---------

This cookbook includes the `vagrant_plugin` resource, for managing
vagrant plugins.

## vagrant_plugin

### Actions

- `:install`: installs the specified plugin. Default.
- `:uninstall`: uninstalls the specified plugin
- `:remove`: uninstalls the specified plugin

### Attribute Parameters

- `:plugin_name`: name attribute, the name of the plugin, e.g.
  "vagrant-omnibus".
- `:version`: version of the plugin to installed, must be specified as
  a string, e.g., "1.0.2"

### Examples

    vagrant_plugin "vagrant-omnibus"

    vagrant_plugin "vagrant-berkshelf"
      version "1.2.0"
    end

Usage
-----

Set the url and checksum attributes on the node. Do this in a role, or
a "wrapper" cookbook.

Then include the default recipe on the node's run list.

To specify plugins for installation in the default recipe, specify an
array for the `node['vagrant']['plugins']` attribute. For example, to
install the `vagrant-omnibus` plugin (any version) and version "1.2.0"
of the `vagrant-berkshelf` plugin:

    node.set['vagrant']['plugins'] = [
      "vagrant-omnibus",
      {"name" => "vagrant-berkshelf", "version" => "1.2.0"}
    ]

See the attribute description above.

License and Authors
-------------------

* Author:: Joshua Timberman <opensource@housepub.org>
* Copyright (c) 2013, Joshua Timberman

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
