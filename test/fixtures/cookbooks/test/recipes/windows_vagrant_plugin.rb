# test installing a plugin as a specified user

directory 'C:/Users/vagrant/.vagrant.d' do
  owner 'vagrant'
end

vagrant_plugin 'vagrant-winrm' do
  user 'vagrant'
  password 'vagrant'
end

vagrant_plugin 'vagrant-omnibus' do
  user 'vagrant'
  password 'vagrant'
end
