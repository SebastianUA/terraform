#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "sg" {
    source                                  = "../../modules/sg"
    name                                    = "test"
    environment                             = "dev"

    enable_security_group                   = true
    security_group_name                     = "my-test-sg-here"
    security_group_vpc_id                   = "vpc-07a6b45ca3c842212"

    # Using ingress
    enable_sg_rule_ingress_ports            = true
    enable_sg_rule_ingress_ports_all        = false

    # Using egress
    enable_sg_rule_egress_ports             = false
    enable_sg_rule_egress_ports_all         = true

    allowed_ports                           = ["22", "7199"]
    cidr_blocks                             = {
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
    enable_sg_rule_custom_ports             = true
    custom_ports_type                       = "ingress"
    custom_ports_protocol                   = "icmp"
    custom_ports_from_port                  = -1
    custom_ports_to_port                    = -1
    custom_ports_self                       = true
    #custom_ports_source_security_group_id   = "sg-aed75fe1"
    custom_ports_description                = "Allow ICMP pkgs"
}
