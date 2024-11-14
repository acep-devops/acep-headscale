default['headscale']['port'] = nil
default['headscale']['server_url'] = nil
default['headscale']['listen_addr'] = nil
default['headscale']['grpc_listen_addr'] = nil
default['headscale']['override_local_dns'] = false
default['headscale']['magicdns'] = true
default['headscale']['acl_data_bag'] = 'default_acls'
default['headscale']['nameservers'] = []

default['headscale']['enable_ssl'] = true
default['headscale']['acme_email'] = 'uaf-acep-ci@alaska.edu'
default['headscale']['base_domain'] = 'acep.priv'

default['headscale']['v4_ip_prefixes'] = nil
default['headscale']['v6_ip_prefixes'] = nil

default['headscale']['users'] = []
default['headscale']['users_databag'] = ''

default['tailscale']['login_server'] = nil
default['tailscale']['auth_key'] = nil
