# Work with DNS via terraform

A terraform module for making DNS.


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

module "dns" {
  source = "../../modules/dns"

  enable_dns_record = true
  # dns_record_zone_name_or_id = ""
  dns_record_domain = ""
  dns_record_rtype  = ""

  dns_record_rdata = ""
  dns_record_ttl   = ""
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_dns_record` - Enable dns record usage (`default = False`)
- `dns_record_zone_name_or_id` - The name or OCID of the target zone. (`default = ""`)
- `dns_record_domain` - The fully qualified domain name where the record can be located. (`default = null`)
- `dns_record_rtype` - (Required) The canonical name for the record's type, such as A or CNAME. For more information, see Resource Record (RR) TYPEs. (`default = null`)
- `dns_record_rdata` - (Optional) (Updatable) The record's data, as whitespace-delimited tokens in type-specific presentation format. All RDATA is normalized and the returned presentation of your RDATA may differ from its initial input. For more information about RDATA, see Supported DNS Resource Record Types (`default = null`)
- `dns_record_ttl` - (Optional) (Updatable) The Time To Live for the record, in seconds. (`default = null`)
- `dns_record_compartment_id` - (Optional) (Updatable) The OCID of the compartment the resource belongs to. If supplied, it must match the Zone's compartment ocid. (`default = null`)
- `dns_record_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Record * update - (Defaults to 20 minutes), when updating the Record * delete - (Defaults to 20 minutes), when destroying the Record (`default = {}`)
- `enable_dns_zone` - Enable dns zone usage (`default = False`)
- `dns_zone_compartment_id` - (Required) (Updatable) The OCID of the compartment containing the zone. (`default = null`)
- `dns_zone_name` - The name of the zone. (`default = ""`)
- `dns_zone_zone_type` - (Required) The type of the zone. Must be either PRIMARY or SECONDARY. SECONDARY is only supported for GLOBAL zones. (`default = null`)
- `dns_zone_scope` - (Optional) Specifies to operate only on resources that have a matching DNS scope. This value will be null for zones in the global DNS and PRIVATE when creating a private zone. (`default = null`)
- `dns_zone_view_id` - (Optional) The OCID of the private view containing the zone. This value will be null for zones in the global DNS, which are publicly resolvable and not part of a private view. (`default = null`)
- `dns_zone_dnssec_state` - (Optional) (Updatable) The state of DNSSEC on the zone. (`default = null`)
- `dns_zone_external_downstreams` - (Optional) (Updatable) External secondary servers for the zone. This field is currently not supported when zoneType is SECONDARY or scope is PRIVATE. (`default = []`)
- `dns_zone_external_masters` - (Optional) (Updatable) External master servers for the zone. externalMasters becomes a required parameter when the zoneType value is SECONDARY. (`default = []`)
- `dns_zone_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `dns_zone_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Zone * update - (Defaults to 20 minutes), when updating the Zone * delete - (Defaults to 20 minutes), when destroying the Zone (`default = {}`)
- `enable_zone_stage_dnssec_key_version` - Enable zone stage dnssec key version usages (`default = False`)
- `zone_stage_dnssec_key_version_predecessor_dnssec_key_version_uuid` - (Required) The UUID of the DnssecKeyVersion for which a new successor should be generated. (`default = null`)
- `zone_stage_dnssec_key_version_zone_id` - The OCID of the target zone. (`default = ""`)
- `zone_stage_dnssec_key_version_scope` - (Optional) Specifies to operate only on resources that have a matching DNS scope. (`default = null`)
- `zone_stage_dnssec_key_version_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Zone Stage Dnssec Key Version * update - (Defaults to 20 minutes), when updating the Zone Stage Dnssec Key Version * delete - (Defaults to 20 minutes), when destroying the Zone Stage Dnssec Key Version (`default = {}`)
- `enable_zone_promote_dnssec_key_version` - Enable zone promote dnssec key version usages (`default = False`)
- `zone_promote_dnssec_key_version_dnssec_key_version_uuid` - (Required) The UUID of the DnssecKeyVersion that is being promoted. (`default = null`)
- `zone_promote_dnssec_key_version_zone_id` - The OCID of the target zone. (`default = ""`)
- `zone_promote_dnssec_key_version_scope` - (Optional) Specifies to operate only on resources that have a matching DNS scope. (`default = null`)
- `zone_stage_dnssec_key_version_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Zone Promote Dnssec Key Version * update - (Defaults to 20 minutes), when updating the Zone Promote Dnssec Key Version * delete - (Defaults to 20 minutes), when destroying the Zone Promote Dnssec Key Version (`default = {}`)
- `enable_dns_view` - Enable dns view usages (`default = False`)
- `dns_view_compartment_id` - (Required) (Updatable) The OCID of the owning compartment. (`default = null`)
- `dns_view_display_name` - (Updatable) The display name of the view. (`default = ""`)
- `dns_view_scope` - (Optional) If specified, must be PRIVATE when creating a view for private zones. (`default = null`)
- `dns_view_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `dns_view_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the View * update - (Defaults to 20 minutes), when updating the View * delete - (Defaults to 20 minutes), when destroying the View (`default = {}`)
- `enable_dns_tsig_key` - Enable dns tsig key usages (`default = False`)
- `dns_tsig_key_algorithm` - (Required) TSIG key algorithms are encoded as domain names, but most consist of only one non-empty label, which is not required to be explicitly absolute. Applicable algorithms include: hmac-sha1, hmac-sha224, hmac-sha256, hmac-sha512. For more information on these algorithms, see RFC 4635. (`default = null`)
- `dns_tsig_key_compartment_id` - (Required) (Updatable) The OCID of the compartment containing the TSIG key. (`default = null`)
- `dns_tsig_key_name` - A globally unique domain name identifying the key for a given pair of hosts. (`default = ""`)
- `dns_tsig_key_secret` - (Required) A base64 string encoding the binary shared secret. (`default = null`)
- `dns_tsig_key_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `dns_tsig_key_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Tsig Key * update - (Defaults to 20 minutes), when updating the Tsig Key * delete - (Defaults to 20 minutes), when destroying the Tsig Key (`default = {}`)
- `enable_dns_steering_policy` - Enable dns steering policy usages (`default = False`)
- `dns_steering_policy_compartment_id` - The OCID of the compartment containing the steering policy. (`default = null`)
- `dns_steering_policy_display_name` - A user-friendly name for the steering policy. Does not have to be unique and can be changed. Avoid entering confidential information. (`default = ""`)
- `dns_steering_policy_template` - A set of predefined rules based on the desired purpose of the steering policy. Each template utilizes Traffic Management's rules in a different order to produce the desired results when answering DNS queries. (`default = null`)
- `dns_steering_policy_health_check_monitor_id` - (Optional) (Updatable) The OCID of the health check monitor providing health data about the answers of the steering policy. A steering policy answer with rdata matching a monitored endpoint will use the health data of that endpoint. A steering policy answer with rdata not matching any monitored endpoint will be assumed healthy. (`default = null`)
- `dns_steering_policy_ttl` - (Optional) (Updatable) The Time To Live (TTL) for responses from the steering policy, in seconds. If not specified during creation, a value of 30 seconds will be used. (`default = null`)
- `dns_steering_policy_answers` - (Optional) The set of all answers that can potentially issue from the steering policy. (`default = []`)
- `dns_steering_policy_rules` - (Optional) The series of rules that will be processed in sequence to reduce the pool of answers to a response for any given request. (`default = []`)
- `dns_steering_policy_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `dns_steering_policy_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Steering Policy * update - (Defaults to 20 minutes), when updating the Steering Policy * delete - (Defaults to 20 minutes), when destroying the Steering Policy (`default = {}`)
- `enable_dns_steering_policy_attachment` - enable dns steering policy attachment usages (`default = False`)
- `dns_steering_policy_attachment_domain_name` - (Required) The attached domain within the attached zone. domain_name is case insensitive. (`default = null`)
- `dns_steering_policy_attachment_steering_policy_id` - The OCID of the attached steering policy. (`default = ""`)
- `dns_steering_policy_attachment_zone_id` - The OCID of the attached zone. (`default = ""`)
- `dns_steering_policy_attachment_display_name` - (Optional) (Updatable) A user-friendly name for the steering policy attachment. Does not have to be unique and can be changed. Avoid entering confidential information. (`default = null`)
- `dns_steering_policy_attachment_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Steering Policy Attachment * update - (Defaults to 20 minutes), when updating the Steering Policy Attachment * delete - (Defaults to 20 minutes), when destroying the Steering Policy Attachment (`default = {}`)
- `enable_dns_action_create_zone_from_zone_file` - Enable dns action create zone from zone file usage (`default = False`)
- `dns_action_create_zone_from_zone_file_create_zone_from_zone_file_details` - (Required) The zone file contents. (`default = null`)
- `dns_action_create_zone_from_zone_file_compartment_id` - (Required) The OCID of the compartment the resource belongs to. (`default = null`)
- `dns_action_create_zone_from_zone_file_scope` - (Optional) Specifies to operate only on resources that have a matching DNS scope. (`default = null`)
- `dns_action_create_zone_from_zone_file_view_id` - (Optional) The OCID of the view the resource is associated with. (`default = null`)
- `dns_action_create_zone_from_zone_file_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Action Create Zone From Zone File * update - (Defaults to 20 minutes), when updating the Action Create Zone From Zone File * delete - (Defaults to 20 minutes), when destroying the Action Create Zone From Zone File (`default = {}`)
- `enable_dns_rrset` - Enable dns rrset usages (`default = False`)
- `dns_rrset_domain` - (Required) The target fully-qualified domain name (FQDN) within the target zone. (`default = null`)
- `dns_rrset_rtype` - (Required) The type of the target RRSet within the target zone. (`default = null`)
- `dns_rrset_zone_name_or_id` - The name or OCID of the target zone. (`default = ""`)
- `dns_rrset_items` - (Optional) (Updatable) NOTE Omitting items at time of create will delete any existing records in the RRSet (`default = []`)
- `dns_rrset_scopes` - (Optional) Specifies to operate only on resources that have a matching DNS scope. (`default = null`)
- `dns_rrset_view_id` - (Optional) The OCID of the view the zone is associated with. Required when accessing a private zone by name. (`default = ""`)
- `dns_rrset_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Rrset * update - (Defaults to 20 minutes), when updating the Rrset * delete - (Defaults to 20 minutes), when destroying the Rrset (`default = {}`)
- `enable_dns_resolver_endpoint` - Enable dns resolver endpoint usages (`default = False`)
- `dns_resolver_endpoint_is_forwarding` - (Required) A Boolean flag indicating whether or not the resolver endpoint is for forwarding. (`default = null`)
- `dns_resolver_endpoint_is_listening` - (Required) A Boolean flag indicating whether or not the resolver endpoint is for listening. (`default = null`)
- `dns_resolver_endpoint_name` - The name of the resolver endpoint. Must be unique, case-insensitive, within the resolver. (`default = ""`)
- `dns_resolver_endpoint_resolver_id` - (Required) The OCID of the target resolver. (`default = ""`)
- `dns_resolver_endpoint_subnet_id` - (Required) The OCID of a subnet. Must be part of the VCN that the resolver is attached to. (`default = null`)
- `dns_resolver_endpoint_scope` - (Required) Value must be PRIVATE when creating private name resolver endpoints. (`default = null`)
- `dns_resolver_endpoint_endpoint_type` - (Optional) (Updatable) The type of resolver endpoint. VNIC is currently the only supported type. (`default = null`)
- `dns_resolver_endpoint_forwarding_address` - (Optional) An IP address from which forwarded queries may be sent. For VNIC endpoints, this IP address must be part of the subnet and will be assigned by the system if unspecified when isForwarding is true. (`default = null`)
- `dns_resolver_endpoint_listening_address` - (Optional) An IP address to listen to queries on. For VNIC endpoints this IP address must be part of the subnet and will be assigned by the system if unspecified when isListening is true. (`default = null`)
- `dns_resolver_endpoint_nsg_ids` - (Optional) An array of network security group OCIDs for the resolver endpoint. These must be part of the VCN that the resolver endpoint is a part of. (`default = null`)
- `dns_resolver_endpoint_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Resolver Endpoint * update - (Defaults to 20 minutes), when updating the Resolver Endpoint * delete - (Defaults to 20 minutes), when destroying the Resolver Endpoint (`default = {}`)
- `enable_dns_resolver` - Enable dns resolver usages (`default = False`)
- `dns_resolver_resolver_id` - The OCID of the target resolver. (`default = ""`)
- `dns_resolver_scope` - (Optional) Specifies to operate only on resources that have a matching DNS scope. (`default = null`)
- `dns_resolver_display_name` - (Optional) (Updatable) The display name of the resolver. (`default = ""`)
- `dns_resolver_attached_views` - (Optional) (Updatable) The attached views. Views are evaluated in order. (`default = []`)
- `dns_resolver_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `dns_resolver_rules` - (Optional) (Updatable) Rules for the resolver. Rules are evaluated in order. (`default = []`)
- `dns_resolver_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Resolver * update - (Defaults to 20 minutes), when updating the Resolver * delete - (Defaults to 20 minutes), when destroying the Resolver (`default = []`)

## Module Output Variables
----------------------
- `dns_record_id` - The ID of DNS record
- `dns_record_domain` - The fully qualified domain name where the record can be located.
- `dns_record_compartment_id` - The OCID of the compartment the resource belongs to.
- `dns_record_zone_name_or_id` - The name or OCID of the target zone.
- `dns_record_ttl` - The Time To Live for the record, in seconds. Using a TTL lower than 30 seconds is not recommended.
- `dns_record_rtype` - The canonical name for the record's type, such as A or CNAME. For more information, see Resource Record (RR) TYPEs.
- `dns_record_is_protected` - A Boolean flag indicating whether or not parts of the record are unable to be explicitly managed.
- `dns_record_rdata` - The record's data, as whitespace-delimited tokens in type-specific presentation format. All RDATA is normalized and the returned presentation of your RDATA may differ from its initial input. For more information about RDATA, see Supported DNS Resource Record Types
- `dns_record_record_hash` - A unique identifier for the record within its zone.
- `dns_record_rrset_version` - The latest version of the record's zone in which its RRSet differs from the preceding version.
- `dns_zone_id` - ID of DNS zone
- `dns_zone_compartment_id` - The OCID of the compartment containing the zone.
- `dns_zone_dnssec_state` - The state of DNSSEC on the zone.
- `dns_zone_external_downstreams` - External secondary servers for the zone. This field is currently not supported when zoneType is SECONDARY or scope is PRIVATE.
- `dns_zone_external_masters` - External master servers for the zone. externalMasters becomes a required parameter when the zoneType value is SECONDARY.
- `dns_zone_is_protected` - A Boolean flag indicating whether or not parts of the resource are unable to be explicitly managed.
- `dns_zone_name` - The name of the zone.
- `dns_zone_nameservers` - The authoritative nameservers for the zone.
- `dns_zone_scope` - The scope of the zone.
- `dns_zone_self` - The canonical absolute URL of the resource.
- `dns_zone_serial` - The current serial of the zone. As seen in the zone's SOA record.
- `dns_zone_state` - The current state of the zone resource.
- `dns_zone_version` - Version is the never-repeating, totally-orderable, version of the zone, from which the serial field of the zone's SOA record is derived.
- `dns_zone_view_id` - The OCID of the private view containing the zone. This value will be null for zones in the global DNS, which are publicly resolvable and not part of a private view.
- `dns_zone_zone_transfer_servers` - The Oracle Cloud Infrastructure nameservers that transfer the zone data with external nameservers.
- `dns_zone_zone_type` - The type of the zone. Must be either PRIMARY or SECONDARY. SECONDARY is only supported for GLOBAL zones.
- `dns_view_compartment_id` - The OCID of the owning compartment.
- `dns_view_display_name` - The display name of the view.
- `dns_view_id` - The OCID of the view.
- `dns_view_is_protected` - A Boolean flag indicating whether or not parts of the resource are unable to be explicitly managed.
- `dns_view_self` - The canonical absolute URL of the resource.
- `dns_view_state` - The current state of the resource.
- `dns_tsig_key_id` - The OCID of the resource.
- `dns_tsig_key_name` - A globally unique domain name identifying the key for a given pair of hosts.
- `dns_tsig_key_secret` - A base64 string encoding the binary shared secret.
- `dns_tsig_key_self` - The canonical absolute URL of the resource.
- `dns_tsig_key_state` - The current state of the resource.
- `dns_tsig_key_algorithm` - TSIG key algorithms are encoded as domain names, but most consist of only one non-empty label, which is not required to be explicitly absolute. Applicable algorithms include: hmac-sha1, hmac-sha224, hmac-sha256, hmac-sha512. For more information on these algorithms, see RFC 4635.
- `dns_tsig_key_compartment_id` - The OCID of the compartment containing the TSIG key.
- `dns_steering_policy_id` - The OCID of the resource.
- `dns_steering_policy_rules` - The series of rules that will be processed in sequence to reduce the pool of answers to a response for any given request.
- `dns_steering_policy_self` - The canonical absolute URL of the resource.
- `dns_steering_policy_state` - The current state of the resource.
- `dns_steering_policy_template` - A set of predefined rules based on the desired purpose of the steering policy. Each template utilizes Traffic Management's rules in a different order to produce the desired results when answering DNS queries.
- `dns_steering_policy_ttl` - The Time To Live (TTL) for responses from the steering policy, in seconds. If not specified during creation, a value of 30 seconds will be used.
- `dns_steering_policy_compartment_id` - The OCID of the compartment containing the steering policy.
- `dns_steering_policy_display_name` - A user-friendly name for the steering policy. Does not have to be unique and can be changed. Avoid entering confidential information.
- `dns_steering_policy_health_check_monitor_id` - The OCID of the health check monitor providing health data about the answers of the steering policy. A steering policy answer with rdata matching a monitored endpoint will use the health data of that endpoint. A steering policy answer with rdata not matching any monitored endpoint will be assumed healthy.
- `dns_steering_policy_attachment_id` - The OCID of the resource.
- `dns_steering_policy_attachment_display_name` - A user-friendly name for the steering policy attachment. Does not have to be unique and can be changed. Avoid entering confidential information.
- `dns_steering_policy_attachment_domain_name` - The attached domain within the attached zone.
- `dns_steering_policy_attachment_compartment_id` - The OCID of the compartment containing the steering policy attachment.
- `dns_steering_policy_attachment_rtypes` - The record types covered by the attachment at the domain. The set of record types is determined by aggregating the record types from the answers defined in the steering policy.
- `dns_steering_policy_attachment_self` - The canonical absolute URL of the resource.
- `dns_steering_policy_attachment_state` - The current state of the resource.
- `dns_steering_policy_attachment_steering_policy_id` - The OCID of the attached steering policy.
- `dns_steering_policy_attachment_zone_id` - The OCID of the attached zone.
- `dns_action_create_zone_from_zone_file_id` - The OCID of the zone.
- `dns_action_create_zone_from_zone_file_is_protected` - A Boolean flag indicating whether or not parts of the resource are unable to be explicitly managed.
- `dns_action_create_zone_from_zone_file_name` - The name of the zone.
- `dns_action_create_zone_from_zone_file_nameservers` - The authoritative nameservers for the zone.
- `dns_action_create_zone_from_zone_file_scope` - The scope of the zone.
- `dns_action_create_zone_from_zone_file_self` - The canonical absolute URL of the resource.
- `dns_action_create_zone_from_zone_file_serial` - The current serial of the zone. As seen in the zone's SOA record.
- `dns_action_create_zone_from_zone_file_state` - The current state of the zone resource.
- `dns_action_create_zone_from_zone_file_version` - Version is the never-repeating, totally-orderable, version of the zone, from which the serial field of the zone's SOA record is derived.
- `dns_action_create_zone_from_zone_file_view_id` - The OCID of the private view containing the zone. This value will be null for zones in the global DNS, which are publicly resolvable and not part of a private view.
- `dns_action_create_zone_from_zone_file_zone_type` - The type of the zone. Must be either PRIMARY or SECONDARY. SECONDARY is only supported for GLOBAL zones.
- `dns_rrset_id` - ID of DNS rrset
- `dns_rrset_items` - Items of DNS rrset
- `dns_resolver_id` - The OCID of the resolver.
- `dns_resolver_is_protected` - A Boolean flag indicating whether or not parts of the resource are unable to be explicitly managed.
- `dns_resolver_self` - The canonical absolute URL of the resource.
- `dns_resolver_state` - The current state of the resource.
- `dns_resolver_attached_vcn_id` - The OCID of the attached VCN.
- `dns_resolver_rules` - Rules for the resolver. Rules are evaluated in order.
- `dns_resolver_default_view_id` - The OCID of the default view.
- `dns_resolver_attached_views` - The attached views. Views are evaluated in order.
- `dns_resolver_compartment_id` - The OCID of the owning compartment.
- `dns_resolver_endpoint_id` - ID of DNS resolver endpoint
- `dns_resolver_endpoint_name` - The name of the resolver endpoint. Must be unique, case-insensitive, within the resolver.
- `dns_resolver_endpoint_subnet_id` - The OCID of a subnet. Must be part of the VCN that the resolver is attached to.
- `dns_resolver_endpoint_state` - The current state of the resource.
- `dns_resolver_endpoint_self` - The canonical absolute URL of the resource.
- `dns_resolver_endpoint_nsg_ids` - An array of network security group OCIDs for the resolver endpoint. These must be part of the VCN that the resolver endpoint is a part of.
- `dns_resolver_endpoint_compartment_id` - The OCID of the owning compartment. This will match the resolver that the resolver endpoint is under and will be updated if the resolver's compartment is changed.
- `dns_resolver_endpoint_endpoint_type` - The type of resolver endpoint. VNIC is currently the only supported type.
- `dns_resolver_endpoint_forwarding_address` - An IP address from which forwarded queries may be sent. For VNIC endpoints, this IP address must be part of the subnet and will be assigned by the system if unspecified when isForwarding is true.
- `dns_resolver_endpoint_is_forwarding` - A Boolean flag indicating whether or not the resolver endpoint is for forwarding.
- `dns_resolver_endpoint_is_listening` - A Boolean flag indicating whether or not the resolver endpoint is for listening.
- `dns_resolver_endpoint_listening_address` - An IP address to listen to queries on. For VNIC endpoints this IP address must be part of the subnet and will be assigned by the system if unspecified when isListening is true.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
