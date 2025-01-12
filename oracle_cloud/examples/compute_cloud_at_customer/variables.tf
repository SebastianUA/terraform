# provider identity parameters
variable "provider_oci_fingerprint" {
  type        = string
  description = "fingerprint of oci api private key"
  default     = ""
}

variable "provider_oci_private_key_path" {
  type        = string
  description = "path to oci api private key used"
  default     = ""
}

variable "provider_oci_region" {
  type = string
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "the oci region where resources will be created"
  default     = ""
}

variable "provider_oci_tenancy_ocid" {
  type        = string
  description = "tenancy id where to create the sources"
  default     = ""
}

variable "provider_oci_user_ocid" {
  type        = string
  description = "id of user that terraform will use to create the resources"
  default     = ""
}

variable "provider_oci_alias" {
  type        = string
  description = "Set alias for provider"
  default     = ""
}
