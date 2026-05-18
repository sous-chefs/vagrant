# Migration

## From Recipes And Attributes To Resources

This release removes the legacy root `recipes/` and `attributes/` APIs. Use custom resources directly in wrapper cookbooks and test cookbooks.

### Default Recipe

Replace `include_recipe 'vagrant::default'` and `node['vagrant']` attributes with the `vagrant` resource:

```ruby
vagrant 'Vagrant' do
  version '2.4.9'
end
```

### Plugin Attributes

Replace `node['vagrant']['plugins']`, `node['vagrant']['user']`, and `node['vagrant']['password']` with `vagrant` properties:

```ruby
vagrant 'Vagrant' do
  plugin_user 'root'
  plugins [
    'vagrant-ohai',
    { name: 'vagrant-berkshelf', version: '1.2.0' },
  ]
end
```

You can also manage plugins one at a time:

```ruby
vagrant_plugin 'vagrant-omnibus' do
  vagrant_home '/root/.vagrant.d'
end
```

### AppImage Installs

Replace `node['vagrant']['appimage']` and `node['vagrant']['appimage_file']` with resource properties:

```ruby
vagrant 'Vagrant' do
  appimage true
  appimage_file '/usr/local/bin/vagrant'
end
```

### Legacy RubyGem Removal

Replace `include_recipe 'vagrant::uninstall_gem'` with:

```ruby
vagrant_gem 'vagrant'
```
