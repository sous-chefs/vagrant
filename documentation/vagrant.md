# vagrant

Installs or removes Vagrant and can install a list of Vagrant plugins after the package is installed.

## Actions

* `:install` - Installs Vagrant.
* `:uninstall` - Removes Vagrant.

## Properties

* `checksum` - String or nil, default `nil`. SHA256 checksum for the downloaded package.
* `url` - String or nil, default `nil`. Package URL. When unset, the cookbook builds the HashiCorp release URL.
* `version` - String, default `'2.4.9'`. Vagrant version to install.
* `appimage` - true or false, default `false`. Install the generic Linux zip/AppImage artifact.
* `appimage_file` - String, default `'/usr/local/bin/vagrant'`. AppImage install path.
* `plugins` - Array, default `[]`. Plugins to install after Vagrant is installed. Strings and hashes are supported.
* `plugin_user` - String or nil, default `nil`. User used for plugins from the `plugins` list.
* `plugin_password` - String or nil, default `nil`. Password used for plugins from the `plugins` list.

## Examples

### Package Install

```ruby
vagrant 'Vagrant'
```

### Install Plugins

```ruby
vagrant 'Vagrant' do
  plugin_user 'root'
  plugins [
    'vagrant-ohai',
    { name: 'vagrant-berkshelf', version: '1.2.0' },
  ]
end
```

### AppImage Install

```ruby
vagrant 'Vagrant' do
  appimage true
  appimage_file '/usr/local/bin/vagrant'
end
```
