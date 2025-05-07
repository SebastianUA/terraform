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
# dns record
#-----------------------------------------------------------
variable "enable_dns_record" {
  description = "Enable dns record usage"
  default     = false
}

variable "dns_record_zone_name_or_id" {
  description = "The name or OCID of the target zone."
  default     = ""
}

variable "dns_record_domain" {
  description = "The fully qualified domain name where the record can be located."
  default     = null
}

variable "dns_record_rtype" {
  description = "(Required) The canonical name for the record's type, such as A or CNAME. For more information, see Resource Record (RR) TYPEs."
  default     = null
}

variable "dns_record_rdata" {
  description = "(Optional) (Updatable) The record's data, as whitespace-delimited tokens in type-specific presentation format. All RDATA is normalized and the returned presentation of your RDATA may differ from its initial input. For more information about RDATA, see Supported DNS Resource Record Types"
  default     = null
}

variable "dns_record_ttl" {
  description = "(Optional) (Updatable) The Time To Live for the record, in seconds."
  default     = null
}

variable "dns_record_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Record * update - (Defaults to 20 minutes), when updating the Record * delete - (Defaults to 20 minutes), when destroying the Record"
  default     = {}
}

#-----------------------------------------------------------
# dns zone
#-----------------------------------------------------------
variable "enable_dns_zone" {
  description = "Enable dns zone usage"
  default     = false
}

variable "dns_zone_name" {
  description = "The name of the zone."
  default     = ""
}

variable "dns_zone_zone_type" {
  description = "(Required) The type of the zone. Must be either PRIMARY or SECONDARY. SECONDARY is only supported for GLOBAL zones."
  default     = null
}

variable "dns_zone_scope" {
  description = "(Optional) Specifies to operate only on resources that have a matching DNS scope. This value will be null for zones in the global DNS and PRIVATE when creating a private zone."
  default     = null
}

variable "dns_zone_view_id" {
  description = "(Optional) The OCID of the private view containing the zone. This value will be null for zones in the global DNS, which are publicly resolvable and not part of a private view."
  default     = null
}

variable "dns_zone_dnssec_state" {
  description = "(Optional) (Updatable) The state of DNSSEC on the zone."
  default     = null
}

variable "dns_zone_external_downstreams" {
  description = "(Optional) (Updatable) External secondary servers for the zone. This field is currently not supported when zoneType is SECONDARY or scope is PRIVATE."
  default     = []
}

variable "dns_zone_external_masters" {
  description = "(Optional) (Updatable) External master servers for the zone. externalMasters becomes a required parameter when the zoneType value is SECONDARY."
  default     = []
}

variable "dns_zone_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "dns_zone_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Zone * update - (Defaults to 20 minutes), when updating the Zone * delete - (Defaults to 20 minutes), when destroying the Zone"
  default     = {}
}

#-----------------------------------------------------------
# dns zone stage dnssec key version
#-----------------------------------------------------------
variable "enable_zone_stage_dnssec_key_version" {
  description = "Enable zone stage dnssec key version usages"
  default     = false
}

variable "zone_stage_dnssec_key_version_predecessor_dnssec_key_version_uuid" {
  description = "(Required) The UUID of the DnssecKeyVersion for which a new successor should be generated."
  default     = null
}

variable "zone_stage_dnssec_key_version_zone_id" {
  description = "The OCID of the target zone."
  default     = ""
}

variable "zone_stage_dnssec_key_version_scope" {
  description = "(Optional) Specifies to operate only on resources that have a matching DNS scope."
  default     = null
}

variable "zone_stage_dnssec_key_version_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Zone Stage Dnssec Key Version * update - (Defaults to 20 minutes), when updating the Zone Stage Dnssec Key Version * delete - (Defaults to 20 minutes), when destroying the Zone Stage Dnssec Key Version"
  default     = {}
}

#-----------------------------------------------------------
# dns zone promote dnssec key version
#-----------------------------------------------------------
variable "enable_zone_promote_dnssec_key_version" {
  description = "Enable zone promote dnssec key version usages"
  default     = false
}

variable "zone_promote_dnssec_key_version_dnssec_key_version_uuid" {
  description = "(Required) The UUID of the DnssecKeyVersion that is being promoted."
  default     = null
}

variable "zone_promote_dnssec_key_version_zone_id" {
  description = "The OCID of the target zone."
  default     = ""
}

variable "zone_promote_dnssec_key_version_scope" {
  description = "(Optional) Specifies to operate only on resources that have a matching DNS scope."
  default     = null
}

variable "zone_stage_dnssec_key_version_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Zone Promote Dnssec Key Version * update - (Defaults to 20 minutes), when updating the Zone Promote Dnssec Key Version * delete - (Defaults to 20 minutes), when destroying the Zone Promote Dnssec Key Version"
  default     = {}
}

#-----------------------------------------------------------
# dns view
#-----------------------------------------------------------
variable "enable_dns_view" {
  description = "Enable dns view usages"
  default     = false
}

