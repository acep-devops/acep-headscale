# acep-headscale

Basic cookbook for setting up headscale server

## Requirements

### Platforms
* Debian-family Linux Distributions

### Chef
* Chef 16+

## Attributes

* `headscale[package_source]` - URL for deb pkg to download
* `headscale[package_checksum]` - Checksum of the package source
* `headscale[server_url]` - Server url for the headscale instance
* `headscale[listen_addr]` - Listen address used by headscale instance
* `headscale[grpc_listen_addr]` - Listen address for grpc connections