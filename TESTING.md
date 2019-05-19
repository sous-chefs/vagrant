# Testing

## Style and Unit Testing

This cookbook follows the guidelines for cookstyle. Run cookstyle -a to find and auto correct style problems.
Run foodcritic to check Chef cookbook guidelines.
Run rspec to test the library modules.

## Integration (test-kitchen)

A .kitchen.yml file is provided. Run kitchen test on the instances to verify correct behaviour. Test kitchen
tests are set up for centos, ubuntu and windows images.

## Mac Integration Tests

To run test-kitchen on a Mac guest, you will need to provide a Mac vagrant box.
To test on your development Mac.  Make sure you have cookbook_path specified and
disable the password plugin in /etc/chef/client.rb.

````ruby
cookbook_path            ["/Users/xmjg/dev/chef/cookbooks"]
ohai.disabled_plugins = [
  :Passwd
]
````

Then run "chef-client -z -o vagrant -c /etc/chef/client.rb -j test/fixtures/mac/mactest.json"
To verify the install run "inspec exec test/integration/mac/inspec/vagrant_spec.rb"
