windows_package "Vagrant #{node['vagrant']['msi_version']}" do
  source node['vagrant']['url']['windows']
  checksum node['vagrant']['checksum']
  action :install
end

env "PATH" do
	not_if{
		ENV['PATH'] =~ /HashiCorp/ 	
	}
	value "#{ENV['PATH']};c:/HashiCorp/Vagrant/bin"
end