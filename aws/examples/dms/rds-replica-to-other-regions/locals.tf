locals {
  name        = "linux-notes-db-replication"
  environment = "prod"

  sns_topic_subscription_list = [
    "vitalii.natarov@linux-notes.org"
  ]

  dms_source_endpoint_properties = {
    dms_endpoint_region = "us-east-1"

    dms_endpoint_engine_name                 = "mysql"
    dms_endpoint_server_name                 = "global-db-us-east-1.internal.linux-notes.org"
    dms_endpoint_port                        = 3306
    dms_endpoint_database_name               = "RdsProd"
    dms_endpoint_username                    = "linux_notes_admin"
    dms_endpoint_password                    = var.db_password
    dms_endpoint_extra_connection_attributes = "encryptionMode=SSE_KMS;maxFileSize=512"
  }

  # AWS: eu-central-1, eu-west-2, ca-central-1, ap-northeast-1, ap-southeast-2
  eucentral1_dms_target_endpoint_properties = {
    dms_endpoint_region = "eu-central-1"

    dms_endpoint_engine_name                 = "mysql"
    dms_endpoint_server_name                 = "global-db-replica-eu-central-1.internal.linux-notes.org"
    dms_endpoint_port                        = 3306
    dms_endpoint_database_name               = "RdsProd"
    dms_endpoint_username                    = "linux_notes_admin"
    dms_endpoint_password                    = var.db_password
    dms_endpoint_extra_connection_attributes = "encryptionMode=SSE_KMS;maxFileSize=512"
  }

  euwest2_dms_target_endpoint_properties = {
    dms_endpoint_region = "eu-west-2"

    dms_endpoint_engine_name                 = "mysql"
    dms_endpoint_server_name                 = "global-db-replica-eu-west-2.internal.linux-notes.org"
    dms_endpoint_port                        = 3306
    dms_endpoint_database_name               = "RdsProd"
    dms_endpoint_username                    = "linux_notes_admin"
    dms_endpoint_password                    = var.db_password
    dms_endpoint_extra_connection_attributes = "encryptionMode=SSE_KMS;maxFileSize=512"
  }

  cacentral1_dms_target_endpoint_properties = {
    dms_endpoint_region = "ca-central-1"

    dms_endpoint_engine_name                 = "mysql"
    dms_endpoint_server_name                 = "global-db-replica-ca-central-1.internal.linux-notes.org"
    dms_endpoint_port                        = 3306
    dms_endpoint_database_name               = "RdsProd"
    dms_endpoint_username                    = "linux_notes_admin"
    dms_endpoint_password                    = var.db_password
    dms_endpoint_extra_connection_attributes = "encryptionMode=SSE_KMS;maxFileSize=512"
  }

  apnortheast1_dms_target_endpoint_properties = {
    dms_endpoint_region = "ap-northeast-1"

    dms_endpoint_engine_name                 = "mysql"
    dms_endpoint_server_name                 = "global-db-replica-ap-northeast-1.internal.linux-notes.org"
    dms_endpoint_port                        = 3306
    dms_endpoint_database_name               = "RdsProd"
    dms_endpoint_username                    = "linux_notes_admin"
    dms_endpoint_password                    = var.db_password
    dms_endpoint_extra_connection_attributes = "encryptionMode=SSE_KMS;maxFileSize=512"
  }

  apsoutheast2_dms_target_endpoint_properties = {
    dms_endpoint_region = "ap-southeast-2"

    dms_endpoint_engine_name                 = "mysql"
    dms_endpoint_server_name                 = "global-db-replica-ap-southeast-2.internal.linux-notes.org"
    dms_endpoint_port                        = 3306
    dms_endpoint_database_name               = "RdsProd"
    dms_endpoint_username                    = "linux_notes_admin"
    dms_endpoint_password                    = var.db_password
    dms_endpoint_extra_connection_attributes = "encryptionMode=SSE_KMS;maxFileSize=512"
  }

  # Azure: westeurope, westus2
  westeurope_dms_target_endpoint_properties = {
    dms_endpoint_region = "westeurope"

    dms_endpoint_engine_name                 = "mysql"
    dms_endpoint_server_name                 = "global-db-replica-westeurope.internal.linux-notes.org"
    dms_endpoint_port                        = 3306
    dms_endpoint_database_name               = "RdsProd"
    dms_endpoint_username                    = "linux_notes_admin"
    dms_endpoint_password                    = var.db_password
    dms_endpoint_extra_connection_attributes = "encryptionMode=SSE_KMS;maxFileSize=512"
  }

  westus2_dms_target_endpoint_properties = {
    dms_endpoint_region = "westus2"

    dms_endpoint_engine_name                 = "mysql"
    dms_endpoint_server_name                 = "global-db-replica-westus2.internal.linux-notes.org"
    dms_endpoint_port                        = 3306
    dms_endpoint_database_name               = "RdsProd"
    dms_endpoint_username                    = "linux_notes_admin"
    dms_endpoint_password                    = var.db_password
    dms_endpoint_extra_connection_attributes = "encryptionMode=SSE_KMS;maxFileSize=512"
  }

  tags = tomap({
    "Environment"   = local.environment,
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}