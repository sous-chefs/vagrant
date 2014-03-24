default['vagrant']['url'] = nil
default['vagrant']['checksum'] = nil
default['vagrant']['msi_version'] = ""
default['vagrant']['plugins'] = []

# Set user and home resource attrs for default plugins installed from
# node['vagrant']['plugins'] array.
default['vagrant']['user'] = nil
default['vagrant']['home'] = nil
