variable "name" {
    description = "Name of the resource. Provided by the client when the resource is created. The name must be 1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash."
    default     = "TEST"
}

variable "zone" {
  description = "The zone that the machine should be created in"
  default     = "us-east1-b"    
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
    description = "An optional description of this resource. Provide this property when you create the resource."
    default     = ""
}

variable "size" {
    description = "Size of the persistent disk, specified in GB. You can specify this field when creating a persistent disk using the sourceImage or sourceSnapshot parameter, or specify it alone to create an empty persistent disk."
    default     = "10" 
}

variable "type" {
    description = "URL of the disk type resource describing which disk type to use to create the disk. Provide this when creating the disk.The GCE disk type. May be set to pd-standard or pd-ssd."
    default     = "pd-ssd"
}

variable "image" {
    description = "The image from which to initialize this disk. This can be one of: the image's self_link, projects/{project}/global/images/{image}, projects/{project}/global/images/family/{family}, global/images/{image}, global/images/family/{family}, family/{family}, {project}/{family}, {project}/{image}, {family}, or {image}. If referred by family, the images names must include the family name."
    default     = "centos-7"
}

variable "disk_encryption_key_raw_key" {
    description = "Specifies a 256-bit customer-supplied encryption key, encoded in RFC 4648 base64 to either encrypt or decrypt this resource. * sha256 - The RFC 4648 base64 encoded SHA-256 hash of the customer-supplied encryption key that protects this resource."
    default     = ""
}

variable "source_image_encryption_key_raw_key" {
    description = "Specifies a 256-bit customer-supplied encryption key, encoded in RFC 4648 base64 to either encrypt or decrypt this resource. * sha256 - The RFC 4648 base64 encoded SHA-256 hash of the customer-supplied encryption key that protects this resource."
    default     = ""
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
   
