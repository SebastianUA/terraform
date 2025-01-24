# provider identity parameters
variable "provider_oci_fingerprint" {
  type        = string
  description = "fingerprint of oci api private key"
  default     = null
}

variable "provider_oci_private_key_path" {
  type        = string
  description = "path to oci api private key used"
  default     = null
}

variable "provider_oci_region" {
  type = string
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "the oci region where resources will be created"
  default     = null
}

variable "provider_oci_tenancy_ocid" {
  type        = string
  description = "tenancy id where to create the sources"
  default     = null
}

variable "provider_oci_user_ocid" {
  type        = string
  description = "id of user that terraform will use to create the resources"
  default     = null
}

variable "provider_oci_config_file" {
  type        = string
  description = "Set path of config for provider OCI"
  default     = "~/.oci/config"
}

variable "provider_oci_profile" {
  type        = string
  description = "Set alias for provider"
  default     = "DEFAULT"
}
