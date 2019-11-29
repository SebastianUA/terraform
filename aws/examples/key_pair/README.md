# Work with AWS key_pair via terraform

A terraform module for making AWS key_pair.

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~> 0.12.2"
}

provider "aws" {
    region                  = "us-east-1"
    profile                 = "epam-hulu"
    shared_credentials_file = pathexpand("/Users/captain/.aws/credentials")
}

module "key_pair" {
    source                      = "../../modules/key_pair"

    enable_key_pair             = true
    key_name                    = "test"
    public_key                  = file("/Users/captain/.ssh/id_rsa.pub")

}
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources (`default     = "TEST"`)
- `enable_key_pair` - Enable aws key_pair (`  default     = false`)
- `key_name` - (Optional) The name for the key pair (`  default     = ""`).
- `public_key` - (Required) The public key material (`  default     = ""`).
- `key_name_prefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with key_name. (`  default     = "key-"`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
