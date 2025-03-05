# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/
provides :tailscale
unified_mode true

property :auth_key, String

property :accept_dns,
        [true, false, String],
        default: true,
        coerce: proc { |p| p ? 'true' : 'false' }

property :accept_routes,
        [true, false, String],
        default: false,
        coerce: proc { |p| p ? 'true' : 'false' }

property :reset,
        [true, false, String],
        default: false,
        coerce: proc { |p| p ? 'true' : 'false' }

property :advertise_routes, Array
property :advertise_tags, Array

property :force_reauth,
        [true, false, String],
        default: false,
        coerce: proc { |p| p ? 'true' : 'false' }

property :hostname, String
property :timeout, String, default: '30s'
property :login_server, String, required: true
property :auth_key_file, String, default: '/etc/tailscale/authkey.cnf'

action_class do
  include AcepHeadscale::TailscaleHelpers
end

action :install do
  apt_repository 'tailscale' do
    uri 'https://pkgs.tailscale.com/stable/ubuntu'
    key 'https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg'
    components ['main']
    action :add
  end

  package 'tailscale'
end

load_current_value do |new_resource|
  if ::File.exist?(new_resource.auth_key_file)
    auth_key IO.read(new_resource.auth_key_file)
  end
end

action :up do
  service 'tailscaled' do
    action [:enable, :start]
  end

  cmd = %w(tailscale up)

  directory '/etc/tailscale' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  converge_if_changed :auth_key, :force_reauth do
    IO.write(new_resource.auth_key_file, new_resource.auth_key)
    cmd.push('--authkey', new_resource.auth_key) if new_resource.auth_key
  end

  cmd.push('--accept-dns') if new_resource.accept_dns == 'true'
  cmd.push('--accept-routes') if new_resource.accept_routes == 'true'
  cmd.push('--advertise-routes', new_resource.advertise_routes.join(',')) if new_resource.advertise_routes&.any?
  cmd.push('--advertise-tags', new_resource.advertise_tags.join(',')) if new_resource.advertise_tags&.any?
  cmd.push('--force-reauth') if new_resource.force_reauth == 'true'
  cmd.push('--hostname', new_resource.hostname) if new_resource.hostname
  cmd.push('--login-server', new_resource.login_server) if new_resource.login_server
  cmd.push('--timeout', new_resource.timeout) if new_resource.timeout
  cmd.push('--reset') if new_resource.reset == 'true'
  cmd.push('--json')
  cmd.push('> /etc/tailscale/tailscale.json')

  execute 'tailscale-up' do
    command cmd.join(' ')
    action :run
    not_if { is_online? }
  end
end

action :down do
  execute 'tailscale-down' do
    command 'tailscale down'
    action :run
  end
end