variable "dns_view_display_name" {
  description = "(Updatable) The display name of the view."
  default     = ""
}

variable "dns_view_scope" {
  description = "(Optional) If specified, must be PRIVATE when creating a view for private zones."
  default     = null
}

variable "dns_view_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "dns_view_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the View * update - (Defaults to 20 minutes), when updating the View * delete - (Defaults to 20 minutes), when destroying the View"
  default     = {}
}

#-----------------------------------------------------------
# dns tsig key
#-----------------------------------------------------------
variable "enable_dns_tsig_key" {
  description = "Enable dns tsig key usages"
  default     = false
}

variable "dns_tsig_key_algorithm" {
  description = "(Required) TSIG key algorithms are encoded as domain names, but most consist of only one non-empty label, which is not required to be explicitly absolute. Applicable algorithms include: hmac-sha1, hmac-sha224, hmac-sha256, hmac-sha512. For more information on these algorithms, see RFC 4635."
  default     = null
}

variable "dns_tsig_key_name" {
  description = "A globally unique domain name identifying the key for a given pair of hosts."
  default     = ""
}

variable "dns_tsig_key_secret" {
  description = "(Required) A base64 string encoding the binary shared secret."
  default     = null
}

variable "dns_tsig_key_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "dns_tsig_key_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Tsig Key * update - (Defaults to 20 minutes), when updating the Tsig Key * delete - (Defaults to 20 minutes), when destroying the Tsig Key"
  default     = {}
}

#-----------------------------------------------------------
# dns steering policy
#-----------------------------------------------------------
variable "enable_dns_steering_policy" {
  description = "Enable dns steering policy usages"
  default     = false
}

variable "dns_steering_policy_display_name" {
  description = "A user-friendly name for the steering policy. Does not have to be unique and can be changed. Avoid entering confidential information."
  default     = ""
}

variable "dns_steering_policy_template" {
  description = "A set of predefined rules based on the desired purpose of the steering policy. Each template utilizes Traffic Management's rules in a different order to produce the desired results when answering DNS queries."
  default     = null
}

variable "dns_steering_policy_health_check_monitor_id" {
  description = "(Optional) (Updatable) The OCID of the health check monitor providing health data about the answers of the steering policy. A steering policy answer with rdata matching a monitored endpoint will use the health data of that endpoint. A steering policy answer with rdata not matching any monitored endpoint will be assumed healthy."
  default     = null
}

variable "dns_steering_policy_ttl" {
  description = "(Optional) (Updatable) The Time To Live (TTL) for responses from the steering policy, in seconds. If not specified during creation, a value of 30 seconds will be used."
  default     = null
}

variable "dns_steering_policy_answers" {
  description = "(Optional) The set of all answers that can potentially issue from the steering policy."
  default     = []
}

variable "dns_steering_policy_rules" {
  description = "(Optional) The series of rules that will be processed in sequence to reduce the pool of answers to a response for any given request."
  default     = []
}

variable "dns_steering_policy_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "dns_steering_policy_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Steering Policy * update - (Defaults to 20 minutes), when updating the Steering Policy * delete - (Defaults to 20 minutes), when destroying the Steering Policy"
  default     = {}
}

#-----------------------------------------------------------
# dns steering policy attachment
#-----------------------------------------------------------
variable "enable_dns_steering_policy_attachment" {
  description = "enable dns steering policy attachment usages"
  default     = false
}

variable "dns_steering_policy_attachment_domain_name" {
  description = "(Required) The attached domain within the attached zone. domain_name is case insensitive."
  default     = null
}

variable "dns_steering_policy_attachment_steering_policy_id" {
  description = "The OCID of the attached steering policy."
  default     = ""
}

variable "dns_steering_policy_attachment_zone_id" {
  description = "The OCID of the attached zone."
  default     = ""
}

variable "dns_steering_policy_attachment_display_name" {
  description = "(Optional) (Updatable) A user-friendly name for the steering policy attachment. Does not have to be unique and can be changed. Avoid entering confidential information."
  default     = null
}

variable "dns_steering_policy_attachment_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Steering Policy Attachment * update - (Defaults to 20 minutes), when updating the Steering Policy Attachment * delete - (Defaults to 20 minutes), when destroying the Steering Policy Attachment"
  default     = {}
}

#-----------------------------------------------------------
# dns action create zone from zone file
#-----------------------------------------------------------
variable "enable_dns_action_create_zone_from_zone_file" {
  description = "Enable dns action create zone from zone file usage"
  default     = false
}

variable "dns_action_create_zone_from_zone_file_create_zone_from_zone_file_details" {
  description = "(Required) The zone file contents."
  default     = null
}

variable "dns_action_create_zone_from_zone_file_scope" {
  description = "(Optional) Specifies to operate only on resources that have a matching DNS scope."
  default     = null
}

