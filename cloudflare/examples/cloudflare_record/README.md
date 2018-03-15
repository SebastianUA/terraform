# Work with cloudflare records via terraform

A terraform module for making cloudflare records.
 
## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "cloudflare" {
    email = ""
    token = ""
}
module "cloudflare_record" {
    source                          = "../../modules/cloudflare_record"
    name                            = "cloudflare_record"
}
```

Module Input Variables
----------------------
- `name` - The name of the record (`default     = "cloudflare_name"`).
- `domain` - The domain to add the record to (`default     = ""`).
- `value` - The value of the record. Ex: 192.168.13.113 (`default     = ""`).
- `type` - The type of the record (`default     = "A"`).
- `ttl` - The TTL of the record (`default     = 3600`).
- `priority` - The priority of the record (`default     = "1"`).
- `proxied` - Whether the record gets Cloudflare's origin protection (`default     = ""`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.

