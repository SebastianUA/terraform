#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for resources"
  default     = "test"
}

variable "environment" {
  description = "The environment for resources"
  default     = "dev"
}

variable "compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to"
  default     = null
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# network firewall
#-----------------------------------------------------------
variable "enable_network_firewall_network_firewall" {
  description = "Enable network firewall network firewall usages"
  default     = false
}

variable "network_firewall_network_firewall_network_firewall_policy_id" {
  description = "(Required) (Updatable) The OCID of the compartment containing the Network Firewall."
  default     = ""
}

variable "network_firewall_network_firewall_subnet_id" {
  description = "(Required) The OCID of the subnet associated with the Network Firewall."
  default     = null
}

variable "network_firewall_network_firewall_availability_domain" {
  description = "(Optional) Availability Domain where Network Firewall instance is created. To get a list of availability domains for a tenancy, use ListAvailabilityDomains operation. Example: kIdk:PHX-AD-1"
  default     = null
}

variable "network_firewall_network_firewall_display_name" {
  description = "(Optional) (Updatable) A user-friendly name for the Network Firewall. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "network_firewall_network_firewall_ipv4address" {
  description = "(Optional) IPv4 address for the Network Firewall."
  default     = null
}

variable "network_firewall_network_firewall_ipv6address" {
  description = "(Optional) IPv6 address for the Network Firewall."
  default     = null
}

variable "network_firewall_network_firewall_network_security_group_ids" {
  description = "(Optional) (Updatable) An array of network security groups OCID associated with the Network Firewall."
  default     = null
}

variable "network_firewall_network_firewall_defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'}"
  default     = {}
}

variable "network_firewall_network_firewall_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall * update - (Defaults to 20 minutes), when updating the Network Firewall * delete - (Defaults to 20 minutes), when destroying the Network Firewall"
  default     = {}
}

#-----------------------------------------------------------
# network firewall policy
#-----------------------------------------------------------
variable "enable_network_firewall_network_firewall_policy" {
  description = "Enable network firewall network firewall policy usages"
  default     = false
}

variable "network_firewall_network_firewall_policy_display_name" {
  description = "(Optional) (Updatable) A user-friendly optional name for the firewall policy. Avoid entering confidential information."
  default     = null
}

variable "network_firewall_network_firewall_policy_defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {'Operations.CostCenter': '42'}"
  default     = {}
}

variable "network_firewall_network_firewall_policy_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy * update - (Defaults to 20 minutes), when updating the Network Firewall Policy * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy"
  default     = {}
}

#-----------------------------------------------------------
# network firewall network firewall policy url list
#-----------------------------------------------------------
variable "enable_network_firewall_network_firewall_policy_url_list" {
  description = "Enable network firewall network firewall policy url list usages"
  default     = false
}

variable "network_firewall_network_firewall_policy_url_list_name" {
  description = "(Required) Unique name to identify the group of urls to be used in the policy rules."
  default     = null
}

variable "network_firewall_network_firewall_policy_url_list_network_firewall_policy_id" {
  description = "(Required) Unique Network Firewall Policy identifier"
  default     = null
}

variable "network_firewall_network_firewall_policy_url_list_urls" {
  description = "(Required) (Updatable) List of urls."
  default     = []
}

variable "network_firewall_network_firewall_policy_url_list_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Url List * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Url List * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Url List"
  default     = {}
}

#-----------------------------------------------------------
# network firewall policy address list
#-----------------------------------------------------------
variable "enable_network_firewall_network_firewall_policy_address_list" {
  description = "Enable network firewall network firewall policy address list usages"
  default     = false
}

variable "network_firewall_network_firewall_policy_address_list_name" {
  description = "(Required) Unique name to identify the group of addresses to be used in the policy rules."
  default     = null
}

variable "network_firewall_network_firewall_policy_address_list_network_firewall_policy_id" {
  description = "(Required) Unique Network Firewall Policy identifier"
  default     = null
}

variable "network_firewall_network_firewall_policy_address_list_type" {
  description = "(Required) Type of address List. The accepted values are - * FQDN * IP"
  default     = null
}

variable "network_firewall_network_firewall_policy_address_list_addresses" {
  description = "(Required) (Updatable) List of addresses."
  default     = null
}

variable "network_firewall_network_firewall_policy_address_list_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Address List * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Address List * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Address List"
  default     = {}
}

#-----------------------------------------------------------
# network firewall policy application group
#-----------------------------------------------------------
variable "enable_network_firewall_network_firewall_policy_application_group" {
  description = "Enable network firewall network firewall policy application group usages"
  default     = false
}

