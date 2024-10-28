# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/
unified_mode true

provides :headscale_user

property :username, String, name_property: true

action :create do
  execute "create_user_#{new_resource.username}" do
    command "headscale users create #{new_resource.username}"
    not_if { headscale_users.include?(new_resource.username) }
  end
end

action :destroy do
  execute "destroy_user_#{new_resource.username}" do
    command "headscale users destroy #{new_resource.username}"
    only_if { headscale_users.include?(new_resource.username) }
  end
end

action_class do
  include AcepHeadscale::HeadscaleHelpers
end
