# Vagrant Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/vagrant.svg)](https://supermarket.chef.io/cookbooks/vagrant)
[![Build Status](https://img.shields.io/circleci/project/github/sous-chefs/vagrant/master.svg)](https://circleci.com/gh/sous-chefs/vagrant)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Installs [Vagrant](https://www.vagrantup.com/) and manages Vagrant plugins via custom resources.

This cookbook is not intended to install Vagrant 1.0 RubyGem versions. Use the `vagrant_gem` resource if you need to remove an old gem install.

This cookbook is not supported for installing versions of Vagrant older than 1.6.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

This cookbook should not be used on platforms that Vagrant itself does not support.

## Vagrant Supported Platforms

Vagrant publishes packages for:

- Mac OS X
- Windows
- Linux (deb-package based platforms, e.g., Debian and Ubuntu)
- Linux (rpm-package based platforms, e.g., RHEL-compatible distributions, Fedora, and Amazon Linux)

Other platforms are not supported. This cookbook attempts to exit gracefully in places where unsupported platforms may cause an issue, but it is __strongly recommended__ that this cookbook not be used on an unsupported platform's node run list or used as a dependency for cookbooks used on unsupported platforms.

## Tested with Test Kitchen

- AlmaLinux 8+
- Amazon Linux 2023+
- CentOS Stream 9+
- Debian 12+
- Fedora latest
- Oracle Linux 8+
- Rocky Linux 8+
- Ubuntu 22.04+

## Tested manually

- OS X 10.9

May work on other Debian/RHEL family distributions with or without modification.

This cookbook has [test-kitchen](http://kitchen.ci) support for Windows and Mac OS X, but requires custom Vagrant boxes.

Because Vagrant is installed as a native system package, Chef must run as a privileged user (e.g., root or Administrator).

Use of the AppImage version of Vagrant assumes you have set up support for FUSE filesystems. See [FUSE](https://github.com/libfuse/libfuse)
for general explanation of FUSE. The vagrant installation resource does not install or set up FUSE.

## Migration

This cookbook now exposes custom resources only. Legacy root recipes and attributes were removed.
See [migration.md](migration.md) for examples that map the old recipe and attribute API to resource properties.

## Resources

This cookbook includes the:

- `vagrant` resource, for installing vagrant.
- `vagrant_plugin` resource, for managing vagrant plugins.
- `vagrant_gem` resource, for removing legacy RubyGem installs.

See the resource documentation:

- [vagrant](documentation/vagrant.md)
- [vagrant_plugin](documentation/vagrant_plugin.md)
- [vagrant_gem](documentation/vagrant_gem.md)

### vagrant

#### Actions

- `:install`: installs vagrant. Platform specific details are here.

#### Properties

- `:checksum`: Vagrant package checksum (SHA256)
- `:url`: Download Vagrant package from this URL
- `:version`: Vagrant package version
- `:appimage`: Install the appimage version of vagrant flag
- `:appimage_file`: Install the appimage vagrant file at this location, defaults to /usr/local/bin/vagrant
- `:plugins`: Install Vagrant plugins after Vagrant is installed
- `:plugin_user`: User used for plugins installed through the `plugins` property
- `:plugin_password`: Password used for plugins installed through the `plugins` property

#### Examples

```ruby
vagrant 'Vagrant'

vagrant 'Vagrant from url' do
  checksum 'abc123'
  url 'https://releases.hashicorp.com/vagrant/2.4.9/vagrant_2.4.9-1_amd64.deb'
  version '2.4.9'
end

vagrant 'Vagrant with plugins' do
  plugin_user 'root'
  plugins [
    'vagrant-ohai',
    { name: 'vagrant-berkshelf', version: '1.2.0' },
  ]
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
  user 'vagrant'
  password 'vagrant'
end

# Install a plugin in the /root directory
vagrant_plugin 'vagrant-aws' do
  vagrant_home '/root/.vagrant.d'
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

### vagrant_gem

#### Actions

- `:remove`: removes the named gem with `gem_package` and `chef_gem`. Default.

#### Properties

- `:gem_name`: name attribute, the RubyGem to remove.

#### Examples

```ruby
vagrant_gem 'vagrant'
```

### Notes about specific plugins

- vagrant-libvirt. Installing this plugin has required setting environment variables on ubuntu system. Adding env CONFIGURE_ARGS: 'with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib' to the vagrant_plugin resource properties has worked.

### Usage

Use the resources directly from a wrapper cookbook. To install Vagrant and plugins:

```ruby
vagrant 'Vagrant' do
  plugins [
    'vagrant-omnibus',
    { name: 'vagrant-berkshelf', version: '1.2.0' },
  ]
end
```

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
