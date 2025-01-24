# Work with CORE_VIRTUAL_CIRCUIT via terraform

A terraform module for making CORE_VIRTUAL_CIRCUIT.


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
  # config_file = var.provider_oci_config_file
  # profile     = var.provider_oci_profile

  fingerprint      = var.provider_oci_fingerprint
  private_key_path = var.provider_oci_private_key_path
  region           = var.provider_oci_region
  tenancy_ocid     = var.provider_oci_tenancy_ocid
  user_ocid        = var.provider_oci_user_ocid
}

module "core_virtual_circuit" {
  source = "../../modules/core_virtual_circuit"

  enable_core_virtual_circuit         = true
  core_virtual_circuit_compartment_id = ""
  core_virtual_circuit_type           = ""

  tags = {}
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_core_virtual_circuit` - Enable core virtual circuit usages (`default = False`)
- `core_virtual_circuit_compartment_id` - (Required) (Updatable) The OCID of the compartment to contain the virtual circuit. (`default = null`)
- `core_virtual_circuit_type` - (Required) The type of IP addresses used in this virtual circuit. PRIVATE means RFC 1918 addresses (10.0.0.0/8, 172.16/12, and 192.168/16). (`default = null`)
- `core_virtual_circuit_bandwidth_shape_name` - (Optional) (Updatable) The provisioned data rate of the connection. To get a list of the available bandwidth levels (that is, shapes), see ListFastConnectProviderServiceVirtualCircuitBandwidthShapes. Example: 10 Gbps (`default = null`)
- `core_virtual_circuit_bgp_admin_state` - (Optional) (Updatable) Set to ENABLED (the default) to activate the BGP session of the virtual circuit, set to DISABLED to deactivate the virtual circuit. (`default = null`)
- `core_virtual_circuit_cross_connect_mappings` - Optional) (Updatable) Create a CrossConnectMapping for each cross-connect or cross-connect group this virtual circuit will run on. (`default = []`)
- `core_virtual_circuit_customer_asn` - (Optional) (Updatable) Your BGP ASN (either public or private). Provide this value only if there's a BGP session that goes from your edge router to Oracle. Otherwise, leave this empty or null. Can be a 2-byte or 4-byte ASN. Uses 'asplain' format. Example: 12345 (2-byte) or 1587232876 (4-byte) (`default = null`)
- `core_virtual_circuit_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_virtual_circuit_ip_mtu` - (Optional) (Updatable) The layer 3 IP MTU to use with this virtual circuit. (`default = null`)
- `core_virtual_circuit_is_bfd_enabled` - (Optional) (Updatable) Set to true to enable BFD for IPv4 BGP peering, or set to false to disable BFD. If this is not set, the default is false. (`default = null`)
- `core_virtual_circuit_is_transport_mode` - (Optional) (Updatable) Set to true for the virtual circuit to carry only encrypted traffic, or set to false for the virtual circuit to carry unencrypted traffic. If this is not set, the default is false. (`default = null`)
- `core_virtual_circuit_gateway_id` - (Optional) (Updatable) For private virtual circuits only. The OCID of the dynamic routing gateway (DRG) that this virtual circuit uses. (`default = null`)
- `core_virtual_circuit_provider_service_id` - (Optional) The OCID of the service offered by the provider (if you're connecting via a provider). To get a list of the available service offerings, see ListFastConnectProviderServices. (`default = null`)
- `core_virtual_circuit_provider_service_key_name` - (Optional) (Updatable) The service key name offered by the provider (if the customer is connecting via a provider). (`default = null`)
- `core_virtual_circuit_region` - (Optional) The Oracle Cloud Infrastructure region where this virtual circuit is located. Example: phx (`default = null`)
- `core_virtual_circuit_routing_policy` - (Optional) (Updatable) The routing policy sets how routing information about the Oracle cloud is shared over a public virtual circuit. Policies available are: ORACLE_SERVICE_NETWORK, REGIONAL, MARKET_LEVEL, and GLOBAL. See Route Filtering for details. By default, routing information is shared for all routes in the same market. (`default = null`)
- `core_virtual_circuit_public_prefixes` - (Optional) (Updatable) For a public virtual circuit. The public IP prefixes (CIDRs) the customer wants to advertise across the connection. (`default = []`)
- `core_virtual_circuit_defined_tags` - (Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_virtual_circuit_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Virtual Circuit * update - (Defaults to 20 minutes), when updating the Virtual Circuit * delete - (Defaults to 20 minutes), when destroying the Virtual Circuit (`default = {}`)

## Module Output Variables
----------------------
- `core_virtual_circuit_bandwidth_shape_name` - The provisioned data rate of the connection. To get a list of the available bandwidth levels (that is, shapes)
- `core_virtual_circuit_bgp_admin_state` - Set to ENABLED (the default) to activate the BGP session of the virtual circuit, set to DISABLED to deactivate the virtual circuit.
- `core_virtual_circuit_bgp_ipv6session_state` - The state of the Ipv6 BGP session associated with the virtual circuit.
- `core_virtual_circuit_bgp_session_state` - The state of the Ipv4 BGP session associated with the virtual circuit.
- `core_virtual_circuit_compartment_id` - The OCID of the compartment containing the virtual circuit.
- `core_virtual_circuit_cross_connect_mappings` - An array of mappings, each containing properties for a cross-connect or cross-connect group that is associated with this virtual circuit.
- `core_virtual_circuit_customer_asn` - The BGP ASN of the network at the other end of the BGP session from Oracle. If the session is between the customer's edge router and Oracle, the value is the customer's ASN. If the BGP session is between the provider's edge router and Oracle, the value is the provider's ASN. Can be a 2-byte or 4-byte ASN. Uses 'asplain' format.
- `core_virtual_circuit_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_virtual_circuit_gateway_id` - The OCID of the customer's dynamic routing gateway (DRG) that this virtual circuit uses. Applicable only to private virtual circuits.
- `core_virtual_circuit_id` - The virtual circuit's Oracle ID (OCID).
- `core_virtual_circuit_ip_mtu` - The layer 3 IP MTU to use on this virtual circuit.
- `core_virtual_circuit_is_bfd_enabled` - Set to true to enable BFD for IPv4 BGP peering, or set to false to disable BFD. If this is not set, the default is false.
- `core_virtual_circuit_is_transport_mode` - Set to true for the virtual circuit to carry only encrypted traffic, or set to false for the virtual circuit to carry unencrypted traffic. If this is not set, the default is false.
- `core_virtual_circuit_oracle_bgp_asn` - The Oracle BGP ASN.
- `core_virtual_circuit_provider_service_id` - The OCID of the service offered by the provider (if the customer is connecting via a provider).
- `core_virtual_circuit_provider_service_key_name` - The service key name offered by the provider (if the customer is connecting via a provider).
- `core_virtual_circuit_provider_state` - The provider's state in relation to this virtual circuit (if the customer is connecting via a provider). ACTIVE means the provider has provisioned the virtual circuit from their end. INACTIVE means the provider has not yet provisioned the virtual circuit, or has de-provisioned it.
- `core_virtual_circuit_public_prefixes` - For a public virtual circuit. The public IP prefixes (CIDRs) the customer wants to advertise across the connection. All prefix sizes are allowed.
- `core_virtual_circuit_reference_comment` - Provider-supplied reference information about this virtual circuit (if the customer is connecting via a provider).
- `core_virtual_circuit_region` - The Oracle Cloud Infrastructure region where this virtual circuit is located.
- `core_virtual_circuit_routing_policy` - The routing policy sets how routing information about the Oracle cloud is shared over a public virtual circuit. Policies available are: ORACLE_SERVICE_NETWORK, REGIONAL, MARKET_LEVEL, and GLOBAL. See Route Filtering for details. By default, routing information is shared for all routes in the same market.
- `core_virtual_circuit_service_type` - Provider service type.
- `core_virtual_circuit_state` - The virtual circuit's current state. For information about the different states, see FastConnect Overview.
- `core_virtual_circuit_type` - Whether the virtual circuit supports private or public peering. For more information, see FastConnect Overview.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