variable "network_firewall_network_firewall_policy_application_group_apps" {
  description = "(Required) (Updatable) Collection of application names. The apps referenced in the application group must already be present in the policy before being used in the application group."
  default     = null
}

variable "network_firewall_network_firewall_policy_application_group_name" {
  description = "(Required) Name of the application group."
  default     = null
}

variable "network_firewall_network_firewall_policy_application_group_network_firewall_policy_id" {
  description = "(Required) Unique Network Firewall Policy identifier"
  default     = ""
}

variable "network_firewall_network_firewall_policy_application_group_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Application Group * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Application Group * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Application Group"
  default     = {}
}

#-----------------------------------------------------------
# network firewall policy application
#-----------------------------------------------------------
variable "enable_network_firewall_network_firewall_policy_application" {
  description = "Enable network firewall network firewall policy application usages"
  default     = false
}

variable "network_firewall_network_firewall_policy_application_icmp_type" {
  description = "(Required) (Updatable) The value of the ICMP/IMCP_V6 message Type field as defined by RFC 4443."
  default     = null
}

variable "network_firewall_network_firewall_policy_application_name" {
  description = "(Required) Name of the application"
  default     = null
}

variable "network_firewall_network_firewall_policy_application_network_firewall_policy_id" {
  description = "(Required) Unique Network Firewall Policy identifier"
  default     = ""
}

variable "network_firewall_network_firewall_policy_application_type" {
  description = "(Required) Describes the type of application. The accepted values are - * ICMP * ICMP_V6"
  default     = null
}

variable "network_firewall_network_firewall_policy_application_icmp_code" {
  description = "(Optional) (Updatable) The value of the ICMP/ICMP_V6 message Code (subtype) field as defined by RFC 4443."
  default     = null
}

variable "network_firewall_network_firewall_policy_application_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Application * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Application * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Application"
  default     = {}
}

#-----------------------------------------------------------
# network firewall policy decryption profile
#-----------------------------------------------------------
variable "enable_network_firewall_network_firewall_policy_decryption_profile" {
  description = "Enable network firewall network firewall policy decryption profile usages"
  default     = false
}

variable "network_firewall_network_firewall_policy_decryption_profile_name" {
  description = "(Required) Name of the decryption profile."
  default     = ""
}

variable "network_firewall_network_firewall_policy_decryption_profile_network_firewall_policy_id" {
  description = "(Required) Unique Network Firewall Policy identifier"
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_profile_type" {
  description = "(Required) Describes the type of decryption profile. The accepted values are - * SSL_FORWARD_PROXY * SSL_INBOUND_INSPECTION"
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_profile_are_certificate_extensions_restricted" {
  description = "(Applicable only when type=SSL_FORWARD_PROXY) (Updatable) Whether to block sessions if the server's certificate uses extensions other than key usage and/or extended key usage."
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_profile_is_auto_include_alt_name" {
  description = "(Applicable only when type=SSL_FORWARD_PROXY) (Updatable) Whether to automatically append SAN to impersonating certificate if server certificate is missing SAN."
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_profile_is_expired_certificate_blocked" {
  description = "(Applicable only when type=SSL_FORWARD_PROXY) (Updatable) Whether to block sessions if server's certificate is expired."
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_profile_is_out_of_capacity_blocked" {
  description = "(Optional) (Updatable) Whether to block sessions if the firewall is temporarily unable to decrypt their traffic."
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_profile_is_revocation_status_timeout_blocked" {
  description = "(Applicable only when type=SSL_FORWARD_PROXY) (Updatable) Whether to block sessions if the revocation status check for server's certificate does not succeed within the maximum allowed time (defaulting to 5 seconds)."
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_profile_is_unknown_revocation_status_blocked" {
  description = "(Applicable only when type=SSL_FORWARD_PROXY) (Updatable) Whether to block sessions if the revocation status check for server's certificate results in 'unknown'."
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_profile_is_unsupported_cipher_blocked" {
  description = "(Optional) (Updatable) Whether to block sessions if SSL cipher suite is not supported."
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_profile_is_unsupported_version_blocked" {
  description = "(Optional) (Updatable) Whether to block sessions if SSL version is not supported."
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_profile_is_untrusted_issuer_blocked" {
  description = "(Applicable only when type=SSL_FORWARD_PROXY) (Updatable) Whether to block sessions if server's certificate is issued by an untrusted certificate authority (CA)."
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_profile_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Decryption Profile * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Decryption Profile * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Decryption Profile"
  default     = {}
}

