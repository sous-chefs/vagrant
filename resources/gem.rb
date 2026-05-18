# frozen_string_literal: true

provides :vagrant_gem
unified_mode true

default_action :remove

property :gem_name, String, name_property: true

action :remove do
  gem_package new_resource.gem_name do
    action :remove
  end

  chef_gem new_resource.gem_name do
    action :remove
  end
end
