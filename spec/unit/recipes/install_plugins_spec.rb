RSpec.describe 'vagrant::install_plugins' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'ubuntu',
      version: '14.04',
      file_cache_path: '/var/tmp'
    )
  end

  it 'with no vagrant user specified, installs an array of plugins' do
    chef_run.node.set['vagrant']['plugins'] = %w(vagrant-omnibus vagrant-aws)
    chef_run.converge(described_recipe)
    expect(chef_run).to install_vagrant_plugin('vagrant-omnibus')
    expect(chef_run).to install_vagrant_plugin('vagrant-aws')
  end

  it 'with a vagrant user specified, installs a single plugin' do
    chef_run.node.set['vagrant']['user'] = 'my_user'
    chef_run.node.set['vagrant']['plugins'] = %w(vagrant-omnibus)
    chef_run.converge(described_recipe)
    expect(chef_run).to install_vagrant_plugin('vagrant-omnibus').with(
      user: 'my_user'
    )
  end

  it 'with a hash specifying a plugin name, version, and source' do
    chef_run.node.set['vagrant']['user'] = 'my_user'
    chef_run.node.set['vagrant']['plugins'] = [
      { name: 'vagrant_plugin_1', version: '1.0.0',
        source: %w(https://vagrant.example.com/my_plugin file://my_plugin)
      },
      { name: 'vagrant_plugin_2', version: '2.0.0' }
    ]
    chef_run.converge(described_recipe)

    expect(chef_run).to install_vagrant_plugin('vagrant_plugin_1').with(
      user: 'my_user',
      version: '1.0.0',
      sources: %w(https://vagrant.example.com/my_plugin file://my_plugin)
    )
    expect(chef_run).to install_vagrant_plugin('vagrant_plugin_2').with(
      user: 'my_user',
      version: '2.0.0'
    )
  end

  it 'with a hash specifying a plugin name' do
    chef_run.node.set['vagrant']['plugins'] = [{ name: 'my_plugin_without_version' }]
    chef_run.converge(described_recipe)

    expect(chef_run).to install_vagrant_plugin('my_plugin_without_version')
  end
end
