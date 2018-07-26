variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
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

variable "zone" {
    description = "(Required) The zone where the source disk is located."
    default     = "us-east1-b"
}

variable "source_disk" {
    description = "(Required) The disk which will be used as the source of the snapshot."
    default     = ""
}

variable "source_disk_encryption_key_raw" {
    description = "(Optional) A 256-bit customer-supplied encryption key, encoded in RFC 4648 base64 to decrypt the source disk."
    default     = ""
}

variable "snapshot_encryption_key_raw" {
    description = "(Optional) A 256-bit customer-supplied encryption key, encoded in RFC 4648 base64 to encrypt this snapshot."
    default     = ""
}
