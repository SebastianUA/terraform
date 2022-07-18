
#---------------------------------------------------------------
# AWS DMS source resources
#---------------------------------------------------------------
# Source
module "dms_replication_source" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms endpoint
  enable_dms_endpoint          = true
  dms_endpoint_endpoint_id     = "${local.name}-${local.environment}-${local.dms_source_endpoint_properties["dms_endpoint_region"]}-dms-source-endpoint"
  dms_endpoint_kms_key_arn     = null # "arn:aws:kms:us-east-1:${data.aws_caller_identity.linux_notes_main.account_id}:key/a78516bb-fed3-41e7-bcc2-420eb2347b14"
  dms_endpoint_certificate_arn = null
  dms_endpoint_ssl_mode        = "none"

  dms_endpoint_endpoint_type               = "source"
  dms_endpoint_engine_name                 = local.dms_source_endpoint_properties["dms_endpoint_engine_name"]
  dms_endpoint_server_name                 = local.dms_source_endpoint_properties["dms_endpoint_server_name"]
  dms_endpoint_port                        = local.dms_source_endpoint_properties["dms_endpoint_port"]
  dms_endpoint_database_name               = local.dms_source_endpoint_properties["dms_endpoint_database_name"]
  dms_endpoint_username                    = local.dms_source_endpoint_properties["dms_endpoint_username"]
  dms_endpoint_password                    = local.dms_source_endpoint_properties["dms_endpoint_password"]
  dms_endpoint_extra_connection_attributes = local.dms_source_endpoint_properties["dms_endpoint_extra_connection_attributes"]

  # enable dms replication subnet group
  enable_dms_replication_subnet_group                               = true
  dms_replication_subnet_group_replication_subnet_group_id          = "${local.name}-${local.environment}-dms-replication-subnet-group"
  dms_replication_subnet_group_replication_subnet_group_description = "DMS replication subnet group for ${local.name}-${local.environment}-dms-endpoint"
  dms_replication_subnet_group_subnet_ids = [
    "sg-0f9b50fc4e2f255ef"
  ]

  # enable dms replication instance
  enable_dms_replication_instance = true
  # Types: https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReplicationInstance.Types.html
  dms_replication_instance_replication_instance_class = "dms.c5.xlarge"
  dms_replication_instance_replication_instance_id    = "${local.name}-${local.environment}-dms-replication-instance"

  dms_replication_instance_allocated_storage            = 100
  dms_replication_instance_apply_immediately            = true
  dms_replication_instance_auto_minor_version_upgrade   = false
  dms_replication_instance_availability_zone            = "us-east-1c"
  dms_replication_instance_engine_version               = "3.4.7"
  dms_replication_instance_kms_key_arn                  = null # "arn:aws:kms:us-east-1:${data.aws_caller_identity.linux_notes_main.account_id}:key/a78516bb-fed3-41e7-bcc2-420eb2347b14"
  dms_replication_instance_multi_az                     = false
  dms_replication_instance_preferred_maintenance_window = "sun:10:30-sun:14:30"
  dms_replication_instance_publicly_accessible          = true
  dms_replication_instance_vpc_security_group_ids = [
    "sg-0f9b50fc4e2f255ef"
  ]

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
    module.dms_sns
  ]
}

#---------------------------------------------------------------
# AWS DMS target resources
#---------------------------------------------------------------
# Targets for AWS regions (eu-central-1, eu-west-2, ca-central-1, ap-northeast-1, ap-southeast-2)
module "dms_replication_target_eucentral1" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms endpoint
  enable_dms_endpoint          = true
  dms_endpoint_endpoint_id     = "${local.name}-${local.environment}-${local.eucentral1_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
  dms_endpoint_kms_key_arn     = null
  dms_endpoint_certificate_arn = null
  dms_endpoint_ssl_mode        = "none"

  dms_endpoint_endpoint_type               = "target"
  dms_endpoint_engine_name                 = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_engine_name"]
  dms_endpoint_server_name                 = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_server_name"]
  dms_endpoint_port                        = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_port"]
  dms_endpoint_database_name               = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_database_name"]
  dms_endpoint_username                    = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_username"]
  dms_endpoint_password                    = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_password"]
  dms_endpoint_extra_connection_attributes = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
  ]
}

