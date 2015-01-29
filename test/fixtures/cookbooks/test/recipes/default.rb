# How meta...
vagrant_plugin 'vagrant-aws' do
  user 'vagrant'
end

# A user that doesn't exist...
user 'donuts' do
  shell '/bin/bash'
  home '/home/donuts'
  supports :manage_home => true
end

# And a version of vagrant-aws not used previously in this run, just
# to be sure.
vagrant_plugin 'vagrant-aws' do
  version '0.4.1'
  user 'donuts'
end
