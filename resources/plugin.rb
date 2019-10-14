# Cookbook:: vagrant
# Resource:: plugin

# Copyright:: 2015 Joshua Timberman
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

default_action :install

property :plugin_name, name_property: true
property :version, String
property :env, [Hash, nil], default: nil
property :user, String
property :password, String
property :sources, [String, Array]
property :vagrant_home, String

action_class do
  def plugin
    is_windows = platform_family?('windows')
    @plugin ||= Vagrant::Plugin.new(
      new_resource.plugin_name,
      is_windows,
      env: new_resource.env,
      username: new_resource.user,
      password: new_resource.password,
      vagrant_home: new_resource.vagrant_home
    )
  end

  def uninstall
    return unless plugin.installed?

    converge_by("Uninstalling Vagrant plugin: #{new_resource.name}") do
      plugin.uninstall
    end
  end
end

action :install do
  return unless plugin.install?(new_resource.version)

  converge_by("Installing Vagrant plugin: #{new_resource.name} #{new_resource.version}") do
    plugin.install(new_resource.version, Array(new_resource.sources))
  end
end

action :remove do
  uninstall
end

action :uninstall do
  uninstall
end
