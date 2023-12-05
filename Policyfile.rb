# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

# A name that describes what the system you're building with Chef does.
name 'acep-headscale'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'acep-headscale::default'

# Specify a custom source for a single cookbook:
cookbook 'acep-headscale', path: '.'

include_policy 'acep-devops-base', policy_group: 'dev', server: 'https://chef.io.alaska.edu/organizations/acep-devops'