# test installing a plugin as a specified user

directory 'C:/Users/vagrant/.vagrant.d' do
  owner 'vagrant'
end

authorize_service 'Vagrant token auth' do
  service 'SeAssignPrimaryTokenPrivilege'
  user 'vagrant'
end

authorize_service 'Vagrant quota auth' do
  service 'SeIncreaseQuotaPrivilege'
  user 'vagrant'
end

include_recipe 'vagrant'

vagrant_plugin 'vagrant-winrm' do
  user 'vagrant'
  password 'vagrant'
end

vagrant_plugin 'vagrant-omnibus' do
end