#-----------------------------------------------------------
# network firewall policy decryption rule
#-----------------------------------------------------------
variable "enable_network_firewall_network_firewall_policy_decryption_rule" {
  description = "Enable network firewall network firewall policy decryption rule useges"
  default     = false
}

variable "network_firewall_network_firewall_policy_decryption_rule_name" {
  description = "(Required) Name for the decryption rule, must be unique within the policy."
  default     = ""
}

variable "network_firewall_network_firewall_policy_decryption_rule_action" {
  description = "(Required) (Updatable) Action: NO_DECRYPT - Matching traffic is not decrypted or DECRYPT - Matching traffic is decrypted with the specified secret according to the specified decryptionProfile"
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_rule_condition" {
  description = "(Required) (Updatable) Match criteria used in Decryption Rule used on the firewall policy rules. The resources mentioned must already be present in the policy before being referenced in the rule."
  default     = []
}

variable "network_firewall_network_firewall_policy_decryption_rule_position" {
  description = "(Optional) (Updatable) An object which defines the position of the rule. Only one of after_rule or before_rule should be provided."
  default     = []
}

variable "network_firewall_network_firewall_policy_decryption_rule_network_firewall_policy_id" {
  description = "(Required) Unique Network Firewall Policy identifier"
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_rule_decryption_profile" {
  description = "(Required only when action is DECRYPT) (Updatable) The name of the decryption profile to use."
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_rule_secret" {
  description = "(Required only when action is DECRYPT) (Updatable) The name of a mapped secret. Its type must match that of the specified decryption profile."
  default     = null
}

variable "network_firewall_network_firewall_policy_decryption_rule_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Decryption Rule * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Decryption Rule * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Decryption Rule"
  default     = {}
}

#-----------------------------------------------------------
# network firewall policy mapped secret
#-----------------------------------------------------------
variable "enable_network_firewall_network_firewall_policy_mapped_secret" {
  description = "Enable network firewall network firewall policy mapped secret usages"
  default     = false
}

variable "network_firewall_network_firewall_policy_mapped_secret_name" {
  description = "(Required) (Updatable) OCID for the Vault Secret to be used."
  default     = null
}

variable "network_firewall_network_firewall_policy_mapped_secret_network_firewall_policy_id" {
  description = "(Required) Unique Network Firewall Policy identifier"
  default     = ""
}

variable "network_firewall_network_firewall_policy_mapped_secret_source" {
  description = "(Required) Source of the secrets, where the secrets are stored. The only accepted value is OCI_VAULT"
  default     = null
}

variable "network_firewall_network_firewall_policy_mapped_secret_type" {
  description = "(Required) Type of the secrets mapped based on the policy. SSL_INBOUND_INSPECTION: For Inbound inspection of SSL traffic or SSL_FORWARD_PROXY: For forward proxy certificates for SSL inspection."
  default     = null
}

variable "network_firewall_network_firewall_policy_mapped_secret_vault_secret_id" {
  description = "(Required) (Updatable) OCID for the Vault Secret to be used."
  default     = null
}

variable "network_firewall_network_firewall_policy_mapped_secret_version_number" {
  description = "(Required) (Updatable) Version number of the secret to be used."
  default     = null
}

variable "network_firewall_network_firewall_policy_mapped_secret_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Mapped Secret * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Mapped Secret * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Mapped Secret"
  default     = {}
}

#-----------------------------------------------------------
# network firewall policy service list
#-----------------------------------------------------------
variable "enable_network_firewall_network_firewall_policy_service_list" {
  description = "Enable network firewall network firewall policy service list usages"
  default     = false
}

variable "network_firewall_network_firewall_policy_service_list_name" {
  description = "(Required) Name of the service Group."
  default     = ""
}

variable "network_firewall_network_firewall_policy_service_list_network_firewall_policy_id" {
  description = "(Required) Unique Network Firewall Policy identifier"
  default     = ""
}

variable "network_firewall_network_firewall_policy_service_list_services" {
  description = "(Required) (Updatable) Collection of service names. The services referenced in the service list must already be present in the policy before being used in the service list."
  default     = null
}

variable "network_firewall_network_firewall_policy_service_list_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Service List * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Service List * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Service List"
  default     = {}
}

#-----------------------------------------------------------
# network firewall policy service
#-----------------------------------------------------------
variable "enable_network_firewall_network_firewall_policy_service" {
  description = "Enable network firewall network firewall policy service usages"
  default     = false
}

variable "network_firewall_network_firewall_policy_service_name" {
  description = "(Required) Name of the service"
  default     = ""
}

