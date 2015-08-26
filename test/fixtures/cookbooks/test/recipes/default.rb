execute 'apt-get update' if platform_family?('debian')

include_recipe 'build-essential'
include_recipe 'vagrant'

# How meta...
vagrant_plugin 'vagrant-aws' do
  user 'vagrant'
end

# A user that doesn't exist...
donut_home = case node['os']
             when 'darwin' then '/Users/donuts'
             when 'linux' then '/home/donuts'
               # untested, this is run in test kitchen, but i don't have a
               # current windows box
             when 'windows' then 'C:/Users/donuts'
             end

user 'donuts' do
  uid '777'
  gid 'staff' if ['darwin'].include?(node['os'])
  shell '/bin/bash'
  home donut_home
  supports manage_home: true
end

directory donut_home do
  owner 'donuts'
  group 'staff' if ['darwin'].include?(node['os'])
  recursive true
end

# Use a different plugin for the donuts user. This doesn't work on OS
# X though, getting a permission problem on installing ffi.
vagrant_plugin 'vagrant-ohai' do
  version '0.1.12'
  user 'donuts'
end
