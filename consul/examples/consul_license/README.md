# Work with CONSUL_LICENSE via terraform

A terraform module for making CONSUL_LICENSE.


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

module "consul_license" {
  source = "../../modules/consul_license"

  enable_license     = true
  license            = file("additional_files/license.hclic")
  license_datacenter = "dc2"
}

```

## Module Input Variables
----------------------
- `enable_license` - Enable license for Consul usage (`default = False`)
- `license` - (Required) The Consul license to use. (`default = null`)
- `license_datacenter` - (Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup. (`default = null`)

## Module Output Variables
----------------------
- `consul_license_id` - ID of Counsul license
- `consul_license_valid` - Whether the license is valid.
- `consul_license_license_id` - The ID of the license used.
- `consul_license_customer_id` - The ID of the customer the license is attached to.
- `consul_license_installation_id` - The ID of the current installation.
- `consul_license_issue_time` - The date the license was issued.
- `consul_license_start_time` - The start time of the license.
- `consul_license_expiration_time` - The expiration time of the license.
- `consul_license_product` - The product for which the license is valid.
- `consul_license_features` - The features for which the license is valid.
- `consul_license_warnings` - A list of warning messages regarding the license validity.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
