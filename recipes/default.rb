#
# Cookbook:: acep-headscale
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

acls = data_bag_item('headscale', node['headscale']['acl_data_bag'])['headscale']

headscale 'default' do
  version '0.25.1'
  checksum 'eae66279f985a131338856193e88d0731391375961e3e75b27d1762380c594b3'
  action [:install, :enable]
  delayed_action [:start]
end

headscale_config '/etc/headscale/config.yaml' do
  acls acls

  server_url node['headscale']['server_url']
  port node['headscale']['port']
  listen_addr node['headscale']['listen_addr']
  grpc_listen_addr node['headscale']['grpc_listen_addr']
  override_local_dns node['headscale']['override_local_dns']
  magicdns node['headscale']['magicdns']
  v4_ip_prefixes node['headscale']['v4_ip_prefixes']
  v6_ip_prefixes node['headscale']['v6_ip_prefixes']
  enable_ssl node['headscale']['enable_ssl']
  acme_email node['headscale']['acme_email']
  base_domain node['headscale']['base_domain']
  nameservers node['headscale']['nameservers']
end

users = node['headscale']['users']
users += data_bag_item('headscale', node['headscale']['users_databag'])['users'] unless node.read('headscale', 'users_databag').empty?

users.uniq.each do |u|
  headscale_user u do
    delayed_action :create
  end
end
