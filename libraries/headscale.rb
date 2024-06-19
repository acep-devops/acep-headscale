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
      users = JSON.parse(shell_out('headscale users list -o json').stdout)
      @headscale_users ||= users.collect do |user|
        user["name"]
      end if !users.nil? && users.length > 0

      @headscale_users || []
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
