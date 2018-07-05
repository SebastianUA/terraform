variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "zone" {
  description = "The zone that the machine should be created in"
  default     = "us-east1-b"    
} 

variable "project" {
    description = "The project in which the resource belongs. If it is not provided, the provider project is used. If you are using a public base image, be sure to specify the correct Image Project."
    default     = ""
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "description" {
    description = "An optional description of this image."
    default     = ""
}

variable "family" {
    description = "The family name of the image."
    default     = "centos"
}

variable "source_disk" {
    description = "The URL of the source disk used to create this image."
    default     = ""
}

variable "raw_disk_source" {
    description = "The full Google Cloud Storage URL where the disk image is stored."
    default     = ""
}

variable "raw_disk_sha1" {
    description = "SHA1 checksum of the source tarball that will be used to verify the source before creating the image."
    default     = ""
}

variable "raw_disk_container_type" {
    description = "The format used to encode and transmit the block device. TAR is the only supported type and is the default."
    default     = "TAR"
}

variable "timeouts_create" {
    description = "Set timeouts for create.Default is 5 minutes."
    default     = "5m"
}

variable "timeouts_update" {
    description = "Set timeouts for update. Default is 4 minutes."
    default     = "4m"
}

variable "timeouts_delete" {
    description = "Set timeouts for delete. Default is 4 minutes."
    default     = "4m"
}

