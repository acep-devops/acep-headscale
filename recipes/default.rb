#
# Cookbook:: acep-headscale
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

acls = data_bag_item('headscale', node['headscale']['acl_data_bag'])['headscale']

headscale 'default' do 
  version '0.22.3'
  checksum '2b45be5aa7b95c2512f57c83931ed3eb4f546fca5dfc771c7458a13392adb331'
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
end

headscale_user 'acep' do 
  action :create
end