module "dms_replication_target_euwest2" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms endpoint
  enable_dms_endpoint          = true
  dms_endpoint_endpoint_id     = "${local.name}-${local.environment}-${local.euwest2_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
  dms_endpoint_kms_key_arn     = null
  dms_endpoint_certificate_arn = null
  dms_endpoint_ssl_mode        = "none"

  dms_endpoint_endpoint_type               = "target"
  dms_endpoint_engine_name                 = local.euwest2_dms_target_endpoint_properties["dms_endpoint_engine_name"]
  dms_endpoint_server_name                 = local.euwest2_dms_target_endpoint_properties["dms_endpoint_server_name"]
  dms_endpoint_port                        = local.euwest2_dms_target_endpoint_properties["dms_endpoint_port"]
  dms_endpoint_database_name               = local.euwest2_dms_target_endpoint_properties["dms_endpoint_database_name"]
  dms_endpoint_username                    = local.euwest2_dms_target_endpoint_properties["dms_endpoint_username"]
  dms_endpoint_password                    = local.euwest2_dms_target_endpoint_properties["dms_endpoint_password"]
  dms_endpoint_extra_connection_attributes = local.euwest2_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
  ]
}

module "dms_replication_target_cacentral1" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms endpoint
  enable_dms_endpoint          = true
  dms_endpoint_endpoint_id     = "${local.name}-${local.environment}-${local.cacentral1_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
  dms_endpoint_kms_key_arn     = null
  dms_endpoint_certificate_arn = null
  dms_endpoint_ssl_mode        = "none"

  dms_endpoint_endpoint_type               = "target"
  dms_endpoint_engine_name                 = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_engine_name"]
  dms_endpoint_server_name                 = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_server_name"]
  dms_endpoint_port                        = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_port"]
  dms_endpoint_database_name               = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_database_name"]
  dms_endpoint_username                    = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_username"]
  dms_endpoint_password                    = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_password"]
  dms_endpoint_extra_connection_attributes = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
  ]
}

module "dms_replication_target_apnortheast1" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms endpoint
  enable_dms_endpoint          = true
  dms_endpoint_endpoint_id     = "${local.name}-${local.environment}-${local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
  dms_endpoint_kms_key_arn     = null
  dms_endpoint_certificate_arn = null
  dms_endpoint_ssl_mode        = "none"

  dms_endpoint_endpoint_type               = "target"
  dms_endpoint_engine_name                 = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_engine_name"]
  dms_endpoint_server_name                 = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_server_name"]
  dms_endpoint_port                        = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_port"]
  dms_endpoint_database_name               = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_database_name"]
  dms_endpoint_username                    = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_username"]
  dms_endpoint_password                    = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_password"]
  dms_endpoint_extra_connection_attributes = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
  ]
}

module "dms_replication_target_apsoutheast2" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms endpoint
  enable_dms_endpoint          = true
  dms_endpoint_endpoint_id     = "${local.name}-${local.environment}-${local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
  dms_endpoint_kms_key_arn     = null
  dms_endpoint_certificate_arn = null
  dms_endpoint_ssl_mode        = "none"

  dms_endpoint_endpoint_type               = "target"
  dms_endpoint_engine_name                 = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_engine_name"]
  dms_endpoint_server_name                 = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_server_name"]
  dms_endpoint_port                        = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_port"]
  dms_endpoint_database_name               = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_database_name"]
  dms_endpoint_username                    = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_username"]
  dms_endpoint_password                    = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_password"]
  dms_endpoint_extra_connection_attributes = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
  ]
}

# Targets for Azure regions (westeurope, westus2)
module "dms_replication_target_westeurope" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms endpoint
  enable_dms_endpoint          = true
  dms_endpoint_endpoint_id     = "${local.name}-${local.environment}-${local.westeurope_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
  dms_endpoint_kms_key_arn     = null
  dms_endpoint_certificate_arn = null
  dms_endpoint_ssl_mode        = "none"

  dms_endpoint_endpoint_type               = "target"
  dms_endpoint_engine_name                 = local.westeurope_dms_target_endpoint_properties["dms_endpoint_engine_name"]
  dms_endpoint_server_name                 = local.westeurope_dms_target_endpoint_properties["dms_endpoint_server_name"]
  dms_endpoint_port                        = local.westeurope_dms_target_endpoint_properties["dms_endpoint_port"]
  dms_endpoint_database_name               = local.westeurope_dms_target_endpoint_properties["dms_endpoint_database_name"]
  dms_endpoint_username                    = local.westeurope_dms_target_endpoint_properties["dms_endpoint_username"]
  dms_endpoint_password                    = local.westeurope_dms_target_endpoint_properties["dms_endpoint_password"]
  dms_endpoint_extra_connection_attributes = local.westeurope_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
  ]
}

