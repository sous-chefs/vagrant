# Testing

## Style and Unit Testing
This cookbook comes with a Rakefile with the following testing targets:

```
rake foodcritic            # Lint Chef cookbooks
rake rubocop               # Run RuboCop
rake rubocop:auto_correct  # Auto-correct RuboCop offenses
rake spec                  # Run RSpec code examples
rake style                 # Run Rubocop and Foodcritic style checks
rake test                  # Run style checks and unit tests
```

## Integration (test-kitchen)
A .kitchen.yml file is also provided.

```
kitchen list

Instance            Driver   Provisioner  Verifier  Transport  Last Action
debian-ubuntu-1404  Vagrant  ChefZero     Busser    Ssh        <Not Created>
rhel-centos-71      Vagrant  ChefZero     Busser    Ssh        <Not Created>
osx-macosx-1010     Vagrant  ChefZero     Busser    Ssh        <Not Created>
```

```
kitchen test
```

## Mac Integration Tests
To run test-kitchen on a Mac guest, you will need to provide a Mac vagrant box.
To test on your development Mac.  Make sure you have cookbook_path specified and 
disable the password plugin in /etc/chef/client.rb.

````
cookbook_path            ["/Users/xmjg/dev/chef/cookbooks"]
ohai.disabled_plugins = [
  :Passwd
]
````
Then run chef-client -z -o vagrant -c /etc/chef/client.rb
