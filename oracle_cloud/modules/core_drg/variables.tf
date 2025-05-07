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
# core drg
#-----------------------------------------------------------
variable "enable_core_drg" {
  description = "Enable core drg usages"
  default     = false
}

variable "core_drg_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = ""
}

variable "core_drg_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_drg_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg * update - (Defaults to 20 minutes), when updating the Drg * delete - (Defaults to 20 minutes), when destroying the Drg"
  default     = {}
}

#-----------------------------------------------------------
# drg attachments list
#-----------------------------------------------------------
variable "enable_core_drg_attachments_list" {
  description = "Enable core drg attachments list usages"
  default     = false
}

variable "core_drg_attachments_list_drg_id" {
  description = "The OCID of the DRG."
  default     = ""
}

variable "core_drg_attachments_list_attachment_type" {
  description = "(Optional) The type for the network resource attached to the DRG."
  default     = null
}

variable "core_drg_attachments_list_is_cross_tenancy" {
  description = "(Optional) Whether the DRG attachment lives in a different tenancy than the DRG."
  default     = null
}

variable "core_drg_attachments_list_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg Attachments List * update - (Defaults to 20 minutes), when updating the Drg Attachments List * delete - (Defaults to 20 minutes), when destroying the Drg Attachments List"
  default     = {}
}

#-----------------------------------------------------------
# drg route distribution
#-----------------------------------------------------------
variable "enable_drg_route_distribution" {
  description = "Enable drg route distribution usages"
  default     = false
}

variable "drg_route_distribution_distribution_type" {
  description = "Required) Whether this distribution defines how routes get imported into route tables or exported through DRG attachments."
  default     = null
}

variable "drg_route_distribution_drg_id" {
  description = "The OCID of the DRG the DRG route table belongs to."
  default     = ""
}

variable "drg_route_distribution_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = ""
}

variable "drg_route_distribution_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "drg_route_distribution_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg Route Distribution * update - (Defaults to 20 minutes), when updating the Drg Route Distribution * delete - (Defaults to 20 minutes), when destroying the Drg Route Distribution"
  default     = {}
}

#-----------------------------------------------------------
# core drg route distribution statement
#-----------------------------------------------------------
variable "enable_core_drg_route_distribution_statement" {
  description = "Enable core drg route distribution statement usages"
  default     = false
}

variable "core_drg_route_distribution_statement_drg_route_distribution_id" {
  description = "The OCID of the route distribution."
  default     = ""
}

variable "core_drg_route_distribution_statement_action" {
  description = "(Required) Accept: import/export the route 'as is'"
  default     = null
}

variable "core_drg_route_distribution_statement_priority" {
  description = "(Required) (Updatable) This field is used to specify the priority of each statement in a route distribution. The priority will be represented as a number between 0 and 65535 where a lower number indicates a higher priority. When a route is processed, statements are applied in the order defined by their priority. The first matching rule dictates the action that will be taken on the route."
  default     = null
}

variable "core_drg_route_distribution_statement_match_criteria" {
  description = "(Required) (Updatable) The action is applied only if all of the match criteria are met. MATCH_ALL match type implies any input is considered a match. * attachment_type - (Required when match_type=DRG_ATTACHMENT_TYPE) The type of the network resource to be included in this match. A match for a network type implies that all DRG attachments of that type insert routes into the table. *"
  default     = {}
}

variable "core_drg_route_distribution_statement_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg Route Distribution Statement * update - (Defaults to 20 minutes), when updating the Drg Route Distribution Statement * delete - (Defaults to 20 minutes), when destroying the Drg Route Distribution Statement"
  default     = {}
}

#-----------------------------------------------------------
# core drg attachment
#-----------------------------------------------------------
variable "enable_core_drg_attachment" {
  description = "Enable core drg attachment usages"
  default     = false
}

variable "core_drg_attachment_drg_id" {
  description = "The OCID of the DRG."
  default     = ""
}

variable "core_drg_attachment_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = ""
}

