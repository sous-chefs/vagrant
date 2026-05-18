# frozen_string_literal: true

require 'spec_helper'

describe 'vagrant' do
  step_into :vagrant
  platform 'ubuntu', '24.04'

  before do
    stubs_for_provider('vagrant[Vagrant]') do |provider|
      allow(provider).to receive_shell_out('vagrant --version').and_return(double(stdout: "Vagrant 0.0.0\n"))
    end
  end

  context 'with default properties' do
    recipe do
      vagrant 'Vagrant' do
        url 'https://releases.hashicorp.com/vagrant/2.4.9/vagrant_2.4.9-1_amd64.deb'
        checksum 'abc123'
      end
    end

    it { is_expected.to create_remote_file("#{Chef::Config[:file_cache_path]}/vagrant.deb").with(source: 'https://releases.hashicorp.com/vagrant/2.4.9/vagrant_2.4.9-1_amd64.deb', checksum: 'abc123') }
    it { is_expected.to install_dpkg_package('vagrant').with(source: "#{Chef::Config[:file_cache_path]}/vagrant.deb", version: '2.4.9') }
    it { is_expected.to delete_file("#{Chef::Config[:file_cache_path]}/vagrant.deb") }
  end

  context 'with plugins' do
    recipe do
      vagrant 'Vagrant' do
        url 'https://releases.hashicorp.com/vagrant/2.4.9/vagrant_2.4.9-1_amd64.deb'
        checksum 'abc123'
        plugin_user 'root'
        plugins [
          'vagrant-ohai',
          { name: 'vagrant-berkshelf', version: '1.2.0', sources: ['https://plugins.example.test'] },
        ]
      end
    end

    it { is_expected.to install_vagrant_plugin('vagrant-ohai').with(user: 'root') }
    it { is_expected.to install_vagrant_plugin('vagrant-berkshelf').with(version: '1.2.0', sources: ['https://plugins.example.test'], user: 'root') }
  end

  context 'with appimage' do
    recipe do
      vagrant 'Vagrant' do
        appimage true
        url 'https://releases.hashicorp.com/vagrant/2.4.9/vagrant_2.4.9_linux_amd64.zip'
        checksum 'abc123'
      end
    end

    it { is_expected.to install_package('openssh-client') }
    it { is_expected.to create_remote_file("#{Chef::Config[:file_cache_path]}/vagrant.zip") }
    it { is_expected.to extract_archive_file("#{Chef::Config[:file_cache_path]}/vagrant.zip").with(destination: '/usr/local/bin') }
  end

  context 'with action uninstall' do
    recipe do
      vagrant 'Vagrant' do
        action :uninstall
      end
    end

    it { is_expected.to remove_package('vagrant') }
  end
end
