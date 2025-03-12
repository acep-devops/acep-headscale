#
# Cookbook:: acep-headscale
# Recipe:: client
#
# Copyright:: 2024, The Authors, All Rights Reserved.

tailscale 'default' do
  login_server node['tailscale']['login_server']
  auth_key node['tailscale']['auth_key']
  advertise_routes node['tailscale']['advertise_routes']
  advertise_tags node['tailscale']['advertise_tags']
  accept_dns node['tailscale']['accept_dns']
  accept_routes node['tailscale']['accept_routes']
  reset node['tailscale']['reset']
  action [:install, :up]
end
