module "ebs" {
  source      = "../../modules/ebs"
  name        = "test"
  region      = "us-west-2"
  environment = "stage"

  # AWS EBS volume
  enable_ebs_volume = true
  ebs_volume_name   = ""
  type              = "gp2"
  size              = 8

  ebs_volume_encrypted = false
  iops                 = 100
  snapshot_id          = ""
  kms_key_id           = ""

  # AWS EBS volume attachment
  enable_ebs_volume_attachment = false
  device_name                  = ""
  instance_id                  = ""
  volume_id                    = ""

  force_detach = false
  skip_destroy = false

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
