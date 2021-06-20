#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "source_dms_endpoint" {
  source      = "../../modules/dms"
  name        = "TEST"
  environment = "stage"

  # enable dms certificate
  enable_dms_certificate             = false
  dms_certificate_certificate_id     = "test-dms-certificate-tf"
  dms_certificate_certificate_pem    = "..."
  dms_certificate_certificate_wallet = null

  # enable dms endpoint
  enable_dms_endpoint                      = true
  dms_endpoint_certificate_arn             = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
  dms_endpoint_database_name               = "test"
  dms_endpoint_endpoint_id                 = "test-dms-endpoint-tf"
  dms_endpoint_endpoint_type               = "source"
  dms_endpoint_engine_name                 = "aurora"
  dms_endpoint_extra_connection_attributes = ""
  dms_endpoint_kms_key_arn                 = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
  dms_endpoint_password                    = "test"
  dms_endpoint_port                        = 3306
  dms_endpoint_server_name                 = "test"
  dms_endpoint_ssl_mode                    = "none"

  # enable dms replication subnet group
  enable_dms_replication_subnet_group                               = true
  dms_replication_subnet_group_name                                 = ""
  dms_replication_subnet_group_replication_subnet_group_description = ""
  dms_replication_subnet_group_subnet_ids                           = ["sbt-434hjk"]

  # enable dms replication instance
  enable_dms_replication_instance                     = true
  dms_replication_instance_replication_instance_class = "dms.t2.micro"
  dms_replication_instance_replication_instance_id    = ""

  dms_replication_instance_allocated_storage            = 20
  dms_replication_instance_apply_immediately            = true
  dms_replication_instance_auto_minor_version_upgrade   = true
  dms_replication_instance_availability_zone            = "us-east-1c"
  dms_replication_instance_engine_version               = "3.1.4"
  dms_replication_instance_kms_key_arn                  = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
  dms_replication_instance_multi_az                     = false
  dms_replication_instance_preferred_maintenance_window = "sun:10:30-sun:14:30"
  dms_replication_instance_publicly_accessible          = true
  dms_replication_instance_vpc_security_group_ids       = ["sg-12345678"]


  tags = tomap({ "env" = "stage", "CreatedBy" = "Vitaliy Natarov" })
}
