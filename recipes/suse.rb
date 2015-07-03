Chef::Log.debug 'SUSE is not specifically supported by vagrant, going to try anyway as if we were RHEL (rpm install).' if platform_family?('suse')

include_recipe 'vagrant::rhel'
