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
                                    
    #
    # AWS EBS volume
    #
    enable_ebs_volume               = true
    type                            = "gp2"
    size                            = 8
    
    ebs_volume_encrypted            = false
    iops                            = 100
    snapshot_id                     = ""
    kms_key_id                      = ""

    #
    # AWS EBS volume attachment
    #
    enable_ebs_volume_attachment    = false
    device_name                     = ""
    instance_id                     = ""
    volume_id                       = ""
    
    force_detach                    = false
    skip_destroy                    = false
}
```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default     = "TEST-ASG"`).
- `region` - The region where to deploy this code (e.g. us-east-1) - (`default     = "us-east-1"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `enable_ebs_volume` - Enable EBS volume creating (`default     = false`).
- `availability_zone` - (Required) The AZ where the EBS volume will exist (`default     = ""`).
- `availability_zones` - Availability zones for AWS ASG (`default     = {
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
    }`).

- `type` - (Optional) The type of EBS volume. Can be 'standard', 'gp2', 'io1', 'sc1' or 'st1' (Default: 'standard') - (`default     = "standard"`).
- `size` - (Optional) The size of the drive in GiBs (`default     = 8`).
- `ebs_volume_encrypted` - (Optional) If true, the disk will be encrypted (`default     = false`).
- `iops` - (Optional) The amount of IOPS to provision for the disk (`default     = 100`).
- `snapshot_id` - (Optional) A snapshot to base the EBS volume off of (`default     = ""`).
- `kms_key_id` - (Optional) The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true (`default     = ""`).
- `enable_ebs_volume_attachment` - Enable ebs volume attachment usage (`default     = false`).
- `device_name` - (Required) The device name to expose to the instance (for example, /dev/sdh or xvdh) - (`default     = "/dev/sdb"`).
- `instance_id` - (Required) ID of the Instance to attach to (`default     = ""`).
- `volume_id` - (Required) ID of the Volume to be attached (`default     = ""`).
- `force_detach` - (Optional, Boolean) Set to true if you want to force the volume to detach. Useful if previous attempts failed, but use this option only as a last resort, as this can result in data loss (`default     = false`).
- `skip_destroy` - (Optional, Boolean) Set this to true if you do not wish to detach the volume from the instance to which it is attached at destroy time, and instead just remove the attachment from Terraform state. This is useful when destroying an instance which has volumes created by some other means attached (`default     = false`).
- `enable_ebs_snapshot` - Enable ebs snapshop for the volume (`default     = false`).
- `enable_ebs_snapshot_copy` - Enable ebs snapshop copy for some snapshop (`default     = false`).
- `source_snapshot_id` - "The ARN for the snapshot to be copied (`default     = ""`).
- `source_region` - "The region of the source snapshot (`default     = ""`).
- `ebs_snapshot_copy_encrypted` - Whether the snapshot is encrypted (`default     = false`).
- `ebs_snapshot_copy_kms_key_id` - The ARN for the KMS encryption key (`default     = ""`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
