# Chef InSpec test for recipe acep-headscale::client

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe package('tailscale') do
  it { should be_installed }
end
