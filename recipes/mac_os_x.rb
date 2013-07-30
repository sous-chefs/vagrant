dmg_package "Vagrant" do
  source node['vagrant']['url']['osx']
  checksum node['vagrant']['checksum']
  type "pkg"
  package_id "com.vagrant.vagrant"
  action :install
end
