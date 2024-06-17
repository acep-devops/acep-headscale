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
  module TailscaleHelpers
    def tailscale_status
      @tailscale_status ||= JSON.parse(shell_out('tailscale status --json').stdout)
    end

    def clear_status!
      @tailscale_status = nil
    end

    def is_online?
      tailscale_status['Self']['Online']
    end
  end
end

#
# The module you have defined may be extended within the recipe to grant the
# recipe the helper methods you define.
#
# Within your recipe you would write:
#
#     extend AcepHeadscale::TailscaleHelpers
#
#     my_helper_method
#
# You may also add this to a single resource within a recipe:
#
#     template '/etc/app.conf' do
#       extend AcepHeadscale::TailscaleHelpers
#       variables specific_key: my_helper_method
#     end
#