variable "core_drg_attachment_drg_route_table_id" {
  description = "Optional) (Updatable) The OCID of the DRG route table that is assigned to this attachment."
  default     = ""
}

variable "core_drg_attachment_network_details" {
  description = "(Optional) (Updatable) - Setting for DRG network details"
  default     = []
}

variable "core_drg_attachment_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "core_drg_attachment_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg Attachment * update - (Defaults to 20 minutes), when updating the Drg Attachment * delete - (Defaults to 20 minutes), when destroying the Drg Attachment"
  default     = {}
}

#-----------------------------------------------------------
# core drg attachment management
#-----------------------------------------------------------
variable "enable_core_drg_attachment_management" {
  description = "Enable core drg attachment management usages"
  default     = false
}

variable "core_drg_attachment_management_attachment_type" {
  description = "(Required) The type for the network resource attached to the DRG."
  default     = null
}

variable "core_drg_attachment_management_network_id" {
  description = "(Optional) The OCID of the resource (virtual circuit, VCN, IPSec tunnel, or remote peering connection) attached to the DRG."
  default     = null
}

variable "core_drg_attachment_management_drg_id" {
  description = "(Required) The OCID of the DRG."
  default     = ""
}

variable "core_drg_attachment_management_display_name" {
  description = "(Optional)(Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_drg_attachment_management_drg_route_table_id" {
  description = "(Optional)(Updatable) The OCID of the DRG route table assigned to the DRG attachment."
  default     = null
}

#-----------------------------------------------------------
# core drg route table
#-----------------------------------------------------------
variable "enable_core_drg_route_table" {
  description = "enable core drg route table usages"
  default     = false
}

variable "core_drg_route_table_drg_id" {
  description = "The OCID of the DRG the DRG route table belongs to."
  default     = ""
}

variable "core_drg_route_table_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_drg_route_table_import_drg_route_distribution_id" {
  description = "(Optional) (Updatable) The OCID of the import route distribution used to specify how incoming route advertisements through referenced attachments are inserted into the DRG route table."
  default     = null
}

variable "core_drg_route_table_is_ecmp_enabled" {
  description = "(Optional) (Updatable) If you want traffic to be routed using ECMP across your virtual circuits or IPSec tunnels to your on-premises networks, enable ECMP on the DRG route table."
  default     = null
}

variable "core_drg_route_table_remove_import_trigger" {
  description = "(Optional) (Updatable) An optional property when flipped disables the import of route Distribution by setting import_drg_route_distribution_id to null."
  default     = null
}

variable "core_drg_route_table_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "core_drg_route_table_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg Route Table * update - (Defaults to 20 minutes), when updating the Drg Route Table * delete - (Defaults to 20 minutes), when destroying the Drg Route Table"
  default     = {}
}

#-----------------------------------------------------------
# core drg route table route rule
#-----------------------------------------------------------
variable "enable_core_drg_route_table_route_rule" {
  description = "Enable core drg route table route rule usages"
  default     = false
}

variable "core_drg_route_table_route_rule_drg_route_table_id" {
  description = "The OCID of the DRG route table."
  default     = ""
}

variable "core_drg_route_table_route_rule_destination" {
  description = "(Required) (Updatable) This is the range of IP addresses used for matching when routing traffic. Only CIDR_BLOCK values are allowed."
  default     = null
}

variable "core_drg_route_table_route_rule_destination_type" {
  description = "(Required) Type of destination for the rule. Required if direction = EGRESS. "
  default     = null
}

variable "core_drg_route_table_route_rule_next_hop_drg_attachment_id" {
  description = "The OCID of the next hop DRG attachment. The next hop DRG attachment is responsible for reaching the network destination."
  default     = ""
}

variable "core_drg_route_table_route_rule_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Drg Route Table Route Rule * update - (Defaults to 20 minutes), when updating the Drg Route Table Route Rule * delete - (Defaults to 20 minutes), when destroying the Drg Route Table Route Rule"
  default     = {}
}