module "dms_replication_target_westus2" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms endpoint
  enable_dms_endpoint          = true
  dms_endpoint_endpoint_id     = "${local.name}-${local.environment}-${local.westus2_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
  dms_endpoint_kms_key_arn     = null
  dms_endpoint_certificate_arn = null
  dms_endpoint_ssl_mode        = "none"

  dms_endpoint_endpoint_type               = "target"
  dms_endpoint_engine_name                 = local.westus2_dms_target_endpoint_properties["dms_endpoint_engine_name"]
  dms_endpoint_server_name                 = local.westus2_dms_target_endpoint_properties["dms_endpoint_server_name"]
  dms_endpoint_port                        = local.westus2_dms_target_endpoint_properties["dms_endpoint_port"]
  dms_endpoint_database_name               = local.westus2_dms_target_endpoint_properties["dms_endpoint_database_name"]
  dms_endpoint_username                    = local.westus2_dms_target_endpoint_properties["dms_endpoint_username"]
  dms_endpoint_password                    = local.westus2_dms_target_endpoint_properties["dms_endpoint_password"]
  dms_endpoint_extra_connection_attributes = local.westus2_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
  ]
}

#---------------------------------------------------------------
# AWS DMS replication tasks
#---------------------------------------------------------------
# Reference the DMS table mappings
data "template_file" "table_mappings" {
  template = file("./additional_files/dms_replication_task_table_mappings.json.tpl")
}

# AWS: eu-central-1, eu-west-2, ca-central-1, ap-northeast-1, ap-southeast-2
module "dms_replication_task_eucentral1" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms replication task
  enable_dms_replication_task                   = true
  dms_replication_task_migration_type           = "full-load"
  dms_replication_task_replication_task_id      = "${local.name}-${local.environment}-${local.eucentral1_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
  dms_replication_task_replication_instance_arn = module.dms_replication_source.dms_replication_instance_replication_instance_arn

  dms_replication_task_source_endpoint_arn = module.dms_replication_source.dms_endpoint_endpoint_arn
  dms_replication_task_target_endpoint_arn = module.dms_replication_target_eucentral1.dms_endpoint_endpoint_arn

  dms_replication_task_table_mappings = data.template_file.table_mappings.rendered

  dms_replication_task_cdc_start_time            = ""
  dms_replication_task_replication_task_settings = ""

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
    module.dms_sns,
    module.dms_replication_source,
    module.dms_replication_target_eucentral1
  ]
}

module "dms_replication_task_euwest2" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms replication task
  enable_dms_replication_task                   = true
  dms_replication_task_migration_type           = "full-load"
  dms_replication_task_replication_task_id      = "${local.name}-${local.environment}-${local.euwest2_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
  dms_replication_task_replication_instance_arn = module.dms_replication_source.dms_replication_instance_replication_instance_arn

  dms_replication_task_source_endpoint_arn = module.dms_replication_source.dms_endpoint_endpoint_arn
  dms_replication_task_target_endpoint_arn = module.dms_replication_target_euwest2.dms_endpoint_endpoint_arn

  dms_replication_task_table_mappings = data.template_file.table_mappings.rendered

  dms_replication_task_cdc_start_time            = ""
  dms_replication_task_replication_task_settings = ""

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
    module.dms_sns,
    module.dms_replication_source,
    module.dms_replication_target_euwest2
  ]
}

module "dms_replication_task_cacentral1" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms replication task
  enable_dms_replication_task                   = true
  dms_replication_task_migration_type           = "full-load"
  dms_replication_task_replication_task_id      = "${local.name}-${local.environment}-${local.cacentral1_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
  dms_replication_task_replication_instance_arn = module.dms_replication_source.dms_replication_instance_replication_instance_arn

  dms_replication_task_source_endpoint_arn = module.dms_replication_source.dms_endpoint_endpoint_arn
  dms_replication_task_target_endpoint_arn = module.dms_replication_target_cacentral1.dms_endpoint_endpoint_arn

  dms_replication_task_table_mappings = data.template_file.table_mappings.rendered

  dms_replication_task_cdc_start_time            = ""
  dms_replication_task_replication_task_settings = ""

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
    module.dms_sns,
    module.dms_replication_source,
    module.dms_replication_target_cacentral1
  ]
}

module "dms_replication_task_apnortheast1" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms replication task
  enable_dms_replication_task                   = true
  dms_replication_task_migration_type           = "full-load"
  dms_replication_task_replication_task_id      = "${local.name}-${local.environment}-${local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
  dms_replication_task_replication_instance_arn = module.dms_replication_source.dms_replication_instance_replication_instance_arn

  dms_replication_task_source_endpoint_arn = module.dms_replication_source.dms_endpoint_endpoint_arn
  dms_replication_task_target_endpoint_arn = module.dms_replication_target_apnortheast1.dms_endpoint_endpoint_arn

  dms_replication_task_table_mappings = data.template_file.table_mappings.rendered

  dms_replication_task_cdc_start_time            = ""
  dms_replication_task_replication_task_settings = ""

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
    module.dms_sns,
    module.dms_replication_source,
    module.dms_replication_target_apnortheast1
  ]
}

