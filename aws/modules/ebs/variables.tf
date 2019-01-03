#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-ASG"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
} 

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}    

#-----------------------------------------------------------
# EBS
#-----------------------------------------------------------
variable "enable_ebs_volume" {
    description = "Enable EBS volume creating"
    default     = false
}

variable "availability_zone" {
    description = "(Required) The AZ where the EBS volume will exist."
    default     = ""
}

variable "availability_zones" {
    description = "Availability zones for AWS ASG"
    type        = "map"
    default     = {
        us-east-1      = "us-east-1b,us-east-1c,us-east-1d,us-east-1e"
        us-east-2      = "us-east-2a,eu-east-2b,eu-east-2c"
        us-west-1      = "us-west-1a,us-west-1c"
        us-west-2      = "us-west-2a,us-west-2b,us-west-2c"
        ca-central-1   = "ca-central-1a,ca-central-1b"
        eu-west-1      = "eu-west-1a,eu-west-1b,eu-west-1c"
        eu-west-2      = "eu-west-2a,eu-west-2b"
        eu-central-1   = "eu-central-1a,eu-central-1b,eu-central-1c"
        ap-south-1     = "ap-south-1a,ap-south-1b"
        sa-east-1      = "sa-east-1a,sa-east-1c"
        ap-northeast-1 = "ap-northeast-1a,ap-northeast-1c"
        ap-southeast-1 = "ap-southeast-1a,ap-southeast-1b"
        ap-southeast-2 = "ap-southeast-2a,ap-southeast-2b,ap-southeast-2c"
        ap-northeast-1 = "ap-northeast-1a,ap-northeast-1c"
        ap-northeast-2 = "ap-northeast-2a,ap-northeast-2c"
    }
}

variable "type" {
    description = "(Optional) The type of EBS volume. Can be 'standard', 'gp2', 'io1', 'sc1' or 'st1' (Default: 'standard')."
    default     = "standard"
}

variable "size" {
    description = "(Optional) The size of the drive in GiBs."
    default     = 8
}

variable "ebs_volume_encrypted" {
    description = "(Optional) If true, the disk will be encrypted."
    default     = false
}

variable "iops" {
    description = "(Optional) The amount of IOPS to provision for the disk."
    default     = 100
}

variable "snapshot_id" {
    description = "(Optional) A snapshot to base the EBS volume off of."
    default     = ""
}

variable "kms_key_id" {
    description = "(Optional) The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true."
    default     = ""
}

#-----------------------------------------------------------
# AWS EBS volume attachment
#-----------------------------------------------------------
variable "enable_ebs_volume_attachment" {
    description = "Enable ebs volume attachment usage"
    default     = false
}

variable "device_name" {
    description = "(Required) The device name to expose to the instance (for example, /dev/sdh or xvdh)"
    default     = "/dev/sdb"
}

variable "instance_id" {
    description = "(Required) ID of the Instance to attach to"
    default     = ""
}

variable "volume_id" {
    description = "(Required) ID of the Volume to be attached"
    default     = ""
}

variable "force_detach" {
    description = "(Optional, Boolean) Set to true if you want to force the volume to detach. Useful if previous attempts failed, but use this option only as a last resort, as this can result in data loss."
    default     = false
}

variable "skip_destroy" {
    description = "(Optional, Boolean) Set this to true if you do not wish to detach the volume from the instance to which it is attached at destroy time, and instead just remove the attachment from Terraform state. This is useful when destroying an instance which has volumes created by some other means attached." 
    default     = false
}

#-----------------------------------------------------------
# AWS EBS snapshop
#-----------------------------------------------------------

variable "enable_ebs_snapshot" {
    description = "Enable ebs snapshop for the volume"
    default     = false
}

variable "enable_ebs_snapshot_copy" {
    description = "Enable ebs snapshop copy for some snapshop"
    default     = false
}

variable "source_snapshot_id" {
    description = "The ARN for the snapshot to be copied."
    default     = ""
}

variable "source_region" {
    description = "The region of the source snapshot."
    default     = ""
}
 
variable "ebs_snapshot_copy_encrypted" {
    description = "Whether the snapshot is encrypted."
    default     = false
}

variable "ebs_snapshot_copy_kms_key_id" {
    description = " The ARN for the KMS encryption key."
    default     = ""
}
