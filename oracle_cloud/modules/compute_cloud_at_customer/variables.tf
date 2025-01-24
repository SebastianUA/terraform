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

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# compute cloud at customer ccc infrastructure
#-----------------------------------------------------------
variable "enable_ccc_infrastructure" {
  description = "Enable ccc infrastructure usage"
  default     = false
}

variable "ccc_infrastructure_compartment_id" {
  description = "(Required) (Updatable) The compartment OCID associated with the infrastructure."
  default     = null
}

variable "ccc_infrastructure_display_name" {
  description = "(Required) (Updatable) The name that will be used to display the Compute Cloud@Customer infrastructure in the Oracle Cloud Infrastructure console. Does not have to be unique and can be changed. Avoid entering confidential information."
  default     = ""
}

variable "ccc_infrastructure_subnet_id" {
  description = "(Required) (Updatable) Identifier for network subnet that will be used to communicate with Compute Cloud@Customer infrastructure."
  default     = null
}

variable "ccc_infrastructure_description" {
  description = "(Optional) (Updatable) A mutable client-meaningful text description of the Compute Cloud@Customer infrastructure. Avoid entering confidential information."
  default     = null
}

variable "ccc_infrastructure_ccc_upgrade_schedule_id" {
  description = "(Optional) (Updatable) Schedule used for upgrades. If no schedule is associated with the infrastructure, it can be upgraded at any time."
  default     = null
}

variable "ccc_infrastructure_connection_details" {
  description = "(Optional) (Updatable) A message describing the current connection state in more detail."
  default     = null
}

variable "ccc_infrastructure_connection_state" {
  description = "(Optional) (Updatable) The current connection state of the Compute Cloud@Customer infrastructure. This value will default to REJECT if the value is not provided. The only valid value at creation time is REJECT."
  default     = null
}

variable "ccc_infrastructure_defined_tags" {
  description = "(Optional) (Updatable) Simple key-value pair that is applied without any predefined name, type or scope. Exists for cross-compatibility only. Example: {'bar-key': 'value'}"
  default     = {}
}

variable "ccc_infrastructure_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Ccc Infrastructure * update - (Defaults to 20 minutes), when updating the Ccc Infrastructure * delete - (Defaults to 20 minutes), when destroying the Ccc Infrastructure"
  default     = {}
}

#-----------------------------------------------------------
# compute cloud at customer ccc upgrade schedule
#-----------------------------------------------------------
variable "enable_ccc_upgrade_schedule" {
  description = "Enable ccc upgrade schedule usages"
  default     = false
}

variable "ccc_upgrade_schedule_compartment_id" {
  description = "(Required) (Updatable) Compartment OCID for the Compute Cloud@Customer Upgrade Schedule."
  default     = null
}

variable "ccc_upgrade_schedule_display_name" {
  description = "(Updatable) Compute Cloud@Customer upgrade schedule display name. Avoid entering confidential information."
  default     = ""
}

variable "ccc_upgrade_schedule_events" {
  description = "(Required) (Updatable) List of preferred times for Compute Cloud@Customer infrastructure to be upgraded."
  default     = []
}

variable "ccc_upgrade_schedule_descriptions" {
  description = "(Optional) (Updatable) An optional description of the Compute Cloud@Customer upgrade schedule. Avoid entering confidential information."
  default     = null
}

variable "ccc_upgrade_schedule_defined_tags" {
  description = "(Optional) (Updatable) Simple key-value pair that is applied without any predefined name, type or scope. Exists for cross-compatibility only. Example: {'bar-key': 'value'}"
  default     = {}
}

variable "ccc_upgrade_schedule_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Ccc Upgrade Schedule * update - (Defaults to 20 minutes), when updating the Ccc Upgrade Schedule * delete - (Defaults to 20 minutes), when destroying the Ccc Upgrade Schedule"
  default     = {}
}
