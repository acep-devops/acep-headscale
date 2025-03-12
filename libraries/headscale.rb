#
# Chef Infra Documentation
# https://docs.chef.io/libraries/
#

#
# This module name was auto-generated from the cookbook name. This name is a
# single word that starts with a capital letter and then continues to use
# camel-casing throughout the remainder of the name.
#
module AcepHeadscale
  module HeadscaleHelpers
    def headscale_users
      user_output = shell_out('headscale users list -o json').stdout
      if user_output.nil? || user_output.empty?
        return []
      end

      users = JSON.parse(user_output)
      @headscale_users ||= users.collect do |user|
        user['name']
      end if !users.nil? && !users.empty?

      @headscale_users || []
    end

    def headscale_routes
      @headscale_routes ||= fetch_headscale_routes
    end

    def fetch_headscale_routes
      routes_output = shell_out('headscale routes list -o json').stdout
      if routes_output.nil? || routes_output.empty?
        return {}
      end

      routes = {}
      json_routes = JSON.parse(routes_output)
      json_routes.each do |route|
        routes[route['prefix']] = route
      end if !json_routes.nil? && !json_routes.empty?

      routes || {}
    end

    def clear_users
      @headscale_users = nil
    end
  end
end

#
# The module you have defined may be extended within the recipe to grant the
# recipe the helper methods you define.
#
# Within your recipe you would write:
#
#     extend AcepHeadscale::HeadscaleHelpers
#
#     my_helper_method
#
# You may also add this to a single resource within a recipe:
#
#     template '/etc/app.conf' do
#       extend AcepHeadscale::HeadscaleHelpers
#       variables specific_key: my_helper_method
#     end
#
