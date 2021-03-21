#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"
}

provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
}

module "efs" {
  source      = "../../modules/efs"
  name        = "TEST"
  environment = "nonprod"

  # EFS FS
  enable_efs_file_system           = true
  efs_file_system_name             = ""
  efs_file_system_encrypted        = false
  efs_file_system_kms_key_id       = ""
  efs_file_system_performance_mode = "generalPurpose"

  efs_file_system_lifecycle_policy = [
    {
      transition_to_ia = "AFTER_90_DAYS"
    }
  ]

  # EFS mount target
  enable_efs_mount_target          = true
  efs_mount_target_subnet_ids      = ["subnet-0e2b323b731655057", "subnet-0ffa47878036f1641", "subnet-096406cfdf907ee11"]
  efs_mount_target_security_groups = ["sg-07b62c0d0ea37056d"]

  # EFS access point
  enable_efs_access_point = true
  efs_access_point_name   = ""

  efs_access_point_posix_user = [
    {
      gid = "666"
      uid = "666"
    }
  ]
  efs_access_point_root_directory = []

  tags = map("Env", "stage", "Orchestration", "Terraform")
}

module "efs_policy" {
  source      = "../../modules/efs"
  name        = "TEST"
  environment = "nonprod"

  # EFS FS policy
  enable_efs_file_system_policy         = true
  efs_file_system_policy_file_system_id = module.efs.efs_file_system_arn
  efs_file_system_policy_policy         = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "ExamplePolicy01",
    "Statement": [
        {
            "Sid": "ExampleStatement01",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Resource": "${module.efs.efs_file_system_arn}",
            "Action": [
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "true"
                }
            }
        }
    ]
}
POLICY

  tags = map("Env", "stage", "Orchestration", "Terraform")

  depends_on = [
    module.efs
  ]
}
