# Work with KEY_PAIR via terraform

A terraform module for making KEY_PAIR.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("/Users/captain/.aws/credentials")
}

module "key_pair_name" {
  source = "../../modules/key_pair"

  enable_key_pair          = true
  key_pair_key_name        = "test"
  key_pair_key_name_prefix = null
  key_pair_public_key      = file("/Users/captain/.ssh/id_rsa.pub")

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "key_pair_prefix" {
  source = "../../modules/key_pair"

  enable_key_pair          = true
  key_pair_key_name_prefix = "kp-"
  key_pair_public_key      = file("/Users/captain/.ssh/id_rsa.pub")

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources (`default = TEST`)
- `tags` - A list of tag blocks. Each element should have keys (`default = {}`)
- `enable_key_pair` - Enable aws key_pair (`default = False`)
- `key_pair_public_key` - (Required) The public key material. (`default = ""`)
- `key_pair_key_name` - (Optional) The name for the key pair. (`default = ""`)
- `key_pair_key_name_prefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with key_name. (`default = null`)

## Module Output Variables
----------------------
- `aws_key_name` - The key pair name.
- `aws_key_id` - The key pair id.
- `aws_key_fingerprint` - The MD5 public key fingerprint as specified in section 4 of RFC 4716.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
