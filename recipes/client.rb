#
# Cookbook:: acep-headscale
# Recipe:: client
#
# Copyright:: 2024, The Authors, All Rights Reserved.

tailscale 'default' do
    login_server node['tailscale']['login_server']
    auth_key node['tailscale']['auth_key']
    action [:install, :up]
end