module "dms_replication_task_apsoutheast2" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms replication task
  enable_dms_replication_task                   = true
  dms_replication_task_migration_type           = "full-load"
  dms_replication_task_replication_task_id      = "${local.name}-${local.environment}-${local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
  dms_replication_task_replication_instance_arn = module.dms_replication_source.dms_replication_instance_replication_instance_arn

  dms_replication_task_source_endpoint_arn = module.dms_replication_source.dms_endpoint_endpoint_arn
  dms_replication_task_target_endpoint_arn = module.dms_replication_target_apsoutheast2.dms_endpoint_endpoint_arn

  dms_replication_task_table_mappings = data.template_file.table_mappings.rendered

  dms_replication_task_cdc_start_time            = ""
  dms_replication_task_replication_task_settings = ""

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
    module.dms_sns,
    module.dms_replication_source,
    module.dms_replication_target_apsoutheast2
  ]
}

# Azure: westeurope, westus2
module "dms_replication_task_westeurope" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms replication task
  enable_dms_replication_task                   = true
  dms_replication_task_migration_type           = "full-load"
  dms_replication_task_replication_task_id      = "${local.name}-${local.environment}-${local.westeurope_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
  dms_replication_task_replication_instance_arn = module.dms_replication_source.dms_replication_instance_replication_instance_arn

  dms_replication_task_source_endpoint_arn = module.dms_replication_source.dms_endpoint_endpoint_arn
  dms_replication_task_target_endpoint_arn = module.dms_replication_target_westeurope.dms_endpoint_endpoint_arn

  dms_replication_task_table_mappings = data.template_file.table_mappings.rendered

  dms_replication_task_cdc_start_time            = ""
  dms_replication_task_replication_task_settings = ""

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
    module.dms_sns,
    module.dms_replication_source,
    module.dms_replication_target_westeurope
  ]
}

module "dms_replication_task_westus2" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms replication task
  enable_dms_replication_task                   = true
  dms_replication_task_migration_type           = "full-load"
  dms_replication_task_replication_task_id      = "${local.name}-${local.environment}-${local.westus2_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
  dms_replication_task_replication_instance_arn = module.dms_replication_source.dms_replication_instance_replication_instance_arn

  dms_replication_task_source_endpoint_arn = module.dms_replication_source.dms_endpoint_endpoint_arn
  dms_replication_task_target_endpoint_arn = module.dms_replication_target_westus2.dms_endpoint_endpoint_arn

  dms_replication_task_table_mappings = data.template_file.table_mappings.rendered

  dms_replication_task_cdc_start_time            = ""
  dms_replication_task_replication_task_settings = ""

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
    module.dms_sns,
    module.dms_replication_source,
    module.dms_replication_target_westus2
  ]
}


#---------------------------------------------------------------
# AWS DMS replication subscription
#---------------------------------------------------------------
module "dms_replication_subscription" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # enable dms event subscription  
  enable_dms_event_subscription  = true
  dms_event_subscription_name    = "${local.name}-${local.environment}-${local.dms_source_endpoint_properties["dms_endpoint_region"]}-dms-event-subscription"
  dms_event_subscription_enabled = true
  dms_event_subscription_source_ids = [
    module.dms_replication_task_eucentral1.dms_replication_task_id,
    module.dms_replication_task_euwest2.dms_replication_task_id,
    module.dms_replication_task_cacentral1.dms_replication_task_id,
    module.dms_replication_task_apnortheast1.dms_replication_task_id,
    module.dms_replication_task_apsoutheast2.dms_replication_task_id,
    module.dms_replication_task_westeurope.dms_replication_task_id,
    module.dms_replication_task_westus2.dms_replication_task_id
  ]

  # https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DescribeEventCategories.html
  dms_event_subscription_event_categories = ["creation", "failure"]

  dms_event_subscription_sns_topic_arn = module.dms_sns.sns_topic_arn
  dms_event_subscription_source_type   = "replication-task"

  tags = local.tags

  depends_on = [
    module.dms-access-for-endpoint,
    module.dms-cloudwatch-logs-role,
    module.dms-vpc-role,
    module.dms_sns,
    module.dms_replication_task_eucentral1,
    module.dms_replication_task_euwest2,
    module.dms_replication_task_cacentral1,
    module.dms_replication_task_apnortheast1,
    module.dms_replication_task_apsoutheast2,
    module.dms_replication_task_westeurope,
    module.dms_replication_task_westus2
  ]
}