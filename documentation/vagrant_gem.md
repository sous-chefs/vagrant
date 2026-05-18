# vagrant_gem

Removes legacy RubyGem-based Vagrant installs.

## Actions

* `:remove` - Removes the named gem with `gem_package` and `chef_gem`.

## Properties

* `gem_name` - String, name property. Gem to remove.

## Examples

```ruby
vagrant_gem 'vagrant'
```
