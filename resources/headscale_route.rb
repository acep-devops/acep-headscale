# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/
unified_mode true

include AcepHeadscale::HeadscaleHelpers

provides :headscale_route

property :enabled, [true, false]
property :advertised, [true, false]

load_current_value do |new_resource|
  route = headscale_routes[new_resource.name]
  current_value_does_not_exist! if route.nil?

  enabled route['enabled'] ? true : false
  advertised route['advertise'] ? true : false
end

action :run do
  route_id = headscale_routes.dig(new_resource.name, 'id')

  converge_if_changed :enabled do
    if new_resource.enabled
      execute "headscale routes enable -r #{route_id}" do
      end
    else
      execute "headscale routes disable -r #{route_id}" do
      end
    end
  end
end
