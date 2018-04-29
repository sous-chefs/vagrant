# Cookbook Name:: test
# Test:: windows_location

# Copyright 2018 Sous-chefs
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

ENV['VAGRANT_HOME'] = 'C:/Users/altloc'
node.default['vagrant']['plugins'] = %w(vagrant-ohai vagrant-winrm vagrant-omnibus)

directory 'C:/Users/altloc' do
  owner 'vagrant'
  rights :full_control, 'Everyone', applies_to_children: true
end

include_recipe 'vagrant'
