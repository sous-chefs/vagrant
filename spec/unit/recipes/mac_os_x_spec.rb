RSpec.describe 'vagrant::mac_os_x' do
  include_context 'mock vagrant_sha256sum'

  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'mac_os_x',
      version: '10.10',
      file_cache_path: '/var/tmp'
    ) do |node|
      node.normal['vagrant']['version'] = '1.88.88'
    end.converge(described_recipe)
  end

  it 'installs the downloaded package with the calculated source URI' do
    expect(chef_run).to install_dmg_package('Vagrant').with(
      source: 'https://releases.hashicorp.com/vagrant/1.88.88/vagrant_1.88.88_x86_64.dmg'
    )
  end

  let(:chef_run_old) do
    ChefSpec::SoloRunner.new(
      platform: 'mac_os_x',
      version: '10.10',
      file_cache_path: '/var/tmp'
    ) do |node|
      node.normal['vagrant']['version'] = '1.9.1'
    end.converge(described_recipe)
  end

  it 'installs an older vagrant package with the calculated source URI' do
    expect(chef_run_old).to install_dmg_package('Vagrant').with(
      source: 'https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1.dmg'
    )
  end
end
