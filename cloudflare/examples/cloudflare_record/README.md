# Work with CLOUDFLARE_RECORD via terraform

A terraform module for making CLOUDFLARE_RECORD.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}

provider "cloudflare" {
  email   = "email-here"
  api_key = "api-key-here"
}

module "cloudflare_record" {
  source = "../../modules/cloudflare_record"
  #name                            = "cloudflare_record"

  enable_record = true

  #record_value                    = "192.168.0.11"

  record_data = {
    service  = "_sip"
    proto    = "_tls"
    name     = "terraform-srv"
    priority = 0
    weight   = 0
    port     = 443
    target   = "linux-notes.org"
  }
}

```

## Module Input Variables
----------------------
- `enable_record` - Enable cloudflare record usage (`default = False`)
- `record_name` - The name of the record (`default = cloudflare_name`)
- `record_zone_id` - (Required) The DNS zone ID to add the record to (`default = ""`)
- `record_type` - The type of the record (`default = A`)
- `record_value` - The value of the record. Ex: 192.168.13.113 (`default = null`)
- `record_data` - description (`default = null`)
- `record_ttl` - The TTL of the record (`default = 3600`)
- `record_priority` - The priority of the record (`default = 1`)
- `record_proxied` - Whether the record gets Cloudflare's origin protection. (`default = False`)

## Module Output Variables
----------------------
- `record_id` - ""
- `record_name` - ""
- `record_value` - ""
- `record_type` - ""
- `record_ttls` - ""
- `record_prioritys` - ""
- `record_hostnames` - ""
- `record_proxieds` - ""


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
