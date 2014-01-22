default['vagrant']['base_url'] = 'https://dl.bintray.com/mitchellh/vagrant/'
default['vagrant']['version'] = '1.4.3'
default['vagrant']['plugins'] = []
default['vagrant']['msi_version'] = ""

case node['platform_family']
when 'mac_os_x'
  default['vagrant']['url'] = "#{node['vagrant']['base_url']}/Vagrant_#{node['vagrant']['version']}.dmg"
  default['vagrant']['checksum'] = 'e7ff13b01d3766829f3a0c325c1973d15b589fe1a892cf7f857da283a2cbaed1'
when 'windows'
  default['vagrant']['url'] = "#{node['vagrant']['base_url']}/Vagrant_#{node['vagrant']['version']}.msi"
  default['vagrant']['checksum'] = '78a910a5274b127496a9963839dc24860bbabdd870d00c433621801dad690469'
when 'debian'
  default['vagrant']['url'] = "#{node['vagrant']['base_url']}/vagrant_#{node['vagrant']['version']}_#{node['kernel']['machine']}.deb"
  case node['kernel']['machine']
  when 'i686'
    default['vagrant']['checksum'] = '66e613fc1c9e31ecaf8e5f1d07d2ae4fca3d4fc2e43593543962664258d9af9b'
  when 'x86_64'
    default['vagrant']['checksum'] = 'dbd06de0f3560e2d046448d627bca0cbb0ee34b036ef605aa87ed20e6ad2684b'
  end
when 'fedora', 'rhel'
  default['vagrant']['url'] = "#{node['vagrant']['base_url']}/vagrant_#{node['vagrant']['version']}_#{node['kernel']['machine']}.rpm"
  case node['kernel']['machine']
  when 'i686'
    default['vagrant']['checksum'] = '68d4673fe7657cc8d075412f57a19c878a6e187b2f2fc54462e5ac3041d912fe'
  when 'x86_64'
    default['vagrant']['checksum'] = 'a2057895601f46db4de22832ac462ee63e07e9905c1bfd11318290bd362137f9'
else
  default['vagrant']['url'] = nil
  default['vagrant']['checksum'] = nil
end
