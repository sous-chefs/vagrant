#
# Add authorizations so shell_out will work
# Adding attributes will work on the next chef-client run, not the current run
#
# References for setting windows privleges
# https://discourse.chef.io/t/setting-replace-a-process-level-token-windows-permission-mid-chef-run/7420/2
# https://pwrshell.net/attribuer-des-privileges-locaux/
# https://github.com/chef/chef/blob/7f69ad99a2446e9c70112aa531f68a971a52758f/lib/chef/provider/service/windows.rb#L241-L251
# Took most of the code from chef/lib/chef/provider/service/windows.rb

resource_name :authorize_service
property :service, String, required: true
property :user, String, required: true

require 'chef/provider/service/simple' if node['os'] =~ /win/i
require 'chef/win32/error' if node['os'] =~ /win/i
require 'win32/service' if node['os'] =~ /win/i

action_class do
  include Chef::ReservedNames::Win32::API::Error
  def grant_service(username, service_name)
    begin
      Chef::ReservedNames::Win32::Security.add_account_right(username, service_name)
    rescue Chef::Exceptions::Win32APIError => err
      Chef::Log.fatal "Logon-as-service grant failed with output: #{err}"
      raise Chef::Exceptions::Service, "#{service_name} grant failed for #{username}: #{err}"
    end

    Chef::Log.info "Grant #{service_name} to user '#{username}' successful."
    true
  end
end

action :authorize do
  unless Chef::ReservedNames::Win32::Security.get_account_right(new_resource.user).include?(new_resource.service)
    converge_by("Add service #{new_resource.service} for user #{new_resource.user}") do
      grant_service(new_resource.user, new_resource.service)
    end
  end
end
