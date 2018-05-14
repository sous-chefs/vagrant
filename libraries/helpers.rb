# Cookbook Name:: vagrant
# Library:: helpers

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

require 'uri'
require 'open-uri'

module Vagrant
  module Helpers
    def vagrant_package_uri
      "#{vagrant_base_uri}#{package_version}/#{package_name}"
    end

    def vagrant_sha256sum
      sha256sums = fetch_platform_checksums_for_version
      extract_checksum(sha256sums)
    end

    private

    def vagrant_base_uri
      'https://releases.hashicorp.com/vagrant/'
    end

    def package_name
      "vagrant_#{package_version}#{package_extension}"
    end

    def package_version
      @vagrant_version
    end

    def package_extension
      extension = value_for_platform_family(
        'mac_os_x' =>  mac_os_x_extension,
        'windows' => windows_extension,
        'debian' => '_x86_64.deb',
        %w(rhel suse fedora amazon) => '_x86_64.rpm'
      )
      raise ArgumentError "HashiCorp doesn't provide a Vagrant package for the #{node['platform']} platform." if extension.nil?

      extension
    end

    def fetch_platform_checksums_for_version
      checksums_url = "#{vagrant_base_uri}#{package_version}/vagrant_#{package_version}_SHA256SUMS?direct"
      open(checksums_url).readlines
    end

    def extract_checksum(sha256sums)
      raise "SHA 256 sum not found for the Vagrant package #{package_name}" unless sha256sums.grep(/#{package_name}/)[0].respond_to?(:split)
      sha256sums.grep(/#{package_name}/)[0].split.first
    end

    def mac_os_x_extension
      last_using_dmg = Gem::Version.new('1.9.2')
      Gem::Version.new(package_version) > last_using_dmg ? '_x86_64.dmg' : '.dmg'
    end

    def windows_extension
      last_using_msi = Gem::Version.new('1.9.5')
      Gem::Version.new(package_version) > last_using_msi ? "#{windows_machine}.msi" : '.msi'
    end

    def windows_machine
      node['kernel']['machine'] == 'x86_64' ? '_x86_64' : '_i686'
    end
  end
end
