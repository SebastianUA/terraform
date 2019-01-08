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
  required_version = ">= 0.11.11"
}
provider "aws" {
    region  = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
}

module "sg" {
    source                              = "../../modules/sg"
    name                                = "test"
    environment                         = "NonPROD"

    enable_sg_creating                  = true
    vpc_id                              = "vpc-0d0d22629db6d471d"
    enable_all_egress_ports             = true
    allowed_ports                       = ["22", "7199", "7000", "7001", "9160", "9042"]
    allow_cidrs_for_allowed_ports       = {
        "22" = [
            "159.224.217.0/24",
            "10.0.0.0/8",
            "172.16.0.0/12"
        ],
        "7199" = [
            "10.0.0.0/8",
            "172.16.0.0/12"
        ],
        "7000" = [
            "10.0.0.0/8",
            "172.16.0.0/12"
        ],
        "7001" = [
            "10.0.0.0/8",
            "172.16.0.0/12"
        ],
        "9160" = [
            "10.0.0.0/8",
            "172.16.0.0/12"
        ],
        "9042" = [
            "10.0.0.0/8",
            "172.16.0.0/12"
        ]
    }


}

```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (default     = "TEST-SG").
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `vpc_id` - VPC ID (`default     = ""`).
- `enable_sg_creating` -  Enable to create SG for VPC (`default     = true`).
- `allowed_ports` - Allowed ports from/to host (`default     = []`).
- `allow_cidrs_for_allowed_ports` - Set allowed cidrs for allowed_ports (`default     = {
        "80"        = ["0.0.0.0/0"]
        "443"       = ["0.0.0.0/0"]
    }`)
- `enable_all_egress_ports` - Allows all ports from host (`default     = false`).
- `enable_custom_sg_rule_with_cidr_blocks` - Allows create a custom sg rule with cidr_blocks usage (`default     = false`).
- `enable_custom_sg_rule_with_self` - Allows create a custom sg rule with self usage (`default     = false`).
- `sg_rule_type` - (`default     = "ingress"`).
- `sg_rule_from_port` - (`default     = "0"`).
- `sg_rule_to_port` - (`default     = "0"`).
- `sg_rule_protocol` - (`default     = "-1"`).
- `sg_rule_cidr_blocks` - (`default     =["0.0.0.0/0"]`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
