require 'etc'
require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

use_inline_resources if defined?(:use_inline_resources)

def load_current_resource
  @current_resource = Chef::Resource::VagrantPlugin.new(new_resource)
  vp = shell_out('vagrant plugin list', {
                                         :user => run_as_user,
                                         :env => {
                                                  'VAGRANT_HOME' => vagrant_home
                                                 }
                                        })
  if vp.stdout.include?(new_resource.plugin_name)
    @current_resource.installed(true)
    installed_line = vp.stdout.split("\n").detect { |line| line.include? new_resource.plugin_name }
    installed_version = installed_line.split('(')[1].split(')')[0]
    @current_resource.installed_version(installed_line.gsub(/[\(\)]/, ''))
  end
  @current_resource
end

action :install do
  unless installed?
    plugin_args = ""
    plugin_args += "--plugin-version #{new_resource.version}" if new_resource.version

    unless new_resource.sources.empty?
      sources = Array(new_resource.sources)
      sources.each do |source|
        plugin_args += " --plugin-source #{source}"
      end
    end

    execute "installing vagrant plugin #{new_resource.plugin_name}" do
      command "vagrant plugin install #{new_resource.plugin_name} #{plugin_args}"
      user new_resource.user
      environment 'VAGRANT_HOME' => vagrant_home
    end
  end
end

action :remove do
  uninstall if @current_resource.installed
end

action :uninstall do
  uninstall if @current_resource.installed
end

def uninstall
  execute "vagrant plugin uninstall #{new_resource.plugin_name}" do
    user new_resource.user
    environment 'VAGRANT_HOME' => vagrant_home
  end
end

def run_as_user
  case new_resource.user
  when String
    Chef::Log.debug("I found a string for `#{new_resource.user}`")
    new_resource.user
  when NilClass
    begin
      Chef::Log.debug("I'm searching for a resource user[#{new_resource.user}]")
      run_context.resource_collection.find("user[#{new_resource.user}]").username
    rescue ArgumentError
      Chef::Log.debug("Trying to find the user by the process UID #{Process.uid}")
      Etc.getpwuid(Process.uid).name
    end
  end
end

def vagrant_home
  ::File.join(vagrant_get_home(run_as_user), '.vagrant.d')
end

def installed?
  @current_resource.installed && version_match
end

def version_match
  # if the version is specified, we need to check if it matches what
  # is installed already
  if new_resource.version
    @current_resource.installed_version == "#{new_resource.plugin_name} #{new_resource.version}"
  else
    # the version matches otherwise because it's installed
    true
  end
end
