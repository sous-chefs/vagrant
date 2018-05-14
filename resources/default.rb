# Cookbook Name:: vagrant
# Resource:: install
# Copyright 2018 Sous Chefs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

property :checksum, String
property :url, String
property :version, String

action_class do
  include Vagrant::Helpers

  def debian(pkg_uri, pkg_file, pkg_checksum, pkg_version)
    if install?
      remote_file pkg_file do
        source pkg_uri
        checksum pkg_checksum
      end
      dpkg_package 'vagrant' do
        source pkg_file
        version pkg_version
      end
    end
    file pkg_file do
      action :delete
    end
  end

  def mac_os_x(pkg_uri, pkg_checksum)
    dmg_package 'Vagrant' do
      source pkg_uri
      checksum pkg_checksum
      type 'pkg'
      package_id 'com.vagrant.vagrant'
      action :install
    end
  end

  def rhel(pkg_uri, pkg_file, pkg_checksum)
    if install?
      remote_file pkg_file do
        source pkg_uri
        checksum pkg_checksum
      end
      rpm_package 'vagrant' do
        source pkg_file
      end
    end
    file pkg_file do
      action :delete
    end
  end

  def windows(pkg_uri, pkg_checksum, pkg_version)
    return unless install?
    windows_package 'Vagrant' do
      action :install
      version pkg_version
      source pkg_uri
      checksum pkg_checksum
      returns [1641, 3010]
      options '/norestart'
      # We'll do the restart through chef itself to prevent the cookbook from
      # continuing to run while the Vagrant MSI is telling Windows to reboot
      notifies :reboot_now, 'reboot[reboot_now]', :immediately
    end
    reboot 'reboot_now' do
      action :nothing
    end
  end

  def install?
    Gem::Version.new(@vagrant_version) > installed_version
  end

  def installed_version
    begin
      query = shell_out('vagrant --version').stdout.chomp
    rescue Errno::ENOENT
      query = ''
    end
    md = /^Vagrant\s+(?<version>\d+\.\d+\.\d+)/.match(query)
    md ? Gem::Version.new(md[:version]) : Gem::Version.new('0.0.0')
  end
end

action :install do
  @vagrant_version = new_resource.version
  vagrant_url = new_resource.url || vagrant_package_uri
  vagrant_checksum = new_resource.checksum || vagrant_sha256sum
  vagrant_rpm = "#{Chef::Config[:file_cache_path]}/vagrant.rpm"
  vagrant_deb = "#{Chef::Config[:file_cache_path]}/vagrant.deb"

  case node['platform_family']
  when 'debian'
    debian(vagrant_url, vagrant_deb, vagrant_checksum, @vagrant_version)

  when 'rhel', 'amazon', 'fedora', 'suse'
    Chef::Log.warning 'SUSE is not specifically supported by Vagrant, going to try anyway as if we were RHEL (rpm install).' if platform_family?('suse')
    Chef::Log.warning 'Amazon is not specifically supported by Vagrant, going to try anyway as if we were RHEL (rpm install).' if platform_family?('amazon')
    rhel(vagrant_url, vagrant_rpm, vagrant_checksum)

  when 'mac_os_x'
    mac_os_x(vagrant_url, vagrant_checksum)

  when 'windows'
    windows(vagrant_url, vagrant_checksum, @vagrant_version)

  else
    Chef::Log.warning "Unsupported OS #{node['platform_family']}"
  end
end

action :uninstall do
  gem_package 'vagrant' do
    action :remove
  end
  chef_gem 'vagrant' do
    action :remove
  end
end
