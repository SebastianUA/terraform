variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "location" {
  description = "The Google Cloud Platform location for the KeyRing. A full list of valid locations can be found by running gcloud kms locations list."
  default     = "us-east1"    
} 

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "project" {
    description = "The project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "enable_kms_key_ring" {
    description = "Enable KMS key ring. Default - false"
    default     = "false"
}

variable "enable_kms_crypto_key_iam_binding" {
    description = "Enable KMS crypto key iam binding. Default -false"
    default     = "false"
}

variable "crypto_key_id" {
    description = "The crypto key ID, in the form {project_id}/{location_name}/{key_ring_name}/{crypto_key_name} or {location_name}/{key_ring_name}/{crypto_key_name}. In the second form, the provider's project setting will be used as a fallback."
    default     = ""
}

variable "role" {
    description = "The role that should be applied. Only one google_kms_crypto_key_iam_binding can be used per role. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}."
    default     = "roles/editor"
}

variable "members" {
    description = "(Required) A list of users that the role should apply to."
    default     = []
}

variable "enable_kms_crypto_key" {
    description = "Enable KMS crypto key"
    default     = ""
}

variable "key_ring" {
    description = "(Required) The id of the Google Cloud Platform KeyRing to which the key shall belong."
    default     = ""
}

variable "rotation_period" {
    description = "(Optional) Every time this period passes, generate a new CryptoKeyVersion and set it as the primary. The first rotation will take place after the specified period. The rotation period has the format of a decimal number with up to 9 fractional digits, followed by the letter s (seconds). It must be greater than a day (ie, 83400)."
    default     = "86400s"
}

variable "enable_kms_crypto_key_iam_member" {
    description = "Enable KMS crypto key iam member. Default -false"
    default     = "false"
}

variable "kms_crypto_key_iam_member" {
    description = "(Required) The user that the role should apply to."
    default     = ""
}

variable "enable_kms_key_ring_iam_policy" {
    description = "Enable KMS key ring iam policy. Default - false"
    default     = "false"
}

variable "key_ring_id" {
    description = "(Required) The key ring ID, in the form {project_id}/{location_name}/{key_ring_name} or {location_name}/{key_ring_name}. In the second form, the provider's project setting will be used as a fallback."
    default     = ""
}
