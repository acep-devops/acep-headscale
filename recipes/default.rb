#
# Cookbook:: acep-headscale
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

headscale_pkg = "#{Chef::Config['file_cache_path']}/headscale_0.22.3_linux_amd64.deb"

remote_file headscale_pkg do
  source node['headscale']['package_source']
  checksum node['headscale']['package_checksum']
  action :create
end

dpkg_package headscale_pkg do
  action :install
end

template '/etc/headscale/config.yaml' do
  source 'headscale_config.yaml.erb'
  variables node['headscale']
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  notifies :restart, 'service[headscale]', :immediately
end

service 'headscale' do
  action [:enable, :start]
end
