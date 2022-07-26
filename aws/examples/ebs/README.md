# Work with EBS via terraform

A terraform module for making EBS.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
module "ebs" {
  source      = "../../modules/ebs"
  name        = "test"
  region      = "us-west-2"
  environment = "stage"

  # AWS EBS volume
  enable_ebs_volume = true
  ebs_volume_name   = ""
  ebs_volume_type   = "gp3"
  ebs_volume_size   = 8

  ebs_volume_encrypted   = false
  ebs_volume_iops        = 100
  ebs_volume_snapshot_id = ""
  ebs_volume_kms_key_id  = ""

  # AWS EBS volume attachment
  enable_ebs_volume_attachment      = false
  ebs_volume_attachment_device_name = ""
  ebs_volume_attachment_instance_id = ""
  ebs_volume_attachment_volume_id   = ""

  ebs_volume_attachment_force_detach = false
  ebs_volume_attachment_skip_destroy = false

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `availability_zones` - Availability zones for AWS EBS (`default = {'us-east-1': 'us-east-1b,us-east-1c,us-east-1d,us-east-1e', 'us-east-2': 'us-east-2a,eu-east-2b,eu-east-2c', 'us-west-1': 'us-west-1a,us-west-1c', 'us-west-2': 'us-west-2a,us-west-2b,us-west-2c', 'ca-central-1': 'ca-central-1a,ca-central-1b', 'eu-west-1': 'eu-west-1a,eu-west-1b,eu-west-1c', 'eu-west-2': 'eu-west-2a,eu-west-2b', 'eu-central-1': 'eu-central-1a,eu-central-1b,eu-central-1c', 'ap-south-1': 'ap-south-1a,ap-south-1b', 'sa-east-1': 'sa-east-1a,sa-east-1c', 'ap-northeast-1': 'ap-northeast-1a,ap-northeast-1c', 'ap-southeast-1': 'ap-southeast-1a,ap-southeast-1b', 'ap-southeast-2': 'ap-southeast-2a,ap-southeast-2b,ap-southeast-2c', 'ap-northeast-2': 'ap-northeast-2a,ap-northeast-2c'}`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - Add additional tags (`default = {}`)
- `enable_ebs_volume` - Enable EBS volume creating (`default = False`)
- `ebs_volume_name` - Name for ebs_volume (`default = ""`)
- `ebs_volume_availability_zone` - (Required) The AZ where the EBS volume will exist. (`default = ""`)
- `ebs_volume_type` - (Optional) The type of EBS volume. Can be 'standard', 'gp2', 'io1', 'sc1' or 'st1' (Default: 'standard'). (`default = standard`)
- `ebs_volume_size` - (Optional) The size of the drive in GiBs. (`default = 8`)
- `ebs_volume_encrypted` - (Optional) If true, the disk will be encrypted. (`default = False`)
- `ebs_volume_iops` - (Optional) The amount of IOPS to provision for the disk. (`default = 100`)
- `ebs_volume_snapshot_id` - (Optional) A snapshot to base the EBS volume off of. (`default = ""`)
- `ebs_volume_kms_key_id` - (Optional) The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true. (`default = ""`)
- `enable_ebs_volume_attachment` - Enable ebs volume attachment usage (`default = False`)
- `ebs_volume_attachment_device_name` - (Required) The device name to expose to the instance (for example, /dev/sdh or xvdh) (`default = /dev/sdb`)
- `ebs_volume_attachment_instance_id` - (Required) ID of the Instance to attach to (`default = ""`)
- `ebs_volume_attachment_volume_id` - (Required) ID of the Volume to be attached (`default = ""`)
- `ebs_volume_attachment_force_detach` - (Optional, Boolean) Set to true if you want to force the volume to detach. Useful if previous attempts failed, but use this option only as a last resort, as this can result in data loss. (`default = False`)
- `ebs_volume_attachment_skip_destroy` - (Optional, Boolean) Set this to true if you do not wish to detach the volume from the instance to which it is attached at destroy time, and instead just remove the attachment from Terraform state. This is useful when destroying an instance which has volumes created by some other means attached. (`default = False`)
- `enable_ebs_snapshot` - Enable ebs snapshop for the volume (`default = False`)
- `ebs_snapshot_description` - (Optional) A description of what the snapshot is. (`default = ""`)
- `ebs_snapshot_volume_id` - Set EBS snapshot volume id (`default = ""`)
- `ebs_snapshot_name` - Name for ebs_snapshot (`default = ""`)
- `ebs_snapshot_timeouts` - Set timeouts for ebs snapshot (`default = {}`)
- `enable_ebs_snapshot_copy` - Enable ebs snapshop copy for some snapshop (`default = False`)
- `ebs_snapshot_copy_source_snapshot_id` - The ARN for the snapshot to be copied. (`default = ""`)
- `ebs_snapshot_copy_name` - Name for ebs_snapshot_copy (`default = ""`)
- `ebs_snapshot_copy_description` - (Optional) A description of what the snapshot is. (`default = ""`)
- `ebs_snapshot_copy_encrypted` - Whether the snapshot is encrypted. (`default = False`)
- `ebs_snapshot_copy_kms_key_id` - The ARN for the KMS encryption key. (`default = ""`)

## Module Output Variables
----------------------
- `ebs_volume_id` - The volume ID (e.g. vol-59fcb34e).
- `ebs_volume_arn` - The volume ARN (e.g. arn:aws:ec2:us-east-1:0123456789012:volume/vol-59fcb34e).
- `ebs_volume_attachment_device_name` - The device name exposed to the instance
- `ebs_volume_attachment_instance_id` - ID of the Instance
- `ebs_volume_attachment_volume_id` - ID of the Volume
- `ebs_snapshot_owner_id` - The device name exposed to the instance
- `ebs_snapshot_id` - ID of the Instance
- `ebs_snapshot_owner_alias` - ID of the Volume
- `ebs_snapshot_owner_encrypted` - The device name exposed to the instance
- `ebs_snapshot_kms_key_id` - ID of the Instance
- `ebs_snapshot_copy_owner_id` - The device name exposed to the instance
- `ebs_snapshot_copy_id` - ID of the Instance
- `ebs_snapshot_copy_owner_alias` - ID of the Volume
- `ebs_snapshot_copy_owner_encrypted` - The device name exposed to the instance
- `ebs_snapshot_copy_kms_key_id` - ID of the Instance


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
