# Work with AWS SG via terraform

A terraform module for making SG.


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

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "sg" {
  source      = "../../modules/sg"
  name        = "test"
  environment = "dev"

  enable_security_group = true
  security_group_name   = "my-test-sg-here"
  security_group_vpc_id = "vpc-07a6b45ca3c842212"

  # Using ingress
  enable_sg_rule_ingress_ports     = true
  enable_sg_rule_ingress_ports_all = false

  # Using egress
  enable_sg_rule_egress_ports     = false
  enable_sg_rule_egress_ports_all = true

  allowed_ports = ["22", "7199"]
  cidr_blocks = {
    "22" = [
      "159.224.217.0/24",
      "10.0.0.0/8",
      "172.16.0.0/12",
      "1.2.3.4/32",
      "4.3.2.1/32"
    ],
    "7199" = [
      "10.0.0.0/8",
      "172.16.0.0/12"
    ],
  }

  # Using custom SG rule
  enable_sg_rule_custom_ports = true
  custom_ports_type           = "ingress"
  custom_ports_protocol       = "icmp"
  custom_ports_from_port      = -1
  custom_ports_to_port        = -1
  custom_ports_self           = true
  #custom_ports_source_security_group_id   = "sg-aed75fe1"
  custom_ports_description = "Allow ICMP pkgs"
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. (`default = ""`)
- `enable_security_group` - Enable SG usage (`default = ""`)
- `security_group_name` - (Optional, Forces new resource) The name of the security group. If omitted, Terraform will assign a random, unique name (`default = ""`)
- `security_group_name_prefix` - (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with security_group_name. (`default = ""`)
- `security_group_description` - (Optional, Forces new resource) The security group description. Defaults to 'Managed by Terraform'. Cannot be ''. NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags. (`default = Managed by Terraform`)
- `security_group_vpc_id` - (Optional, Forces new resource) The VPC ID. (`default = null`)
- `security_group_revoke_rules_on_delete` - (Optional) Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed, however certain AWS services such as Elastic Map Reduce may automatically add required rules to security groups used with the service, and those rules may contain a cyclic dependency that prevent the security groups from being destroyed without removing the dependency first. Default false (`default = ""`)
- `security_group_ingress` - (Optional) Can be specified multiple times for each ingress rule. Each ingress block supports fields documented below. This argument is processed in attribute-as-blocks mode. (`default = ""`)
- `security_group_egress` - (Optional, VPC only) Can be specified multiple times for each egress rule. Each egress block supports fields documented below. This argument is processed in attribute-as-blocks mode. (`default = ""`)
- `security_group_id` - The security group to apply this rule to. (`default = ""`)
- `allowed_ports` - Allowed ports from/to host (`default = ""`)
- `cidr_blocks` - (Optional) List of CIDR blocks. Cannot be specified with source_security_group_id. (`default = null`)
- `enable_sg_rule_ingress_ports` - Enable SG rule with ingress ports usage (`default = ""`)
- `ingress_ports_from_port` - The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6'). (`default = null`)
- `ingress_ports_to_port` - The end port (or ICMP code if protocol is 'icmp'). (`default = null`)
- `ingress_ports_protocol` - (Required) The protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number (`default = tcp`)
- `ingress_ports_ipv6_cidr_blocks` - (Optional) List of IPv6 CIDR blocks. (`default = null`)
- `ingress_ports_source_security_group_id` - (Optional) The security group id to allow access to/from, depending on the type. Cannot be specified with ingress_ports_ipv6_cidr_blocks and ingress_ports_self. (`default = null`)
- `ingress_ports_self` - (Optional) If true, the security group itself will be added as a source to this ingress rule. Cannot be specified with ingress_ports_source_security_group_id. (`default = null`)
- `ingress_ports_description` - (Optional) Description of the rule. (`default = null`)
- `enable_sg_rule_egress_ports` - Enable SG rule with egress ports usage (`default = ""`)
- `egress_ports_from_port` - The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6'). (`default = null`)
- `egress_ports_to_port` - The end port (or ICMP code if protocol is 'icmp'). (`default = null`)
- `egress_ports_protocol` - (Required) The protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number (`default = tcp`)
- `egress_ports_ipv6_cidr_blocks` - (Optional) List of IPv6 CIDR blocks. (`default = null`)
- `egress_ports_source_security_group_id` - (Optional) The security group id to allow access to/from, depending on the type. Cannot be specified with egress_ports_ipv6_cidr_blocks and egress_ports_self. (`default = null`)
- `egress_ports_self` - (Optional) If true, the security group itself will be added as a source to this ingress rule. Cannot be specified with egress_ports_source_security_group_id. (`default = null`)
- `egress_ports_description` - (Optional) Description of the rule. (`default = null`)
- `enable_sg_rule_custom_ports` - Enable SG rule for custom ports usage (`default = ""`)
- `custom_ports_type` - (Required) The type of rule being created. Valid options are ingress (inbound) or egress (outbound). (`default = ingress`)
- `custom_ports_from_port` - (Required) The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6'). (`default = -1`)
- `custom_ports_to_port` - (Required) The end port (or ICMP code if protocol is 'icmp'). (`default = -1`)
- `custom_ports_protocol` - (Required) The protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number (`default = icmp`)
- `custom_ports_cidr_blocks` - (Optional) List of CIDR blocks. Cannot be specified with custom_ports_source_security_group_id. (`default = null`)
- `custom_ports_ipv6_cidr_blocks` - (Optional) List of IPv6 CIDR blocks. (`default = null`)
- `custom_ports_source_security_group_id` - (Optional) The security group id to allow access to/from, depending on the type. Cannot be specified with custom_ports_ipv6_cidr_blocks and custom_ports_self. (`default = null`)
- `custom_ports_self` - (Optional) If true, the security group itself will be added as a source to this ingress rule. Cannot be specified with custom_ports_source_security_group_id. (`default = null`)
- `custom_ports_description` - (Optional) Description of the rule. (`default = null`)
- `enable_sg_rule_ingress_ports_all` - Enable SG rule with ingress to open all ports usage (`default = ""`)
- `enable_sg_rule_egress_ports_all` - Enable SG rule with egress to open all ports usage (`default = ""`)

## Module Output Variables
----------------------


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
