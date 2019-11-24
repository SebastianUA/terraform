# Work with AWS EBS volumes via terraform

A terraform module for EBS.

## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
module "ebs" {
    source                          = "../../modules/ebs"
    name                            = "test"
    region                          = "us-west-2"
    environment                     = "PROD"
                                    
    # AWS EBS volume
    enable_ebs_volume               = true
    ebs_volume_name                 = ""
    type                            = "gp2"
    size                            = 8
    
    ebs_volume_encrypted            = false
    iops                            = 100
    snapshot_id                     = ""
    kms_key_id                      = ""

    # AWS EBS volume attachment
    enable_ebs_volume_attachment    = false
    device_name                     = ""
    instance_id                     = ""
    volume_id                       = ""
    
    force_detach                    = false
    skip_destroy                    = false

    # 
}
```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `region` - The region where to deploy this code (e.g. us-east-1). (`default     = "us-east-1"`). 
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `tags` - Add additional tags (`default       = {}`).
- `enable_ebs_volume` - Enable EBS volume creating (`default     = false`).
- `ebs_volume_name` - Name for ebs_volume (`default       = ""`).
- `availability_zone` - (Required) The AZ where the EBS volume will exist. (`default     = ""`).
- `availability_zones` - Availability zones for AWS ASG.
- `type` - (Optional) The type of EBS volume. Can be 'standard', 'gp2', 'io1', 'sc1' or 'st1' (Default: 'standard'). (`default     = "standard"`).
- `size` - (Optional) The size of the drive in GiBs. (`default     = 8`).
- `ebs_volume_encrypted` - (Optional) If true, the disk will be encrypted. (`default     = false`).
- `iops` - (Optional) The amount of IOPS to provision for the disk. (`default     = 100`).
- `snapshot_id` - (Optional) A snapshot to base the EBS volume off of. (`default     = ""`).
- `kms_key_id` - (Optional) The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true. (`default     = ""`).
- `enable_ebs_volume_attachment` - Enable ebs volume attachment usage (`default     = false`).
- `device_name` - (Required) The device name to expose to the instance (for example, /dev/sdh or xvdh) (`default     = "/dev/sdb"`).
- `instance_id` - (Required) ID of the Instance to attach to (`default     = ""`).
- `volume_id` - (Required) ID of the Volume to be attached (`default     = ""`).
- `force_detach` - (Optional, Boolean) Set to true if you want to force the volume to detach. Useful if previous attempts failed, but use this option only as a last resort, as this can result in data loss. (`default     = false`).
- `skip_destroy` - (Optional, Boolean) Set this to true if you do not wish to detach the volume from the instance to which it is attached at destroy time, and instead just remove the attachment from Terraform state. This is useful when destroying an instance which has volumes created by some other means attached. (`default     = false`).
- `enable_ebs_snapshot` - Enable ebs snapshop for the volume (`default     = false`).
- `ebs_snapshot_description` -  (Optional) A description of what the snapshot is. (`default       = ""`).
- `ebs_snapshot_name` - Name for ebs_snapshot (`default       = ""`).
- `timeouts_create` - (Default 10 minutes) Used for creating the ebs snapshot (`default       = "10m"`).
- `timeouts_delete` - (Default 10 minutes) Used for deleting the ebs snapshot (`default       = "10m"`).
- `enable_ebs_snapshot_copy` - Enable ebs snapshop copy for some snapshop (`default     = false`).
- `source_snapshot_id` - The ARN for the snapshot to be copied. (`default     = ""`).
- `ebs_snapshot_copy_name` - Name for ebs_snapshot_copy (`default       = ""`).
- `ebs_snapshot_copy_description` - (Optional) A description of what the snapshot is. (`default       = ""`).
- `source_region` - The region of the source snapshot. (`default     = ""`). 
- `ebs_snapshot_copy_encrypted` - Whether the snapshot is encrypted. (`default     = false`).
- `ebs_snapshot_copy_kms_key_id` -  The ARN for the KMS encryption key. (`default     = ""`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
