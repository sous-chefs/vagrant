# Vagrant Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/vagrant.svg)](https://supermarket.chef.io/cookbooks/vagrant)
[![Build Status](https://img.shields.io/circleci/project/github/sous-chefs/vagrant/master.svg)](https://circleci.com/gh/sous-chefs/vagrant)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Installs [Vagrant](https://www.vagrantup.com/) 1.6+ and manages Vagrant plugins via a `vagrant_plugin` resource.

This cookbook is not intended to be used for vagrant "1.0" (gem install) versions. A recipe is provided for removing the gem, see __Recipes__.

This cookbook is not supported for installing versions of Vagrant older than 1.6.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

This cookbook should not be used on platforms that Vagrant itself does not support.

## Vagrant Supported Platforms

Vagrant does not specifically list supported platforms on the project web site. However, the only platforms with [packages provided](https://www.vagrantup.com/downloads.html) are:

- Mac OS X
- Windows
- Linux (deb-package based platforms, e.g., Debian and Ubuntu)
- Linux (rpm-packaged based platforms, e.g., RHEL and CentOS)

Other platforms are not supported. This cookbook attempts to exit gracefully in places where unsupported platforms may cause an issue, but it is __strongly recommended__ that this cookbook not be used on an unsupported platform's node run list or used as a dependency for cookbooks used on unsupported platforms.

## Tested with Test Kitchen

- Ubuntu 18.04
- CentOS 7.3
- Windows 2016

## Tested manually

- OS X 10.9

May work on other Debian/RHEL family distributions with or without modification.

This cookbook has [test-kitchen](http://kitchen.ci) support for Windows and Mac OS X, but requires custom Vagrant boxes.

Because Vagrant is installed as a native system package, Chef must run as a privileged user (e.g., root or Administrator).

Use of the AppImage version of Vagrant assumes you have set up support for FUSE filesystems. See [FUSE](https://github.com/libfuse/libfuse)
for general explanation of FUSE. The vagrant installation resource does not install or set up FUSE.

## Attributes

### 'default' recipe. Install the Vagrant Package

The attributes defined for this cookbook are organized under the
`node['vagrant']` namespace.

Attribute | Description | Type   | Default
----------|-------------|--------|--------
['version'] | Vagrant package version | String | '2.0.3'
['url'] | Download Vagrant package from this URL | String | Calculated by `vagrant_package_uri` helper method.
['checksum'] | Vagrant package checksum (SHA256) | String | Calculated by `vagrant_sha256sum` helper method.
['appimage'] | Use the appimage version | Binary | nil
['appimage_file'] | Install location | String | nil

### 'install_plugins' recipe

Attributes in the table below are under the `node['vagrant']` namespace.

Attribute | Description | Type   | Default
----------|-------------|--------|--------
['plugins'] | An array of plugins, e.g. `%w(vagrant-aws vagrant-ohai vagrant-omnibus)` | Array | nil
['plugins'] | If you want to install specific plugin versions, use the second form of the `['plugins']` array, e.g. [ {name: 'vagrant-ohai', version: '0.1.3'}, {name: 'vagrant-aws', version: '0.6.0'} ] | Array of Hashes | nil

- `node['vagrant']['plugins']` - A array of plugins. The elements in
  the array can be a string or a hash. String elements should be the
  names of plugins to install. Hash elements should have the name key
  for the plugin name.  The options version and env keys may be used
  to specify the version and any needed environment settings for the
  plugin.  This form is used by the `vagrant_plugin` resource in the
  `install_plugins` recipe.
- `node['vagrant']['user']` - A user that is used to automatically install plugins as for the `node['vagrant']['plugins']` attribute.
- `node['vagrant']['password']` - The password for the user. Used for installing as another user on windows systems.

## Resources

This cookbook includes the:

- `vagrant` resource, for installing vagrant.
- `vagrant_plugin` resource, for managing vagrant plugins.

### vagrant

#### Actions

- `:install`: installs vagrant. Platform specific details are here.

#### Properties

- `:checksum`: Vagrant package checksum (SHA256)
- `:url`: Download Vagrant package from this URL
- `:version`: Vagrant package version
- `:appimage`: Install the appimage version of vagrant flag
- `:appimage_file`: Install the appimage vagrant file at this location, defaults to /usr/local/bin/vagrant

#### Examples

```ruby
vagrant 'Vagrant' do
  version node['vagrant']['version']
end

vagrant 'Vagrant from url' do
  checksum node['vagrant']['checksum']
  url node['vagrant']['url']
  version node['vagrant']['checksum']
end
```

### vagrant_plugin

#### Actions

- `:install`: installs the specified plugin. Default.
- `:uninstall`: uninstalls the specified plugin
- `:remove`: uninstalls the specified plugin

#### Properties

- `:plugin_name`: name attribute, the name of the plugin, e.g.
  "vagrant-omnibus".
- `:version`: version of the plugin to installed, must be specified as a string, e.g., "1.0.2"
- `:env`: plugin environment variable settings, some plugins require specific settings
- `:user`: a user to run plugin installation as. Usually this is for single user systems (like workstations).
- `:sources`: alternate locations to search for plugins. This would commonly
  be used if you are hosting your vagrant plugins in a custom gem repo

#### Examples

```ruby
vagrant_plugin 'vagrant-omnibus'

vagrant_plugin 'vagrant-berkshelf' do
  version '1.2.0'
  sources ['http://src1.example.com', 'http://src2.example.com']
end
```

```ruby
# Install the plugins as the `donuts` user, into ~/donuts/.vagrant.d
# .vagrant.d will be allocated if it does not exist.
# If a specific user, group or mode is desired use a directory resource to
# create the .vagrant.d directory.
vagrant_plugin 'vagrant-aws' do
  user 'donuts'
end
```

#### Install the 'vagrant-winrm' plugin for another user. Windows impersonation

requires a username and password.

```ruby
vagrant_plugin 'vagrant-winrm' do
  user node['vagrant']['user']
  password node['vagrant']['password']
end

# Install a plugin in the /root directory
vagrant_plugin 'vagrant-aws' do
  vagrant_home: '/root/.vagrant.d'
end
```

#### ChefSpec Matchers

Matchers are automatically generated by current versions of ChefSpec.

Example:

```ruby
RSpec.describe 'example::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'installs the vagrant-omnibus plugin' do
    expect(chef_run).to install_vagrant_plugin('vagrant-omnibus').with(
      user: 'my_user'
    )
  end
end
```

## Recipes

### default

The default recipe uses the vagrant resource to install Vagrant. OS specific code is in the install custom resource. If the `node['vagrant']['plugins']` attribute is not empty, it includes the install_plugins recipe to install any required vagrant plugins.

### install_plugins

Iterates over the `node['vagrant']['plugins']` attribute and installs the listed plugins. If that attribute is a hash, it installs the specified plugin version. If the `node['vagrant']['user']` attribute is set, the plugins are installed for only that user.

### uninstall_gem

This recipe will attempt to uninstall the `vagrant` gem with the
`gem_package` and `chef_gem` resources. Meaning, it will use the `gem`
binary in the `PATH` of the shell executing Chef to uninstall, and
then use Chef's built-in RubyGems to uninstall. If you have a
customized Ruby environment, such as with rbenv or rvm (or other), you
may need to manually remove and clean up anything leftover, such as
running `rbenv rehash`. Likewise, if you have multiple copies of the
vagrant gem installed, you'll need to clean up all versions. This
recipe won't support such craziness :-).

### Notes about specific plugins

- vagrant-libvirt. Installing this plugin has required setting environment variables on ubuntu system. Adding env CONFIGURE_ARGS: 'with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib' to the vagrant_plugin resource properties has worked.

### Usage

Set the url and checksum attributes on the node. Do this in a role, or
a "wrapper" cookbook. Or, just set the version and let the magic happen.

Then include the default recipe on the node's run list.

To specify plugins for installation in the default recipe, specify an
array for the `node['vagrant']['plugins']` attribute. For example, to
install the `vagrant-omnibus` plugin (any version) and version "1.2.0"
of the `vagrant-berkshelf` plugin:

```ruby
node.set['vagrant']['plugins'] = [
  'vagrant-omnibus',
  {name: 'vagrant-berkshelf', version: '1.2.0'}
]
```

See the attribute tables above.

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