variable "dns_action_create_zone_from_zone_file_view_id" {
  description = "(Optional) The OCID of the view the resource is associated with."
  default     = null
}

variable "dns_action_create_zone_from_zone_file_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Action Create Zone From Zone File * update - (Defaults to 20 minutes), when updating the Action Create Zone From Zone File * delete - (Defaults to 20 minutes), when destroying the Action Create Zone From Zone File"
  default     = {}
}

#-----------------------------------------------------------
# dns rrset
#-----------------------------------------------------------
variable "enable_dns_rrset" {
  description = "Enable dns rrset usages"
  default     = false
}

variable "dns_rrset_domain" {
  description = "(Required) The target fully-qualified domain name (FQDN) within the target zone."
  default     = null
}

variable "dns_rrset_rtype" {
  description = "(Required) The type of the target RRSet within the target zone."
  default     = null
}

variable "dns_rrset_zone_name_or_id" {
  description = "The name or OCID of the target zone."
  default     = ""
}

variable "dns_rrset_items" {
  description = "(Optional) (Updatable) NOTE Omitting items at time of create will delete any existing records in the RRSet"
  default     = []
}

variable "dns_rrset_scopes" {
  description = "(Optional) Specifies to operate only on resources that have a matching DNS scope."
  default     = null
}

variable "dns_rrset_view_id" {
  description = "(Optional) The OCID of the view the zone is associated with. Required when accessing a private zone by name."
  default     = ""
}

variable "dns_rrset_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Rrset * update - (Defaults to 20 minutes), when updating the Rrset * delete - (Defaults to 20 minutes), when destroying the Rrset"
  default     = {}
}

#-----------------------------------------------------------
# dns resolver endpoint
#-----------------------------------------------------------
variable "enable_dns_resolver_endpoint" {
  description = "Enable dns resolver endpoint usages"
  default     = false
}

variable "dns_resolver_endpoint_is_forwarding" {
  description = "(Required) A Boolean flag indicating whether or not the resolver endpoint is for forwarding."
  default     = null
}

variable "dns_resolver_endpoint_is_listening" {
  description = "(Required) A Boolean flag indicating whether or not the resolver endpoint is for listening."
  default     = null
}

variable "dns_resolver_endpoint_name" {
  description = "The name of the resolver endpoint. Must be unique, case-insensitive, within the resolver."
  default     = ""
}

variable "dns_resolver_endpoint_resolver_id" {
  description = "(Required) The OCID of the target resolver."
  default     = ""
}

variable "dns_resolver_endpoint_subnet_id" {
  description = "(Required) The OCID of a subnet. Must be part of the VCN that the resolver is attached to."
  default     = null
}

variable "dns_resolver_endpoint_scope" {
  description = "(Required) Value must be PRIVATE when creating private name resolver endpoints."
  default     = null
}

variable "dns_resolver_endpoint_endpoint_type" {
  description = "(Optional) (Updatable) The type of resolver endpoint. VNIC is currently the only supported type."
  default     = null
}

variable "dns_resolver_endpoint_forwarding_address" {
  description = "(Optional) An IP address from which forwarded queries may be sent. For VNIC endpoints, this IP address must be part of the subnet and will be assigned by the system if unspecified when isForwarding is true."
  default     = null
}

variable "dns_resolver_endpoint_listening_address" {
  description = "(Optional) An IP address to listen to queries on. For VNIC endpoints this IP address must be part of the subnet and will be assigned by the system if unspecified when isListening is true."
  default     = null
}

variable "dns_resolver_endpoint_nsg_ids" {
  description = "(Optional) An array of network security group OCIDs for the resolver endpoint. These must be part of the VCN that the resolver endpoint is a part of."
  default     = null
}

variable "dns_resolver_endpoint_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Resolver Endpoint * update - (Defaults to 20 minutes), when updating the Resolver Endpoint * delete - (Defaults to 20 minutes), when destroying the Resolver Endpoint"
  default     = {}
}

#-----------------------------------------------------------
# dns resolver
#-----------------------------------------------------------
variable "enable_dns_resolver" {
  description = "Enable dns resolver usages"
  default     = false
}

variable "dns_resolver_resolver_id" {
  description = "The OCID of the target resolver."
  default     = ""
}

variable "dns_resolver_scope" {
  description = "(Optional) Specifies to operate only on resources that have a matching DNS scope."
  default     = null
}

variable "dns_resolver_display_name" {
  description = "(Optional) (Updatable) The display name of the resolver."
  default     = ""
}

variable "dns_resolver_attached_views" {
  description = "(Optional) (Updatable) The attached views. Views are evaluated in order."
  default     = []
}

variable "dns_resolver_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "dns_resolver_rules" {
  description = "(Optional) (Updatable) Rules for the resolver. Rules are evaluated in order."
  default     = []
}

variable "dns_resolver_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Resolver * update - (Defaults to 20 minutes), when updating the Resolver * delete - (Defaults to 20 minutes), when destroying the Resolver"
  default     = []
}
