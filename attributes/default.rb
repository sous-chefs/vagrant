#
# Author:: Joshua Timberman <opensource@housepub.org>
# Copyright (c) 2013-2014, Joshua Timberman
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

default['vagrant']['url'] = nil
default['vagrant']['checksum'] = nil
default['vagrant']['msi_version'] = ""
default['vagrant']['plugins'] = []

# Set user and home resource attrs for default plugins installed from
# node['vagrant']['plugins'] array.
default['vagrant']['user'] = nil
default['vagrant']['home'] = nil
