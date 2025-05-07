# Work with NETWORK_FIREWALL via terraform

A terraform module for making NETWORK_FIREWALL.


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

module "network_firewall" {
  source = "../../modules/network_firewall"

}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `compartment_id` - (Required) (Updatable) The OCID of the compartment to (`default = null`)
- `tags` - Add additional tags (`default = {}`)
- `enable_network_firewall_network_firewall` - Enable network firewall network firewall usages (`default = False`)
- `network_firewall_network_firewall_network_firewall_policy_id` - (Required) (Updatable) The OCID of the compartment containing the Network Firewall. (`default = ""`)
- `network_firewall_network_firewall_subnet_id` - (Required) The OCID of the subnet associated with the Network Firewall. (`default = null`)
- `network_firewall_network_firewall_availability_domain` - (Optional) Availability Domain where Network Firewall instance is created. To get a list of availability domains for a tenancy, use ListAvailabilityDomains operation. Example: kIdk:PHX-AD-1 (`default = null`)
- `network_firewall_network_firewall_display_name` - (Optional) (Updatable) A user-friendly name for the Network Firewall. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `network_firewall_network_firewall_ipv4address` - (Optional) IPv4 address for the Network Firewall. (`default = null`)
- `network_firewall_network_firewall_ipv6address` - (Optional) IPv6 address for the Network Firewall. (`default = null`)
- `network_firewall_network_firewall_network_security_group_ids` - (Optional) (Updatable) An array of network security groups OCID associated with the Network Firewall. (`default = null`)
- `network_firewall_network_firewall_defined_tags` - (Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'} (`default = {}`)
- `network_firewall_network_firewall_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall * update - (Defaults to 20 minutes), when updating the Network Firewall * delete - (Defaults to 20 minutes), when destroying the Network Firewall (`default = {}`)
- `enable_network_firewall_network_firewall_policy` - Enable network firewall network firewall policy usages (`default = False`)
- `network_firewall_network_firewall_policy_display_name` - (Optional) (Updatable) A user-friendly optional name for the firewall policy. Avoid entering confidential information. (`default = null`)
- `network_firewall_network_firewall_policy_defined_tags` - (Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'} (`default = {}`)
- `network_firewall_network_firewall_policy_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy * update - (Defaults to 20 minutes), when updating the Network Firewall Policy * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy (`default = {}`)
- `enable_network_firewall_network_firewall_policy_url_list` - Enable network firewall network firewall policy url list usages (`default = False`)
- `network_firewall_network_firewall_policy_url_list_name` - (Required) Unique name to identify the group of urls to be used in the policy rules. (`default = null`)
- `network_firewall_network_firewall_policy_url_list_network_firewall_policy_id` - (Required) Unique Network Firewall Policy identifier (`default = null`)
- `network_firewall_network_firewall_policy_url_list_urls` - (Required) (Updatable) List of urls. (`default = []`)
- `network_firewall_network_firewall_policy_url_list_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Url List * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Url List * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Url List (`default = {}`)
- `enable_network_firewall_network_firewall_policy_address_list` - Enable network firewall network firewall policy address list usages (`default = False`)
- `network_firewall_network_firewall_policy_address_list_name` - (Required) Unique name to identify the group of addresses to be used in the policy rules. (`default = null`)
- `network_firewall_network_firewall_policy_address_list_network_firewall_policy_id` - (Required) Unique Network Firewall Policy identifier (`default = null`)
- `network_firewall_network_firewall_policy_address_list_type` - (Required) Type of address List. The accepted values are - * FQDN * IP (`default = null`)
- `network_firewall_network_firewall_policy_address_list_addresses` - (Required) (Updatable) List of addresses. (`default = null`)
- `network_firewall_network_firewall_policy_address_list_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Address List * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Address List * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Address List (`default = {}`)
- `enable_network_firewall_network_firewall_policy_application_group` - Enable network firewall network firewall policy application group usages (`default = False`)
- `network_firewall_network_firewall_policy_application_group_apps` - (Required) (Updatable) Collection of application names. The apps referenced in the application group must already be present in the policy before being used in the application group. (`default = null`)
- `network_firewall_network_firewall_policy_application_group_name` - (Required) Name of the application group. (`default = null`)
- `network_firewall_network_firewall_policy_application_group_network_firewall_policy_id` - (Required) Unique Network Firewall Policy identifier (`default = ""`)
- `network_firewall_network_firewall_policy_application_group_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Application Group * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Application Group * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Application Group (`default = {}`)
- `enable_network_firewall_network_firewall_policy_application` - Enable network firewall network firewall policy application usages (`default = False`)
- `network_firewall_network_firewall_policy_application_icmp_type` - (Required) (Updatable) The value of the ICMP/IMCP_V6 message Type field as defined by RFC 4443. (`default = null`)
- `network_firewall_network_firewall_policy_application_name` - (Required) Name of the application (`default = null`)
- `network_firewall_network_firewall_policy_application_network_firewall_policy_id` - (Required) Unique Network Firewall Policy identifier (`default = ""`)
- `network_firewall_network_firewall_policy_application_type` - (Required) Describes the type of application. The accepted values are - * ICMP * ICMP_V6 (`default = null`)
- `network_firewall_network_firewall_policy_application_icmp_code` - (Optional) (Updatable) The value of the ICMP/ICMP_V6 message Code (subtype) field as defined by RFC 4443. (`default = null`)
- `network_firewall_network_firewall_policy_application_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Application * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Application * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Application (`default = {}`)
- `enable_network_firewall_network_firewall_policy_decryption_profile` - Enable network firewall network firewall policy decryption profile usages (`default = False`)
- `network_firewall_network_firewall_policy_decryption_profile_name` - (Required) Name of the decryption profile. (`default = ""`)
- `network_firewall_network_firewall_policy_decryption_profile_network_firewall_policy_id` - (Required) Unique Network Firewall Policy identifier (`default = null`)
- `network_firewall_network_firewall_policy_decryption_profile_type` - (Required) Describes the type of decryption profile. The accepted values are - * SSL_FORWARD_PROXY * SSL_INBOUND_INSPECTION (`default = null`)
- `network_firewall_network_firewall_policy_decryption_profile_are_certificate_extensions_restricted` - (Applicable only when type=SSL_FORWARD_PROXY) (Updatable) Whether to block sessions if the server's certificate uses extensions other than key usage and/or extended key usage. (`default = null`)
- `network_firewall_network_firewall_policy_decryption_profile_is_auto_include_alt_name` - (Applicable only when type=SSL_FORWARD_PROXY) (Updatable) Whether to automatically append SAN to impersonating certificate if server certificate is missing SAN. (`default = null`)
- `network_firewall_network_firewall_policy_decryption_profile_is_expired_certificate_blocked` - (Applicable only when type=SSL_FORWARD_PROXY) (Updatable) Whether to block sessions if server's certificate is expired. (`default = null`)
- `network_firewall_network_firewall_policy_decryption_profile_is_out_of_capacity_blocked` - (Optional) (Updatable) Whether to block sessions if the firewall is temporarily unable to decrypt their traffic. (`default = null`)
- `network_firewall_network_firewall_policy_decryption_profile_is_revocation_status_timeout_blocked` - (Applicable only when type=SSL_FORWARD_PROXY) (Updatable) Whether to block sessions if the revocation status check for server's certificate does not succeed within the maximum allowed time (defaulting to 5 seconds). (`default = null`)
- `network_firewall_network_firewall_policy_decryption_profile_is_unknown_revocation_status_blocked` - (Applicable only when type=SSL_FORWARD_PROXY) (Updatable) Whether to block sessions if the revocation status check for server's certificate results in 'unknown'. (`default = null`)
- `network_firewall_network_firewall_policy_decryption_profile_is_unsupported_cipher_blocked` - (Optional) (Updatable) Whether to block sessions if SSL cipher suite is not supported. (`default = null`)
- `network_firewall_network_firewall_policy_decryption_profile_is_unsupported_version_blocked` - (Optional) (Updatable) Whether to block sessions if SSL version is not supported. (`default = null`)
- `network_firewall_network_firewall_policy_decryption_profile_is_untrusted_issuer_blocked` - (Applicable only when type=SSL_FORWARD_PROXY) (Updatable) Whether to block sessions if server's certificate is issued by an untrusted certificate authority (CA). (`default = null`)
- `network_firewall_network_firewall_policy_decryption_profile_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Decryption Profile * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Decryption Profile * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Decryption Profile (`default = {}`)
- `enable_network_firewall_network_firewall_policy_decryption_rule` - Enable network firewall network firewall policy decryption rule useges (`default = False`)
- `network_firewall_network_firewall_policy_decryption_rule_name` - (Required) Name for the decryption rule, must be unique within the policy. (`default = ""`)
- `network_firewall_network_firewall_policy_decryption_rule_action` - (Required) (Updatable) Action: NO_DECRYPT - Matching traffic is not decrypted or DECRYPT - Matching traffic is decrypted with the specified secret according to the specified decryptionProfile (`default = null`)
- `network_firewall_network_firewall_policy_decryption_rule_condition` - (Required) (Updatable) Match criteria used in Decryption Rule used on the firewall policy rules. The resources mentioned must already be present in the policy before being referenced in the rule. (`default = []`)
- `network_firewall_network_firewall_policy_decryption_rule_position` - (Optional) (Updatable) An object which defines the position of the rule. Only one of after_rule or before_rule should be provided. (`default = []`)
- `network_firewall_network_firewall_policy_decryption_rule_network_firewall_policy_id` - (Required) Unique Network Firewall Policy identifier (`default = null`)
- `network_firewall_network_firewall_policy_decryption_rule_decryption_profile` - (Required only when action is DECRYPT) (Updatable) The name of the decryption profile to use. (`default = null`)
- `network_firewall_network_firewall_policy_decryption_rule_secret` - (Required only when action is DECRYPT) (Updatable) The name of a mapped secret. Its type must match that of the specified decryption profile. (`default = null`)
- `network_firewall_network_firewall_policy_decryption_rule_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Decryption Rule * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Decryption Rule * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Decryption Rule (`default = {}`)
- `enable_network_firewall_network_firewall_policy_mapped_secret` - Enable network firewall network firewall policy mapped secret usages (`default = False`)
- `network_firewall_network_firewall_policy_mapped_secret_name` - (Required) (Updatable) OCID for the Vault Secret to be used. (`default = null`)
- `network_firewall_network_firewall_policy_mapped_secret_network_firewall_policy_id` - (Required) Unique Network Firewall Policy identifier (`default = ""`)
- `network_firewall_network_firewall_policy_mapped_secret_source` - (Required) Source of the secrets, where the secrets are stored. The only accepted value is OCI_VAULT (`default = null`)
- `network_firewall_network_firewall_policy_mapped_secret_type` - (Required) Type of the secrets mapped based on the policy. SSL_INBOUND_INSPECTION: For Inbound inspection of SSL traffic or SSL_FORWARD_PROXY: For forward proxy certificates for SSL inspection. (`default = null`)
- `network_firewall_network_firewall_policy_mapped_secret_vault_secret_id` - (Required) (Updatable) OCID for the Vault Secret to be used. (`default = null`)
- `network_firewall_network_firewall_policy_mapped_secret_version_number` - (Required) (Updatable) Version number of the secret to be used. (`default = null`)
- `network_firewall_network_firewall_policy_mapped_secret_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Mapped Secret * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Mapped Secret * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Mapped Secret (`default = {}`)
- `enable_network_firewall_network_firewall_policy_service_list` - Enable network firewall network firewall policy service list usages (`default = False`)
- `network_firewall_network_firewall_policy_service_list_name` - (Required) Name of the service Group. (`default = ""`)
- `network_firewall_network_firewall_policy_service_list_network_firewall_policy_id` - (Required) Unique Network Firewall Policy identifier (`default = ""`)
- `network_firewall_network_firewall_policy_service_list_services` - (Required) (Updatable) Collection of service names. The services referenced in the service list must already be present in the policy before being used in the service list. (`default = null`)
- `network_firewall_network_firewall_policy_service_list_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Service List * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Service List * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Service List (`default = {}`)
- `enable_network_firewall_network_firewall_policy_service` - Enable network firewall network firewall policy service usages (`default = False`)
- `network_firewall_network_firewall_policy_service_name` - (Required) Name of the service (`default = ""`)
- `network_firewall_network_firewall_policy_service_network_firewall_policy_id` - (Required) Unique Network Firewall Policy identifier (`default = ""`)
- `network_firewall_network_firewall_policy_service_port_ranges` - (Required) (Updatable) List of port-ranges to be used (`default = []`)
- `network_firewall_network_firewall_policy_service_type` - (Optional) Describes the type of Service. The accepted values are (`default = null`)
- `network_firewall_network_firewall_policy_service_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Service * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Service * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Service (`default = {}`)
- `enable_network_firewall_network_firewall_policy_tunnel_inspection_rule` - Enable network firewall network firewall policy tunnel inspection rule usages (`default = False`)
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_condition` - (Required) (Updatable) Criteria to evaluate against incoming network traffic. A match occurs when at least one item in the array associated with each specified property corresponds with the relevant aspect of the traffic. (`default = []`)
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_name` - (Required) Name for the Tunnel Inspection Rule, must be unique within the policy. (`default = ""`)
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_network_firewall_policy_id` - (Required) Unique Network Firewall Policy identifier (`default = ""`)
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_protocol` - (Required) (Updatable) Types of Tunnel Inspection Protocol to be applied on the traffic. VXLAN - VXLAN Tunnel Inspection Protocol will be applied on the traffic. (`default = null`)
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_action` - (Optional) (Updatable) Types of Inspect Action on the traffic flow. INSPECT - Inspect the traffic or INSPECT_AND_CAPTURE_LOG - Inspect and capture logs for the traffic. (`default = null`)
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_position` - (Optional) (Updatable) An object which defines the position of the rule. (`default = []`)
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_profile` - (Optional) (Updatable) Vxlan Inspect profile used in Vxlan Tunnel Inspection Rules. (`default = {}`)
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Tunnel Inspection Rule * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Tunnel Inspection Rule * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Tunnel Inspection Rule (`default = {}`)
- `enable_network_firewall_network_firewall_policy_security_rule` - Enable network firewall network firewall policy security rule usages (`default = False`)
- `network_firewall_network_firewall_policy_security_rule_action` - (Required) (Updatable) Types of Action on the Traffic flow. (`default = null`)
- `network_firewall_network_firewall_policy_security_rule_name` - (Required) Name for the Security rule, must be unique within the policy. (`default = ""`)
- `network_firewall_network_firewall_policy_security_rule_condition` - (Required) (Updatable) Criteria to evaluate against network traffic. A match occurs when at least one item in the array associated with each specified property corresponds with the relevant aspect of the traffic. The resources mentioned must already be present in the policy before being referenced in the rule. (`default = []`)
- `network_firewall_network_firewall_policy_security_rule_network_firewall_policy_id` - (Required) Unique Network Firewall Policy identifier (`default = ""`)
- `network_firewall_network_firewall_policy_security_rule_inspection` - (Optional) (Updatable) Type of inspection to affect the traffic flow. This is only applicable if action is INSPECT. (`default = null`)
- `network_firewall_network_firewall_policy_security_rule_position` - (Optional) (Updatable) An object which defines the position of the rule. Only one of the following position references should be provided. (`default = []`)
- `network_firewall_network_firewall_policy_security_rule_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Security Rule * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Security Rule * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Security Rule (`default = {}`)

## Module Output Variables
----------------------
- `network_firewall_network_firewall_id` - The OCID of the Network Firewall resource.
- `network_firewall_network_firewall_availability_domain` - Availability Domain where Network Firewall instance is created. To get a list of availability domains for a tenancy, use the ListAvailabilityDomains operation. Example: kIdk:PHX-AD-1
- `network_firewall_network_firewall_compartment_id` - The OCID of the compartment containing the Network Firewall.
- `network_firewall_network_firewall_display_name` - A user-friendly name for the Network Firewall. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `network_firewall_network_firewall_ipv4address` - IPv4 address for the Network Firewall.
- `network_firewall_network_firewall_ipv6address` - IPv6 address for the Network Firewall.
- `network_firewall_network_firewall_lifecycle_details` - A message describing the current state in more detail. For example, it can be used to provide actionable information for a resource in 'FAILED' state.
- `network_firewall_network_firewall_network_firewall_policy_id` - The OCID of the Network Firewall Policy.
- `network_firewall_network_firewall_network_security_group_ids` - An array of network security groups OCID associated with the Network Firewall.
- `network_firewall_network_firewall_state` - The current state of the Network Firewall.
- `network_firewall_network_firewall_subnet_id` - The OCID of the subnet associated with the Network Firewall.
- `network_firewall_network_firewall_system_tags` - Usage of system tag keys. These predefined keys are scoped to namespaces
- `network_firewall_network_firewall_time_created` - The time at which the Network Firewall was created in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `network_firewall_network_firewall_time_updated` - The time at which the Network Firewall was updated in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `network_firewall_network_firewall_policy_id` - The OCID of the resource - Network Firewall Policy.
- `network_firewall_network_firewall_policy_attached_network_firewall_count` - Count of number of Network Firewall attached to the Policy.
- `network_firewall_network_firewall_policy_compartment_id` - The OCID of the compartment containing the NetworkFirewall Policy.
- `network_firewall_network_firewall_policy_display_name` - A user-friendly optional name for the firewall policy. Avoid entering confidential information.
- `network_firewall_network_firewall_policy_lifecycle_details` - A message describing the current state in more detail. For example, can be used to provide actionable information for a resource in Failed state.
- `network_firewall_network_firewall_policy_state` - The current state of the Network Firewall Policy.
- `network_firewall_network_firewall_policy_system_tags` - Usage of system tag keys. These predefined keys are scoped to namespaces.
- `network_firewall_network_firewall_policy_time_created` - The time instant at which the Network Firewall Policy was created in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `network_firewall_network_firewall_policy_time_updated` - The time instant at which the Network Firewall Policy was updated in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `network_firewall_network_firewall_policy_url_list_name` - Unique name identifier for the URL list.
- `network_firewall_network_firewall_policy_url_list_parent_resource_id` - OCID of the Network Firewall Policy this URL List belongs to.
- `network_firewall_network_firewall_policy_url_list_total_urls` - Total count of URLs in the URL List
- `network_firewall_network_firewall_policy_url_list_urls` - List of urls.
- `network_firewall_network_firewall_policy_address_list_addresses` - List of addresses.
- `network_firewall_network_firewall_policy_address_list_name` - Unique name to identify the group of addresses to be used in the policy rules.
- `network_firewall_network_firewall_policy_address_list_parent_resource_id` - OCID of the Network Firewall Policy this Address List belongs to.
- `network_firewall_network_firewall_policy_address_list_total_addresses` - Count of total addresses in the AddressList
- `network_firewall_network_firewall_policy_address_list_type` - Type of address list. The accepted values are - * FQDN * IP. The usage FQDN is disabled by default. To get access to use FQDNs (only public FQDNs allowed) please contact support.
- `network_firewall_network_firewall_policy_application_group_apps` - List of apps in the group.
- `network_firewall_network_firewall_policy_application_group_name` -  Name of the application group.
- `network_firewall_network_firewall_policy_application_group_parent_resource_id` - OCID of the Network Firewall Policy this application group belongs to.
- `network_firewall_network_firewall_policy_application_group_total_apps` - Count of total applications in the given application group.
- `network_firewall_network_firewall_policy_application_icmp_code` - The value of the ICMP/ICMP_V6 message Code (subtype) field as defined by RFC 4443.
- `network_firewall_network_firewall_policy_application_icmp_type` - The value of the ICMP/ICMP_V6 message Type field as defined by RFC 4443.
- `network_firewall_network_firewall_policy_application_name` -  Name of the application.
- `network_firewall_network_firewall_policy_application_parent_resource_id` - OCID of the Network Firewall Policy this application belongs to.
- `network_firewall_network_firewall_policy_application_type` - Describes the type of application.
- `network_firewall_network_firewall_policy_decryption_profile_name` - Unique Name of the decryption profile.
- `network_firewall_network_firewall_policy_decryption_profile_type` - Describes the type of decryption profile.
- `network_firewall_network_firewall_policy_decryption_profile_parent_resource_id` - OCID of the Network Firewall Policy this decryption profile belongs to.
- `network_firewall_network_firewall_policy_decryption_profile_are_certificate_extensions_restricted` - Whether to block sessions if the server's certificate uses extensions other than key usage and/or extended key usage.
- `network_firewall_network_firewall_policy_decryption_profile_is_auto_include_alt_name` - Whether to automatically append SAN to impersonating certificate if server certificate is missing SAN.
- `network_firewall_network_firewall_policy_decryption_profile_is_expired_certificate_blocked` - Whether to block sessions if server's certificate is expired.
- `network_firewall_network_firewall_policy_decryption_profile_is_out_of_capacity_blocked` - Whether to block sessions if the firewall is temporarily unable to decrypt their traffic.
- `network_firewall_network_firewall_policy_decryption_profile_is_revocation_status_timeout_blocked` - Whether to block sessions if the revocation status check for server's certificate does not succeed within the maximum allowed time (defaulting to 5 seconds).
- `network_firewall_network_firewall_policy_decryption_profile_is_unknown_revocation_status_blocked` - Whether to block sessions if the revocation status check for server's certificate results in 'unknown'.
- `network_firewall_network_firewall_policy_decryption_profile_is_unsupported_cipher_blocked` - Whether to block sessions if SSL cipher suite is not supported.
- `network_firewall_network_firewall_policy_decryption_profile_is_unsupported_version_blocked` - Whether to block sessions if SSL version is not supported.
- `network_firewall_network_firewall_policy_decryption_profile_is_untrusted_issuer_blocked` - Whether to block sessions if server's certificate is issued by an untrusted certificate authority (CA).
- `network_firewall_network_firewall_policy_decryption_rule_action` - Get action
- `network_firewall_network_firewall_policy_decryption_rule_condition` - Match criteria used in Decryption Rule used on the firewall policy rules.
- `network_firewall_network_firewall_policy_decryption_rule_decryption_profile` - The name of the decryption profile to use.
- `network_firewall_network_firewall_policy_decryption_rule_secret` - The name of a mapped secret. Its type must match that of the specified decryption profile.
- `network_firewall_network_firewall_policy_decryption_rule_name` - Name for the decryption rule, must be unique within the policy.
- `network_firewall_network_firewall_policy_decryption_rule_parent_resource_id` - OCID of the Network Firewall Policy this decryption rule belongs to.
- `network_firewall_network_firewall_policy_decryption_rule_position` - An object which defines the position of the rule.
- `network_firewall_network_firewall_policy_mapped_secret_name` - Name of the secret.
- `network_firewall_network_firewall_policy_mapped_secret_parent_resource_id` - OCID of the Network Firewall Policy this Mapped Secret belongs to.
- `network_firewall_network_firewall_policy_mapped_secret_source` - Source of the secrets, where the secrets are stored.
- `network_firewall_network_firewall_policy_mapped_secret_type` - Type of the secrets mapped based on the policy.
- `network_firewall_network_firewall_policy_mapped_secret_vault_secret_id` - OCID for the Vault Secret to be used.
- `network_firewall_network_firewall_policy_mapped_secret_version_number` - Version number of the secret to be used.
- `network_firewall_network_firewall_policy_service_list_name` - Name of the service Group.
- `network_firewall_network_firewall_policy_service_list_parent_resource_id` - OCID of the Network Firewall Policy this serviceList belongs to.
- `network_firewall_network_firewall_policy_service_list_services` - List of services in the group.
- `network_firewall_network_firewall_policy_service_list_total_services` - Count of total services in the given service List.
- `network_firewall_network_firewall_policy_service_name` - Name of the service.
- `network_firewall_network_firewall_policy_service_parent_resource_id` - OCID of the Network Firewall Policy this service belongs to.
- `network_firewall_network_firewall_policy_service_port_ranges` - List of port-ranges used.
- `network_firewall_network_firewall_policy_service_type` - Describes the type of service.
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_action` - Types of Inspect Action on the Traffic flow.
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_condition` - Criteria to evaluate against incoming network traffic. A match occurs when at least one item in the array associated with each specified property corresponds with the relevant aspect of the traffic.
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_name` - Name for the Tunnel Inspection Rule, must be unique within the policy.
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_parent_resource_id` - OCID of the Network Firewall Policy this Tunnel Inspection Rule belongs to.
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_position` - An object which defines the position of the rule.
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_priority_order` - The priority order in which this rule should be evaluated
- `network_firewall_network_firewall_policy_tunnel_inspection_rule_profile` - Vxlan Inspect profile used in Vxlan Tunnel Inspection Rules.
- `network_firewall_network_firewall_policy_security_rule_inspection` - Type of inspection to affect the Traffic flow. This is only applicable if action is INSPECT.
- `network_firewall_network_firewall_policy_security_rule_name` - Name for the Security rule, must be unique within the policy.
- `network_firewall_network_firewall_policy_security_rule_parent_resource_id` - OCID of the Network Firewall Policy this security rule belongs to.
- `network_firewall_network_firewall_policy_security_rule_position` - An object which defines the position of the rule
- `network_firewall_network_firewall_policy_security_rule_condition` - Criteria to evaluate against network traffic. A match occurs when at least one item in the array associated with each specified property corresponds with the relevant aspect of the traffic.
- `network_firewall_network_firewall_policy_security_rule_action` - Types of Action on the Traffic flow.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
