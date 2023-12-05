#
# Cookbook:: acep-headscale
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

headscale_pkg = "#{Chef::Config['file_cache_path']}/headscale_0.22.3_linux_amd64.deb"

remote_file headscale_pkg do
  source 'https://github.com/juanfont/headscale/releases/download/v0.22.3/headscale_0.22.3_linux_amd64.deb' 
  checksum '2b45be5aa7b95c2512f57c83931ed3eb4f546fca5dfc771c7458a13392adb331'
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
