# Cookbook Name:: test
# Test:: uninstall

# Copyright 2019 Sous Chefs
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

node.default['vagrant']['plugins'] = %w(vagrant-ohai)

node['vagrant']['plugins'].each do |plugin|
  vagrant_plugin "uninstall #{plugin}" do
    plugin_name plugin
    action :uninstall
  end
end

include_recipe 'vagrant::uninstall_gem'