variable "network_firewall_network_firewall_policy_service_network_firewall_policy_id" {
  description = "(Required) Unique Network Firewall Policy identifier"
  default     = ""
}

variable "network_firewall_network_firewall_policy_service_port_ranges" {
  description = "(Required) (Updatable) List of port-ranges to be used"
  default     = []
}

variable "network_firewall_network_firewall_policy_service_type" {
  description = "(Optional) Describes the type of Service. The accepted values are"
  default     = null
}

variable "network_firewall_network_firewall_policy_service_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Service * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Service * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Service"
  default     = {}
}

#-----------------------------------------------------------
# network firewall policy tunnel inspection rule
#-----------------------------------------------------------
variable "enable_network_firewall_network_firewall_policy_tunnel_inspection_rule" {
  description = "Enable network firewall network firewall policy tunnel inspection rule usages"
  default     = false
}

variable "network_firewall_network_firewall_policy_tunnel_inspection_rule_condition" {
  description = "(Required) (Updatable) Criteria to evaluate against incoming network traffic. A match occurs when at least one item in the array associated with each specified property corresponds with the relevant aspect of the traffic."
  default     = []
}

variable "network_firewall_network_firewall_policy_tunnel_inspection_rule_name" {
  description = "(Required) Name for the Tunnel Inspection Rule, must be unique within the policy."
  default     = ""
}

variable "network_firewall_network_firewall_policy_tunnel_inspection_rule_network_firewall_policy_id" {
  description = "(Required) Unique Network Firewall Policy identifier"
  default     = ""
}

variable "network_firewall_network_firewall_policy_tunnel_inspection_rule_protocol" {
  description = "(Required) (Updatable) Types of Tunnel Inspection Protocol to be applied on the traffic. VXLAN - VXLAN Tunnel Inspection Protocol will be applied on the traffic."
  default     = null
}

variable "network_firewall_network_firewall_policy_tunnel_inspection_rule_action" {
  description = "(Optional) (Updatable) Types of Inspect Action on the traffic flow. INSPECT - Inspect the traffic or INSPECT_AND_CAPTURE_LOG - Inspect and capture logs for the traffic."
  default     = null
}

variable "network_firewall_network_firewall_policy_tunnel_inspection_rule_position" {
  description = "(Optional) (Updatable) An object which defines the position of the rule."
  default     = []
}

variable "network_firewall_network_firewall_policy_tunnel_inspection_rule_profile" {
  description = "(Optional) (Updatable) Vxlan Inspect profile used in Vxlan Tunnel Inspection Rules."
  default     = {}
}

variable "network_firewall_network_firewall_policy_tunnel_inspection_rule_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Tunnel Inspection Rule * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Tunnel Inspection Rule * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Tunnel Inspection Rule"
  default     = {}
}

#-----------------------------------------------------------
# network firewall policy security rule
#-----------------------------------------------------------
variable "enable_network_firewall_network_firewall_policy_security_rule" {
  description = "Enable network firewall network firewall policy security rule usages"
  default     = false
}

variable "network_firewall_network_firewall_policy_security_rule_action" {
  description = "(Required) (Updatable) Types of Action on the Traffic flow."
  default     = null
}

variable "network_firewall_network_firewall_policy_security_rule_name" {
  description = "(Required) Name for the Security rule, must be unique within the policy."
  default     = ""
}

variable "network_firewall_network_firewall_policy_security_rule_condition" {
  description = "(Required) (Updatable) Criteria to evaluate against network traffic. A match occurs when at least one item in the array associated with each specified property corresponds with the relevant aspect of the traffic. The resources mentioned must already be present in the policy before being referenced in the rule."
  default     = []
}

variable "network_firewall_network_firewall_policy_security_rule_network_firewall_policy_id" {
  description = "(Required) Unique Network Firewall Policy identifier"
  default     = ""
}

variable "network_firewall_network_firewall_policy_security_rule_inspection" {
  description = "(Optional) (Updatable) Type of inspection to affect the traffic flow. This is only applicable if action is INSPECT."
  default     = null
}

variable "network_firewall_network_firewall_policy_security_rule_position" {
  description = "(Optional) (Updatable) An object which defines the position of the rule. Only one of the following position references should be provided."
  default     = []
}

variable "network_firewall_network_firewall_policy_security_rule_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Firewall Policy Security Rule * update - (Defaults to 20 minutes), when updating the Network Firewall Policy Security Rule * delete - (Defaults to 20 minutes), when destroying the Network Firewall Policy Security Rule"
  default     = {}
}
