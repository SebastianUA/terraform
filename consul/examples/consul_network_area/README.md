# Work with CONSUL_NETWORK_AREA via terraform

A terraform module for making CONSUL_NETWORK_AREA.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"

  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.11.0"
    }
  }
}

provider "consul" {
  address    = "127.0.0.1:8500"
  scheme     = "http"
  datacenter = "dc1"

  ca_file        = null
  ca_pem         = null
  cert_file      = null
  cert_pem       = null
  key_file       = null
  key_pem        = null
  ca_path        = null
  http_auth      = null
  token          = null
  insecure_https = null
}

module "consul_network_area" {
  source = "../../modules/consul_network_area"

  enable_network_area          = true
  network_area_peer_datacenter = "dc2"
  network_area_retry_join      = ["1.2.3.4"]
  network_area_use_tls         = true
}

```

## Module Input Variables
----------------------
- `enable_network_area` - Enable network area for Consul usage (`default = False`)
- `network_area_peer_datacenter` - (Required) The name of the Consul datacenter that will be joined to form the area. (`default = null`)
- `network_area_retry_join` - (Optional) Specifies a list of Consul servers to attempt to join. Servers can be given as IP, IP:port, hostname, or hostname:port (`default = null`)
- `network_area_use_tls` - (Optional) Specifies whether gossip over this area should be encrypted with TLS if possible. Defaults to false. (`default = null`)
- `network_area_datacenter` - (Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup. (`default = null`)
- `network_area_token` - (Optional) The ACL token to use. This overrides the token that the agent provides by default. (`default = null`)

## Module Output Variables
----------------------
- `consul_network_area_id` - ID of Counsul network area


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
