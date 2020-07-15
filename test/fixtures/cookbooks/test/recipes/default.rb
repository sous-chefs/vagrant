# Cookbook:: test
# Test:: default

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

node.default['vagrant']['plugins'] = %w(
  vagrant-ohai
  vagrant-vbguest
)

node.default['vagrant']['user'] = 'root'

if platform_family?('debian')
  apt_update
  package %w(qemu ebtables dnsmasq-base)
  package %w(libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev)
  node.default['vagrant']['plugins'] << { 'name' => 'vagrant-libvirt', 'env' => { CONFIGURE_ARGS: 'with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib64:/usr/lib/libvirt:/usr/lib/x86_64-linux-gnu' } }
end

include_recipe 'vagrant::default'

include_recipe 'vagrant::install_plugins'

# Install the plugins in the /root directory
%w(vagrant-ohai vagrant-berkshelf vagrant-omnibus vagrant-vbguest).each do |plugin|
  vagrant_plugin plugin do
    vagrant_home '/root/.vagrant.d'
  end
end
