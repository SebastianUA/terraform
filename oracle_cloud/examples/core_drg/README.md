# Work with CORE_DRG via terraform

A terraform module for making CORE_DRG.


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

module "core_drg" {
  source = "../../modules/core_drg"

  enable_core_drg         = true
  core_drg_compartment_id = ""
  core_drg_display_name   = ""

  tags = {}
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_core_drg` - Enable core drg usages (`default = False`)
- `core_drg_compartment_id` - (Required) (Updatable) The OCID of the compartment to contain the DRG. (`default = null`)
- `core_drg_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = ""`)
- `core_drg_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_drg_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg * update - (Defaults to 20 minutes), when updating the Drg * delete - (Defaults to 20 minutes), when destroying the Drg (`default = {}`)
- `enable_core_drg_attachments_list` - Enable core drg attachments list usages (`default = False`)
- `core_drg_attachments_list_drg_id` - The OCID of the DRG. (`default = ""`)
- `core_drg_attachments_list_attachment_type` - (Optional) The type for the network resource attached to the DRG. (`default = null`)
- `core_drg_attachments_list_is_cross_tenancy` - (Optional) Whether the DRG attachment lives in a different tenancy than the DRG. (`default = null`)
- `core_drg_attachments_list_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg Attachments List * update - (Defaults to 20 minutes), when updating the Drg Attachments List * delete - (Defaults to 20 minutes), when destroying the Drg Attachments List (`default = {}`)
- `enable_drg_route_distribution` - Enable drg route distribution usages (`default = False`)
- `drg_route_distribution_distribution_type` - Required) Whether this distribution defines how routes get imported into route tables or exported through DRG attachments. (`default = null`)
- `drg_route_distribution_drg_id` - The OCID of the DRG the DRG route table belongs to. (`default = ""`)
- `drg_route_distribution_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = ""`)
- `drg_route_distribution_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `drg_route_distribution_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg Route Distribution * update - (Defaults to 20 minutes), when updating the Drg Route Distribution * delete - (Defaults to 20 minutes), when destroying the Drg Route Distribution (`default = {}`)
- `enable_core_drg_route_distribution_statement` - Enable core drg route distribution statement usages (`default = False`)
- `core_drg_route_distribution_statement_drg_route_distribution_id` - The OCID of the route distribution. (`default = ""`)
- `core_drg_route_distribution_statement_action` - (Required) Accept: import/export the route 'as is' (`default = null`)
- `core_drg_route_distribution_statement_priority` - (Required) (Updatable) This field is used to specify the priority of each statement in a route distribution. The priority will be represented as a number between 0 and 65535 where a lower number indicates a higher priority. When a route is processed, statements are applied in the order defined by their priority. The first matching rule dictates the action that will be taken on the route. (`default = null`)
- `core_drg_route_distribution_statement_match_criteria` - (Required) (Updatable) The action is applied only if all of the match criteria are met. MATCH_ALL match type implies any input is considered a match. * attachment_type - (Required when match_type=DRG_ATTACHMENT_TYPE) The type of the network resource to be included in this match. A match for a network type implies that all DRG attachments of that type insert routes into the table. * (`default = {}`)
- `core_drg_route_distribution_statement_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg Route Distribution Statement * update - (Defaults to 20 minutes), when updating the Drg Route Distribution Statement * delete - (Defaults to 20 minutes), when destroying the Drg Route Distribution Statement (`default = {}`)
- `enable_core_drg_attachment` - Enable core drg attachment usages (`default = False`)
- `core_drg_attachment_drg_id` - The OCID of the DRG. (`default = ""`)
- `core_drg_attachment_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = ""`)
- `core_drg_attachment_drg_route_table_id` - Optional) (Updatable) The OCID of the DRG route table that is assigned to this attachment. (`default = ""`)
- `core_drg_attachment_network_details` - (Optional) (Updatable) - Setting for DRG network details (`default = []`)
- `core_drg_attachment_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `core_drg_attachment_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg Attachment * update - (Defaults to 20 minutes), when updating the Drg Attachment * delete - (Defaults to 20 minutes), when destroying the Drg Attachment (`default = {}`)
- `enable_core_drg_attachment_management` - Enable core drg attachment management usages (`default = False`)
- `core_drg_attachment_management_attachment_type` - (Required) The type for the network resource attached to the DRG. (`default = null`)
- `core_drg_attachment_management_compartment_id` - (Required) The OCID of the compartment. (`default = null`)
- `core_drg_attachment_management_network_id` - (Optional) The OCID of the resource (virtual circuit, VCN, IPSec tunnel, or remote peering connection) attached to the DRG. (`default = null`)
- `core_drg_attachment_management_drg_id` - (Required) The OCID of the DRG. (`default = ""`)
- `core_drg_attachment_management_display_name` - (Optional)(Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_drg_attachment_management_drg_route_table_id` - (Optional)(Updatable) The OCID of the DRG route table assigned to the DRG attachment. (`default = null`)
- `enable_core_drg_route_table` - enable core drg route table usages (`default = False`)
- `core_drg_route_table_drg_id` - The OCID of the DRG the DRG route table belongs to. (`default = ""`)
- `core_drg_route_table_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_drg_route_table_import_drg_route_distribution_id` - (Optional) (Updatable) The OCID of the import route distribution used to specify how incoming route advertisements through referenced attachments are inserted into the DRG route table. (`default = null`)
- `core_drg_route_table_is_ecmp_enabled` - (Optional) (Updatable) If you want traffic to be routed using ECMP across your virtual circuits or IPSec tunnels to your on-premises networks, enable ECMP on the DRG route table. (`default = null`)
- `core_drg_route_table_remove_import_trigger` - (Optional) (Updatable) An optional property when flipped disables the import of route Distribution by setting import_drg_route_distribution_id to null. (`default = null`)
- `core_drg_route_table_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `core_drg_route_table_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg Route Table * update - (Defaults to 20 minutes), when updating the Drg Route Table * delete - (Defaults to 20 minutes), when destroying the Drg Route Table (`default = {}`)
- `enable_core_drg_route_table_route_rule` - Enable core drg route table route rule usages (`default = False`)
- `core_drg_route_table_route_rule_drg_route_table_id` - The OCID of the DRG route table. (`default = ""`)
- `core_drg_route_table_route_rule_destination` - (Required) (Updatable) This is the range of IP addresses used for matching when routing traffic. Only CIDR_BLOCK values are allowed. (`default = null`)
- `core_drg_route_table_route_rule_destination_type` - (Required) Type of destination for the rule. Required if direction = EGRESS.  (`default = null`)
- `core_drg_route_table_route_rule_next_hop_drg_attachment_id` - The OCID of the next hop DRG attachment. The next hop DRG attachment is responsible for reaching the network destination. (`default = ""`)
- `core_drg_route_table_route_rule_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg Route Table Route Rule * update - (Defaults to 20 minutes), when updating the Drg Route Table Route Rule * delete - (Defaults to 20 minutes), when destroying the Drg Route Table Route Rule (`default = {}`)

## Module Output Variables
----------------------
- `core_drg_id` - The DRG's Oracle ID (OCID).
- `core_drg_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_drg_redundancy_status` - The redundancy status of the DRG specified.
- `core_drg_state` - The DRG's current state.
- `core_drg_default_export_drg_route_distribution_id` - The OCID of this DRG's default export route distribution for the DRG attachments.
- `core_drg_compartment_id` - The OCID of the compartment containing the DRG.
- `core_drg_default_drg_route_tables` - The default DRG route table for this DRG. Each network type has a default DRG route table.
- `core_drg_attachments_list_id` - The Oracle-assigned ID of the DRG attachment
- `core_drg_attachments_list_drg_all_attachments` - The list of drg_attachments.
- `core_drg_route_distribution_id` - The route distribution's Oracle ID (OCID).
- `core_drg_route_distribution_compartment_id` - The OCID of the compartment containing the route distribution.
- `core_drg_route_distribution_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_drg_route_distribution_distribution_type` - Whether this distribution defines how routes get imported into route tables or exported through DRG attachments.
- `core_drg_route_distribution_drg_id` - The OCID of the DRG that contains this route distribution.
- `core_drg_route_distribution_state` - The route distribution's current state.
- `core_drg_route_distribution_time_created` - The date and time the route distribution was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_drg_route_distribution_statement_id` - The Oracle-assigned ID of the route distribution statement.
- `core_drg_route_distribution_statement_action` - ACCEPT indicates the route should be imported or exported as-is.
- `core_drg_route_distribution_statement_match_criteria` - The action is applied only if all of the match criteria is met. If match type is MATCH_ALL, any input is considered a match.
- `core_drg_route_distribution_statement_priority` - This field specifies the priority of each statement in a route distribution. Priorities must be unique within a particular route distribution. The priority will be represented as a number between 0 and 65535 where a lower number indicates a higher priority. When a route is processed, statements are applied in the order defined by their priority. The first matching rule dictates the action that will be taken on the route.
- `core_drg_attachment_id` - The DRG attachment's Oracle ID (OCID).
- `core_drg_attachment_state` - The DRG attachment's current state.
- `core_drg_attachment_vcn_id` - The OCID of the VCN. This field is deprecated. Instead, use the networkDetails field to view the OCID of the attached resource.
- `core_drg_attachment_route_table_id` - The OCID of the route table the DRG attachment is using.
- `core_drg_attachment_is_cross_tenancy` - Indicates whether the DRG attachment and attached network live in a different tenancy than the DRG. Example: false
- `core_drg_attachment_network_details` - Output for network details
- `core_drg_attachment_compartment_id` - The OCID of the compartment containing the DRG attachment.
- `core_drg_attachment_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_drg_attachment_drg_id` - The OCID of the DRG.
- `core_drg_attachment_drg_route_table_id` - The OCID of the DRG route table that is assigned to this attachment.
- `core_drg_attachment_export_drg_route_distribution_id` - The OCID of the export route distribution used to specify how routes in the assigned DRG route table are advertised to the attachment. If this value is null, no routes are advertised through this attachment.
- `core_drg_attachment_management_route_table_id` - The OCID of the route table the DRG attachment is using.
- `core_drg_attachment_management_vcn_id` - The OCID of the VCN.
- `core_drg_attachment_management_export_drg_route_distribution_id` - The OCID of the export route distribution used to specify how routes in the assigned DRG route table are advertised to the attachment. If this value is null, no routes are advertised through this attachment.
- `core_drg_attachment_management_remove_export_drg_route_distribution_trigger` - An optional property when set to true during update disables the export of route Distribution by setting export_drg_route_distribution_id to null.
- `core_drg_attachment_management_is_cross_tenancy` - Indicates whether the DRG attachment and attached network live in a different tenancy than the DRG. Example: false
- `core_drg_attachment_management_state` - A filter to return only resources that match the specified lifecycle state. The value is case insensitive.
- `core_drg_attachment_management_network_details` - Outputs for DRG network details
- `core_drg_attachment_management_attachment_type` - The type for the network resource attached to the DRG.
- `core_drg_attachment_management_compartment_id` - The OCID of the compartment.
- `core_drg_attachment_management_network_id` - The OCID of the resource (virtual circuit, VCN, IPSec tunnel, or remote peering connection) attached to the DRG.
- `core_drg_attachment_management_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_drg_attachment_management_drg_id` - The OCID of the DRG.
- `core_drg_attachment_management_drg_route_table_id` - The OCID of the DRG route table assigned to the DRG attachment.
- `core_drg_route_table_id` - The OCID of the DRG route table.
- `core_drg_route_table_import_drg_route_distribution_id` - The OCID of the import route distribution used to specify how incoming route advertisements from referenced attachments are inserted into the DRG route table.
- `core_drg_route_table_is_ecmp_enabled` - If you want traffic to be routed using ECMP across your virtual circuits or IPSec tunnels to your on-premises network, enable ECMP on the DRG route table to which these attachments import routes.
- `core_drg_route_table_state` - The DRG route table's current state.
- `core_drg_route_table_compartment_id` - The OCID of the compartment the DRG is in. The DRG route table is always in the same compartment as the DRG.
- `core_drg_route_table_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_drg_route_table_drg_id` - The OCID of the DRG the DRG that contains this route table.
- `core_drg_route_table_route_rule_attributes` - Additional properties for the route, computed by the service.
- `core_drg_route_table_route_rule_destination` - Represents the range of IP addresses to match against when routing traffic.
- `core_drg_route_table_route_rule_destination_type` - The type of destination for the rule.
- `core_drg_route_table_route_rule_id` - The Oracle-assigned ID of the DRG route rule.
- `core_drg_route_table_route_rule_is_blackhole` - Indicates that if the next hop attachment does not exist, so traffic for this route is discarded without notification.
- `core_drg_route_table_route_rule_is_conflict` - Indicates that the route was not imported due to a conflict between route rules.
- `core_drg_route_table_route_rule_next_hop_drg_attachment_id` - The OCID of the next hop DRG attachment responsible for reaching the network destination.
- `core_drg_route_table_route_rule_route_provenance` - The earliest origin of a route. If a route is advertised to a DRG through an IPsec tunnel attachment, and is propagated to peered DRGs via RPC attachments, the route's provenance in the peered DRGs remains IPSEC_TUNNEL, because that is the earliest origin.
- `core_drg_route_table_route_rule_route_type` - You can specify static routes for the DRG route table using the API. The DRG learns dynamic routes from the DRG attachments using various routing protocols.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
