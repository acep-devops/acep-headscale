# Chef InSpec test for recipe acep-headscale::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe service('headscale') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(8080) do
  it { should be_listening }
end

describe file('/etc/headscale/acls.json') do
  it { should exist }
  its('content') { should match 'group:infra' }
end
