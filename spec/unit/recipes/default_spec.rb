# Author:: Joshua Timberman <opensource@housepub.org>
# Copyright:: Copyright (c) 2014, Joshua Timberman
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

RSpec.describe 'vagrant::default' do
  before(:each) do
    allow_any_instance_of(Chef::Recipe).to receive(:vagrant_sha256sum)
      .and_return('abc123')
  end

  context 'debian' do
    before(:each) do
      # required to make specs pass on Windows
      stub_const('RUBY_PLATFORM', 'x86_64-linux')
    end

    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'ubuntu',
        version: '14.04',
        file_cache_path: '/var/tmp'
      ) do |node|
        node.set['vagrant']['version'] = '1.88.88'
      end.converge(described_recipe)
    end

    it 'includes the debian platform family recipe' do
      expect(chef_run).to include_recipe('vagrant::debian')
    end

    it 'downloads the package from the calculated URI' do
      expect(chef_run).to create_remote_file('/var/tmp/vagrant.deb').with(
        source: 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.88.88_x86_64.deb'
      )
    end

    it 'installs the downloaded package' do
      expect(chef_run).to install_dpkg_package('vagrant').with(
        source: '/var/tmp/vagrant.deb'
      )
    end
  end

  context 'fedora' do
    before(:each) do
      # required to make specs pass on Windows
      stub_const('RUBY_PLATFORM', 'x86_64-linux')
    end

    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'fedora',
        version: '21',
        file_cache_path: '/var/tmp'
      ) do |node|
        node.set['vagrant']['version'] = '1.88.88'
      end.converge(described_recipe)
    end

    it 'includes the rhel platform family recipe' do
      expect(chef_run).to include_recipe('vagrant::rhel')
    end

    it 'downloads the package from the calculated URI' do
      expect(chef_run).to create_remote_file('/var/tmp/vagrant.rpm').with(
        source: 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.88.88_x86_64.rpm'
      )
    end

    it 'installs the downloaded package' do
      expect(chef_run).to install_rpm_package('vagrant').with(
        source: '/var/tmp/vagrant.rpm'
      )
    end
  end

  context 'rhel' do
    before(:each) do
      # required to make specs pass on Windows
      stub_const('RUBY_PLATFORM', 'x86_64-linux')
    end

    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos',
        version: '6.6',
        file_cache_path: '/var/tmp'
      ) do |node|
        node.set['vagrant']['version'] = '1.88.88'
      end.converge(described_recipe)
    end

    it 'includes the rhel platform family recipe' do
      expect(chef_run).to include_recipe('vagrant::rhel')
    end

    it 'downloads the package from the calculated URI' do
      expect(chef_run).to create_remote_file('/var/tmp/vagrant.rpm').with(
        source: 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.88.88_x86_64.rpm'
      )
    end

    it 'installs the downloaded package' do
      expect(chef_run).to install_rpm_package('vagrant').with(
        source: '/var/tmp/vagrant.rpm'
      )
    end
  end

  context 'suse' do
    before(:each) do
      # required to make specs pass on Windows
      stub_const('RUBY_PLATFORM', 'x86_64-linux')
    end

    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'suse',
        version: '12.0',
        file_cache_path: '/var/tmp'
      ) do |node|
        node.set['vagrant']['version'] = '1.88.88'
      end.converge(described_recipe)
    end

    it 'includes the rhel platform family recipe' do
      expect(chef_run).to include_recipe('vagrant::rhel')
    end

    it 'downloads the package from the calculated URI' do
      expect(chef_run).to create_remote_file('/var/tmp/vagrant.rpm').with(
        source: 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.88.88_x86_64.rpm'
      )
    end

    it 'installs the downloaded package' do
      expect(chef_run).to install_rpm_package('vagrant').with(
        source: '/var/tmp/vagrant.rpm'
      )
    end
  end

  context 'os x' do
    before(:each) do
      # required to make specs pass on Windows
      stub_const('RUBY_PLATFORM', 'x86_64-darwin12.0')
    end

    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'mac_os_x',
        version: '10.10',
        file_cache_path: '/var/tmp'
      ) do |node|
        node.set['vagrant']['version'] = '1.88.88'
      end.converge(described_recipe)
    end

    it 'includes the os x platform family recipe' do
      expect(chef_run).to include_recipe('vagrant::mac_os_x')
    end

    it 'installs the downloaded package with the calculated source URI' do
      expect(chef_run).to install_dmg_package('Vagrant').with(
        source: 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.88.88.dmg'
      )
    end
  end

  context 'windows' do
    # We can't stub_const('RUBY_PLATFORM', 'windows') here because Chef will
    # try to load Windows-specific gems which don't exist on Linux
    # before(:each) do
    #   # required to make specs pass on Windows
    #   stub_const('RUBY_PLATFORM', 'x86_64-mingw32')
    # end

    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'windows',
        version: '2012R2'
      ).converge(described_recipe)
    end

    it 'includes the windows platform family recipe' do
      expect(chef_run).to include_recipe('vagrant::windows')
    end
  end
end
