# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/
unified_mode true

provides :headscale_config

property :path, String, default: '/etc/headscale/config.yaml'

property :acls, Hash, default: {}
property :acl_path, String, default: '/etc/headscale/acls.json'

property :server_url, String, required: true
property :port, [Integer, String], default: '8080'
property :listen_addr, String, default: '0.0.0.0'
property :grpc_listen_addr, String, default: '0.0.0.0:50443'
property :override_local_dns, [true, false], default: false
property :magicdns, [true, false], default: false
property :base_domain, String, default: 'acep.priv'
property :ip_prefixes, Array, default: ['100.64.0.0/10']
property :enable_ssl, [true, false], default: true
property :acme_email, String, default: ''
property :nameservers, Array, default: []

# default['headscale']['http_scheme'] = 'http'
# default['headscale']['hostname'] = ''
# default['headscale']['port'] = '8080'
# default['headscale']['server_url'] = "#{node['headscale']['http_scheme']}://#{node['headscale']['hostname']}:#{node['headscale']['port']}"
# default['headscale']['listen_addr'] = "0.0.0.0:#{node['headscale']['port']}"
# default['headscale']['grpc_listen_addr'] = '0.0.0.0:50443'
# default['headscale']['override_local_dns'] = 'false'
# default['headscale']['magicdns'] = 'false'
# default['headscale']['acl_path'] = '/etc/headscale/acls.json'
# default['headscale']['acl_data_bag'] = 'default_acls'
# default['headscale']['ip_prefixes'] = ['100.64.0.0/10']

# default['headscale']['enable_ssl'] = true
# default['headscale']['acme_email'] = 'uaf-acep-ci@alaska.edu'

action :create do 
  service 'headscale' do
    action :nothing
  end

  directory ::File.dirname(new_resource.acl_path) do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  file new_resource.acl_path do
    owner 'root'
    group 'root'
    content new_resource.acls.to_json
    mode '0644'
    action :create
    notifies :restart, 'service[headscale]', :delayed
  end

  config = {
    'server_url' => new_resource.server_url,
    'port' => new_resource.port,
    'listen_addr' => "#{new_resource.listen_addr}:#{new_resource.port}",
    'grpc_listen_addr' => new_resource.grpc_listen_addr,
    'override_local_dns' => new_resource.override_local_dns ? 'true' : 'false',
    'magicdns' => new_resource.magicdns ? 'true' : 'false',
    'ip_prefixes' => new_resource.ip_prefixes,
    'enable_ssl' => new_resource.enable_ssl,
    'acme_email' => new_resource.acme_email,
    'acl_path' => new_resource.acl_path,
    'base_domain' => new_resource.base_domain,
    'nameservers' => new_resource.nameservers
  }

  template new_resource.path do
    source 'headscale_config.yaml.erb'
    cookbook 'acep-headscale'
    variables config
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    notifies :start, 'service[headscale]', :immediately
    notifies :restart, 'service[headscale]', :delayed
  end
end