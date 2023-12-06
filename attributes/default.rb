default['headscale']['http_scheme'] = 'http'
default['headscale']['hostname'] = ''
default['headscale']['port'] = '8080'
default['headscale']['server_url'] = "#{node['headscale']['http_scheme']}://#{node['headscale']['hostname']}:#{node['headscale']['port']}"
default['headscale']['listen_addr'] = "0.0.0.0:#{node['headscale']['port']}"
default['headscale']['grpc_listen_addr'] = '0.0.0.0:50443'
default['headscale']['override_local_dns'] = 'false'
default['headscale']['magicdns'] = 'false'

default['headscale']['acme_email'] = ''

default['headscale']['package_source'] = 'https://github.com/juanfont/headscale/releases/download/v0.22.3/headscale_0.22.3_linux_amd64.deb'
default['headscale']['package_checksum'] = '2b45be5aa7b95c2512f57c83931ed3eb4f546fca5dfc771c7458a13392adb331'
