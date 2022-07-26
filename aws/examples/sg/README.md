# Work with SG via terraform

A terraform module for making SG.


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
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "sg_default" {
  source      = "../../modules/sg"
  name        = "test"
  environment = "dev"

  enable_default_security_group = true
  default_security_group_name   = "default"
  default_security_group_vpc_id = "vpc-0ea8873ab2bf7900d"


  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "sg" {
  source      = "../../modules/sg"
  name        = "test"
  environment = "dev"

  enable_security_group = true
  security_group_name   = "my-test-sg-here"
  security_group_vpc_id = "vpc-0ea8873ab2bf7900d"


  security_group_ingress = [
    {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"

      cidr_blocks      = null
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      description      = "TLS from VPC"
      security_groups  = null
      self             = null
    },
    {
      from_port = 80
      to_port   = 80
      protocol  = "http"

      cidr_blocks      = null
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      description      = "HTTP from VPC"
      security_groups  = null
      self             = null
    }
  ]


  security_group_egress = [
    {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"

      cidr_blocks      = null
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      description      = "TLS to VPC"
      security_groups  = null
      self             = null
    },
    {
      from_port = 80
      to_port   = 80
      protocol  = "http"

      cidr_blocks      = null
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      description      = "HTTP from VPC"
      security_groups  = null
      self             = null
    }
  ]

  # Using sg rule (ingress)
  enable_sg_rule_ingress_ports = true

  ingress_ports_stack = [
    {
      from_port   = 444
      to_port     = 444
      protocol    = "tcp"
      description = "444"
    },
    {
      from_port   = 445
      to_port     = 445
      protocol    = "tcp"
      description = "445"
    }
  ]

  # Using sg rule (egress)
  enable_sg_rule_egress_ports = true

  egress_ports_stack = [
    {
      from_port   = 444
      to_port     = 444
      protocol    = "tcp"
      description = "444"
    },
    {
      from_port   = 445
      to_port     = 445
      protocol    = "tcp"
      description = "445"
    }
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}


module "sg_allow_all" {
  source      = "../../modules/sg"
  name        = "test"
  environment = "dev"

  enable_security_group = true
  security_group_name   = "sg-allow-all"
  security_group_vpc_id = "vpc-0ea8873ab2bf7900d"

  # Using ingress
  enable_sg_rule_ingress_ports_all = true
  enable_sg_rule_egress_ports_all  = true

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. (`default = {}`)
- `enable_security_group` - Enable SG usage (`default = False`)
- `security_group_name` - (Optional, Forces new resource) The name of the security group. If omitted, Terraform will assign a random, unique name (`default = ""`)
- `security_group_name_prefix` - (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with security_group_name. (`default = ""`)
- `security_group_description` - (Optional, Forces new resource) The security group description. Defaults to 'Managed by Terraform'. Cannot be ''. NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags. (`default = Managed by Terraform`)
- `security_group_vpc_id` - (Optional, Forces new resource) The VPC ID. (`default = null`)
- `security_group_revoke_rules_on_delete` - (Optional) Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed, however certain AWS services such as Elastic Map Reduce may automatically add required rules to security groups used with the service, and those rules may contain a cyclic dependency that prevent the security groups from being destroyed without removing the dependency first. Default false (`default = False`)
- `security_group_ingress` - (Optional) Can be specified multiple times for each ingress rule. Each ingress block supports fields documented below. This argument is processed in attribute-as-blocks mode. (`default = []`)
- `security_group_egress` - (Optional, VPC only) Can be specified multiple times for each egress rule. Each egress block supports fields documented below. This argument is processed in attribute-as-blocks mode. (`default = []`)
- `security_group_timeouts` - (Optional, allowing add custom timeouts for VPC (`default = {}`)
- `enable_sg_rule_ingress_ports` - Enable SG rule with ingress ports usage (`default = False`)
- `ingress_ports_stack` - Set list of the values for ingress (`default = []`)
- `enable_sg_rule_egress_ports` - Enable SG rule with egress ports usage (`default = False`)
- `egress_ports_stack` - Set list of the values for engress (`default = []`)
- `enable_sg_rule_ingress_ports_all` - Enable SG rule with ingress to open all ports usage (`default = False`)
- `ingress_ports_all_stack` - Set list of the values for engress (`default = [{'from_port': 0, 'to_port': 0, 'protocol': '${-1}', 'cidr_blocks': None, 'prefix_list_ids': None, 'ipv6_cidr_blocks': None, 'source_security_group_id': None, 'self': None, 'description': None}]`)
- `enable_sg_rule_egress_ports_all` - Enable SG rule with egress to open all ports usage (`default = False`)
- `egress_ports_all_stack` - Set list of the values for engress (`default = [{'from_port': 0, 'to_port': 0, 'protocol': '${-1}', 'cidr_blocks': None, 'prefix_list_ids': None, 'ipv6_cidr_blocks': None, 'source_security_group_id': None, 'self': None, 'description': None}]`)
- `enable_default_security_group` - Enable default security group usage (`default = False`)
- `default_security_group_name` - Set name for default SG (`default = ""`)
- `default_security_group_vpc_id` - (Optional, Forces new resource) VPC ID. Note that changing the vpc_id will not restore any default security group rules that were modified, added, or removed. It will be left in its current state. (`default = ""`)
- `default_security_group_ingress` - (Optional) Configuration block. (`default = {'protocol': '${-1}', 'from_port': 0, 'to_port': 0, 'cidr_blocks': ['0.0.0.0/0'], 'ipv6_cidr_blocks': ['::/0'], 'description': 'Default Inbound rules', 'prefix_list_ids': None, 'security_groups': None, 'self': None}`)
- `default_security_group_egress` - (Optional, VPC only) Configuration block.  (`default = {'protocol': '${-1}', 'from_port': 0, 'to_port': 0, 'cidr_blocks': ['0.0.0.0/0'], 'ipv6_cidr_blocks': ['::/0'], 'description': 'Default Outbound rules', 'prefix_list_ids': None, 'security_groups': None, 'self': None}`)

## Module Output Variables
----------------------
- `security_group_id` - The ID of the security group
- `security_group_arn` - The ARN of the security group
- `security_group_vpc_id` - The VPC ID.
- `security_group_owner_id` - The owner ID.
- `security_group_name` - The name of the security group
- `security_group_description` - The description of the security group
- `security_group_ingress` - The ingress rules. See above for more.
- `security_group_egress` - The egress rules. See above for more.
- `security_group_rule_id` - The ID of the security group rules
- `security_group_rule_type` - The type of rule, ingress or egress
- `security_group_rule_from_port` - The start port (or ICMP type number if protocol is 'icmp')
- `security_group_rule_to_port` - The end port (or ICMP code if protocol is 'icmp')
- `security_group_rule_protocol` - The protocol used
- `security_group_rule_description` - Description of the rule
- `default_security_group_id` - ID of the security group.
- `default_security_group_arn` - ARN of the security group.
- `default_security_group_description` - Description of the security group.
- `default_security_group_name` - Name of the security group.
- `default_security_group_owner_id` - Owner ID.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
