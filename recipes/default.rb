#
# Cookbook:: acep-headscale
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

acls = data_bag_item('headscale', node['headscale']['acl_data_bag'])['headscale']

headscale 'default' do
  version '0.23.0'
  checksum '3a610d3941de367a57b63b277054e02dee90084d3a6f6112a57709ec5cdd7b75'
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
  ip_prefixes node['headscale']['ip_prefixes']
  enable_ssl node['headscale']['enable_ssl']
  acme_email node['headscale']['acme_email']
  base_domain node['headscale']['base_domain']
  nameservers node['headscale']['nameservers']
end

headscale_user 'acep' do
  action :create
end
