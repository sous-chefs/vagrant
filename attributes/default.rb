# Cookbook:: vagrant
# Attributes:: default

# Author:: Joshua Timberman <opensource@housepub.org>
# Copyright:: (c) 2013-2014, Joshua Timberman
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

return unless %w(darwin windows linux).include?(node['os'])

default['vagrant']['version']     = '2.3.4'

# the URL and checksum are calculated from the package version by helper methods
# in the install resource if you don't override them in a wrapper cookbook
default['vagrant']['url']         = nil
default['vagrant']['checksum']    = nil
default['vagrant']['appimage']      = nil
default['vagrant']['appimage_file'] = nil

default['vagrant']['plugins']     = []
default['vagrant']['user']        = nil
# password is required on Windows if you want to install plugins as another user
default['vagrant']['password'] = nil
