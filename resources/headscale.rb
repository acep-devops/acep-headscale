# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/
provides :headscale
unified_mode true

property :source, String
property :version, String, required: true
property :checksum, String, required: true

action :install do
  unless new_resource.source
    new_resource.source = "https://github.com/juanfont/headscale/releases/download/v#{new_resource.version}/headscale_#{new_resource.version}_linux_amd64.deb"
  end

  headscale_pkg = "#{Chef::Config['file_cache_path']}/headscale_#{new_resource.version}_linux_amd64.deb"

  remote_file headscale_pkg do
    source new_resource.source
    checksum new_resource.checksum
    action :create
  end

  dpkg_package headscale_pkg do
    action [:install, :upgrade]
  end
end

action :enable do
  service 'headscale' do
    action [:enable]
  end
end

action :disable do
  service 'headscale' do
    action [:disable]
  end
end

action :start do
  service 'headscale' do
    action [:start]
  end
end

action :restart do
  service 'headscale' do
    action [:restart]
  end
end
