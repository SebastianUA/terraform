# Work with AWS VPC via terraform

A terraform module for making VPC.

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region  = "us-east-1"
    # alias = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
}

module "sg" {
    source                              = "../../modules/sg"
    name                                = "Bastion_Ukraine"
    environment                         = "PROD"


    enable_sg_creating                  = true
    vpc_id                              = "vpc-09f1d36e"
    enable_all_egress_ports             = "true"
    allowed_ports                       = ["22"]
    allow_cidrs_for_allowed_ports       = {
        #
        # Vitalii.Natarov's home IP - 159.224.217.0/24
        #
        "22" = [
            "159.224.217.0/24",
        ]
    }
}

```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix" (`default = "TEST"`).
- `environment` - Environment for service (`default = stage`). Just uses for tag.
- `orchestration` - Type of orchestration (`default = Terraform`). Just uses for tag.
- `createdby` - Created by (`default = Vitaliy Natarov`). Just uses for tag.
- `allowed_ports` - Allowed ports from/to host.
- `enable_all_egress_ports` - Allows all ports from host (`default = false`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
