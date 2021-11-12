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
