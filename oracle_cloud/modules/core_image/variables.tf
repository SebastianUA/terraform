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
# core image
#-----------------------------------------------------------
variable "enable_core_image" {
  description = "Enable core image usages"
  default     = false
}

variable "core_image_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment you want the image to be created in."
  default     = ""
}

variable "core_image_display_name" {
  description = "(Optional) (Updatable) A user-friendly name for the image. It does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = ""
}

variable "core_image_launch_mode" {
  description = "(Optional) Specifies the configuration mode for launching virtual machine (VM) instances."
  default     = null
}

variable "core_image_instance_id" {
  description = "(Optional) The OCID of the instance you want to use as the basis for the image."
  default     = null
}

variable "core_image_image_source_details" {
  description = "(Optional) - Set source details for image"
  default     = []
}

variable "core_image_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_image_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 2 hours), when creating the Image * update - (Defaults to 2 hours), when updating the Image * delete - (Defaults to 2 hours), when destroying the Image"
  default     = {}
}

#-----------------------------------------------------------
# core shape management
#-----------------------------------------------------------
variable "enable_core_shape_management" {
  description = "Enable core shape management usages"
  default     = false
}

variable "core_shape_management_compartment_id" {
  description = "(Required) The OCID of the compartment containing the image."
  default     = null
}

variable "core_shape_management_image_id" {
  description = "The OCID of the Image to which the shape should be added."
  default     = ""
}

variable "core_shape_management_shape_name" {
  description = "(Required) The compatible shape that is to be added to the compatible shapes list for the image."
  default     = null
}

#-----------------------------------------------------------
# core compute image capability schema
#-----------------------------------------------------------
variable "enable_core_compute_image_capability_schema" {
  description = "Enable core compute image capability schema usages"
  default     = false
}

variable "core_compute_image_capability_schema_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment that contains the resource."
  default     = null
}

variable "core_compute_image_capability_schema_compute_global_image_capability_schema_version_name" {
  description = "(Required) The name of the compute global image capability schema version"
  default     = null
}

variable "core_compute_image_capability_schema_image_id" {
  description = "The ocid of the image"
  default     = ""
}

variable "core_compute_image_capability_schema_schema_data" {
  description = "(Required) (Updatable) The map of each capability name to its ImageCapabilitySchemaDescriptor."
  default     = {}
}

variable "core_compute_image_capability_schema_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_compute_image_capability_schema_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "core_compute_image_capability_schema_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Compute Image Capability Schema * update - (Defaults to 20 minutes), when updating the Compute Image Capability Schema * delete - (Defaults to 20 minutes), when destroying the Compute Image Capability Schema"
  default     = {}
}

#-----------------------------------------------------------
# core app catalog subscription
#-----------------------------------------------------------
variable "enable_core_app_catalog_subscription" {
  description = "Enable core app catalog subscription usages"
  default     = false
}

variable "core_app_catalog_subscription_compartment_id" {
  description = "(Required) The compartmentID for the subscription."
  default     = null
}

variable "core_app_catalog_subscription_listing_id" {
  description = "(Required) The OCID of the listing."
  default     = null
}

variable "core_app_catalog_subscription_listing_resource_version" {
  description = "(Required) Listing resource version."
  default     = null
}

variable "core_app_catalog_subscription_oracle_terms_of_use_link" {
  description = "(Required) Oracle TOU link"
  default     = null
}

variable "core_app_catalog_subscription_signature" {
  description = "(Required) A generated signature for this listing resource version retrieved the agreements API."
  default     = null
}

variable "core_app_catalog_subscription_time_retrieved" {
  description = "(Required) Date and time the agreements were retrieved, in RFC3339 format. Example: 2018-03-20T12:32:53.532Z"
  default     = null
}

variable "core_app_catalog_subscription_eula_link" {
  description = "(Optional) EULA link"
  default     = null
}

variable "core_app_catalog_subscription_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the App Catalog Subscription * update - (Defaults to 20 minutes), when updating the App Catalog Subscription * delete - (Defaults to 20 minutes), when destroying the App Catalog Subscription"
  default     = {}
}

#-----------------------------------------------------------
# core app catalog listing resource version agreement
#-----------------------------------------------------------
variable "enable_core_app_catalog_listing_resource_version_agreement" {
  description = "Enable core app catalog listing resource version agreement usages"
  default     = false
}

variable "core_app_catalog_listing_resource_version_agreement_listing_id" {
  description = "(Required) The OCID of the listing."
  default     = null
}

variable "core_app_catalog_listing_resource_version_agreement_listing_resource_version" {
  description = "(Required) Listing Resource Version."
  default     = null
}
