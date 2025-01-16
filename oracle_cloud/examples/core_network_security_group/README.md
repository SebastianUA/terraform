# Work with CORE_NETWORK_SECURITY_GROUP via terraform

A terraform module for making CORE_NETWORK_SECURITY_GROUP.


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
    oci = {
      source  = "oracle/oci"
      version = "6.21.0"
    }
  }
}

provider "oci" {
  fingerprint      = var.provider_oci_fingerprint
  private_key_path = var.provider_oci_private_key_path
  region           = var.provider_oci_region
  tenancy_ocid     = var.provider_oci_tenancy_ocid
  user_ocid        = var.provider_oci_user_ocid
  alias            = var.provider_oci_alias
}

module "core_network_security_group" {
  source = "../../modules/core_network_security_group"

  enable_core_network_security_group         = true
  core_network_security_group_compartment_id = ""
  core_network_security_group_vcn_id         = ""

  core_network_security_group_display_name = ""

  tags = {}
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_core_network_security_group` - Enable core network security group usages (`default = null`)
- `core_network_security_group_compartment_id` - (Required) (Updatable) The OCID of the compartment to contain the network security group. (`default = null`)
- `core_network_security_group_vcn_id` - (Required) The OCID of the VCN to create the network security group in. (`default = null`)
- `core_network_security_group_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_network_security_group_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_network_security_group_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Security Group * update - (Defaults to 20 minutes), when updating the Network Security Group * delete - (Defaults to 20 minutes), when destroying the Network Security Group (`default = {}`)
- `enable_core_network_security_group_security_rule` - Enable core network security group security rule usages (`default = False`)
- `core_network_security_group_security_rule_network_security_group_id` - The OCID of the network security group. (`default = ""`)
- `core_network_security_group_security_rule_direction` - (Required) Direction of the security rule. Set to EGRESS for rules to allow outbound IP packets, or INGRESS for rules to allow inbound IP packets. (`default = null`)
- `core_network_security_group_security_rule_protocol` - (Required) The transport protocol. Specify either all or an IPv4 protocol number as defined in Protocol Numbers. Options are supported only for ICMP ('1'), TCP ('6'), UDP ('17'), and ICMPv6 ('58'). (`default = null`)
- `core_network_security_group_security_rule_description` - (Optional) An optional description of your choice for the rule. Avoid entering confidential information. (`default = null`)
- `core_network_security_group_security_rule_destination` - (Optional) Conceptually, this is the range of IP addresses that a packet originating from the instance can go to. (`default = null`)
- `core_network_security_group_security_rule_destination_type` - (Optional) Type of destination for the rule. Required if direction = EGRESS. (`default = null`)
- `core_network_security_group_security_rule_source` - (Optional) Conceptually, this is the range of IP addresses that a packet coming into the instance can come from. (`default = null`)
- `core_network_security_group_security_rule_source_type` - (Optional) Type of source for the rule. Required if direction = INGRESS. (`default = null`)
- `core_network_security_group_security_rule_stateless` - (Optional) A stateless rule allows traffic in one direction. Remember to add a corresponding stateless rule in the other direction if you need to support bidirectional traffic. For example, if egress traffic allows TCP destination port 80, there should be an ingress rule to allow TCP source port 80. Defaults to false, which means the rule is stateful and a corresponding rule is not necessary for bidirectional traffic. (`default = null`)
- `core_network_security_group_security_rule_icmp_options` - (Optional) Optional and valid only for ICMP and ICMPv6. Use to specify a particular ICMP type and code (`default = []`)
- `core_network_security_group_security_rule_tcp_options` - (Optional) Optional and valid only for TCP. Use to specify particular destination ports for TCP rules. If you specify TCP as the protocol but omit this object, then all destination ports are allowed. (`default = []`)
- `core_network_security_group_security_rule_udp_options` - (Optional) Optional and valid only for UDP. Use to specify particular destination ports for UDP rules. If you specify UDP as the protocol but omit this object, then all destination ports are allowed. (`default = null`)
- `core_network_security_group_security_rule_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Security Group Security Rule * update - (Defaults to 20 minutes), when updating the Network Security Group Security Rule * delete - (Defaults to 20 minutes), when destroying the Network Security Group Security Rule (`default = {}`)

## Module Output Variables
----------------------
- `core_network_security_group_compartment_id` - The OCID of the compartment the network security group is in.
- `core_network_security_group_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_network_security_group_id` - The OCID of the network security group.
- `core_network_security_group_state` - The network security group's current state.
- `core_network_security_group_time_created` - The date and time the network security group was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_network_security_group_vcn_id` - The OCID of the network security group's VCN.
- `core_network_security_group_security_rule_udp_options` - Optional and valid only for UDP. Use to specify particular destination ports for UDP rules. If you specify UDP as the protocol but omit this object, then all destination ports are allowed.
- `core_network_security_group_security_rule_time_created` - The date and time the security rule was created. Format defined by RFC3339.
- `core_network_security_group_security_rule_stateless` - A stateless rule allows traffic in one direction. Remember to add a corresponding stateless rule in the other direction if you need to support bidirectional traffic. For example, if egress traffic allows TCP destination port 80, there should be an ingress rule to allow TCP source port 80. Defaults to false, which means the rule is stateful and a corresponding rule is not necessary for bidirectional traffic.
- `core_network_security_group_security_rule_tcp_options` - Optional and valid only for TCP. Use to specify particular destination ports for TCP rules. If you specify TCP as the protocol but omit this object, then all destination ports are allowed.
- `core_network_security_group_security_rule_source_type` - Type of source for the rule. Required if direction = INGRESS.
- `core_network_security_group_security_rule_id` - An Oracle-assigned identifier for the security rule. You specify this ID when you want to update or delete the rule. Example: 04ABEC
- `core_network_security_group_security_rule_is_valid` - Whether the rule is valid. The value is True when the rule is first created. If the rule's source or destination is a network security group, the value changes to False if that network security group is deleted.
- `core_network_security_group_security_rule_protocol` - The transport protocol. Specify either all or an IPv4 protocol number as defined in Protocol Numbers. Options are supported only for ICMP ('1'), TCP ('6'), UDP ('17'), and ICMPv6 ('58').
- `core_network_security_group_security_rule_source` - Conceptually, this is the range of IP addresses that a packet coming into the instance can come from.
- `core_network_security_group_security_rule_direction` - Direction of the security rule. Set to EGRESS for rules to allow outbound IP packets, or INGRESS for rules to allow inbound IP packets.
- `core_network_security_group_security_rule_icmp_options` - Optional and valid only for ICMP and ICMPv6. Use to specify a particular ICMP type and code
- `core_network_security_group_security_rule_destination_type` - Type of destination for the rule. Required if direction = EGRESS.
- `core_network_security_group_security_rule_description` - An optional description of your choice for the rule.
- `core_network_security_group_security_rule_destination` - Conceptually, this is the range of IP addresses that a packet originating from the instance can go to.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
