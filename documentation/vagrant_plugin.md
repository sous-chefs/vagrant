# vagrant_plugin

Installs and removes Vagrant plugins.

## Actions

* `:install` - Installs the plugin.
* `:remove` - Removes the plugin.
* `:uninstall` - Removes the plugin.

## Properties

* `plugin_name` - String, name property. Vagrant plugin name.
* `version` - String, default `nil`. Plugin version to install.
* `env` - Hash or nil, default `nil`. Environment variables for the Vagrant CLI.
* `user` - String, default `nil`. User used to run plugin commands.
* `password` - String, default `nil`. Password used for Windows user impersonation.
* `sources` - String or Array, default `nil`. Alternate plugin source repositories.
* `vagrant_home` - String, default `nil`. VAGRANT_HOME path for plugin commands.

## Examples

```ruby
vagrant_plugin 'vagrant-omnibus'

vagrant_plugin 'vagrant-berkshelf' do
  version '1.2.0'
  sources ['https://plugins.example.test']
end
```
