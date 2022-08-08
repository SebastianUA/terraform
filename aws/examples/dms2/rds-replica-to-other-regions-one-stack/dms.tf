
#---------------------------------------------------------------
# AWS DMS source resources
#---------------------------------------------------------------
module "dms_replication" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/dms2?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # Enable DMS certificates
  enable_dms_certificate = false
  dms_certificates = [
    {
      # name           = "cert-name"
      certificate_id = "certificate-id"

      certificate_pem    = null
      certificate_wallet = null

      tags = {}
    }
  ]

  # Enable DMS endpoints
  enable_dms_endpoint = true
  dms_endpoints = {

    # sources
    source1 = {
      endpoint_id     = "${local.name}-${local.environment}-${local.dms_source_endpoint_properties["dms_endpoint_region"]}-dms-source-endpoint"
      kms_key_arn     = null
      certificate_arn = null
      ssl_mode        = "none"

      endpoint_type               = "source"
      engine_name                 = local.dms_source_endpoint_properties["dms_endpoint_engine_name"]
      server_name                 = local.dms_source_endpoint_properties["dms_endpoint_server_name"]
      port                        = local.dms_source_endpoint_properties["dms_endpoint_port"]
      database_name               = local.dms_source_endpoint_properties["dms_endpoint_database_name"]
      username                    = local.dms_source_endpoint_properties["dms_endpoint_username"]
      password                    = local.dms_source_endpoint_properties["dms_endpoint_password"]
      extra_connection_attributes = local.dms_source_endpoint_properties["dms_endpoint_extra_connection_attributes"]
    }

    # targets
    destination1 = {
      endpoint_id     = "${local.name}-${local.environment}-${local.eucentral1_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
      kms_key_arn     = null
      certificate_arn = null
      ssl_mode        = "none"

      endpoint_type               = "target"
      engine_name                 = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_engine_name"]
      server_name                 = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_server_name"]
      port                        = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_port"]
      database_name               = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_database_name"]
      username                    = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_username"]
      password                    = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_password"]
      extra_connection_attributes = local.eucentral1_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]
    }

    destination2 = {
      endpoint_id     = "${local.name}-${local.environment}-${local.euwest2_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
      kms_key_arn     = null
      certificate_arn = null
      ssl_mode        = "none"

      endpoint_type               = "target"
      engine_name                 = local.euwest2_dms_target_endpoint_properties["dms_endpoint_engine_name"]
      server_name                 = local.euwest2_dms_target_endpoint_properties["dms_endpoint_server_name"]
      port                        = local.euwest2_dms_target_endpoint_properties["dms_endpoint_port"]
      database_name               = local.euwest2_dms_target_endpoint_properties["dms_endpoint_database_name"]
      username                    = local.euwest2_dms_target_endpoint_properties["dms_endpoint_username"]
      password                    = local.euwest2_dms_target_endpoint_properties["dms_endpoint_password"]
      extra_connection_attributes = local.euwest2_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]
    }

    destination3 = {
      endpoint_id     = "${local.name}-${local.environment}-${local.cacentral1_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
      kms_key_arn     = null
      certificate_arn = null
      ssl_mode        = "none"

      endpoint_type               = "target"
      engine_name                 = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_engine_name"]
      server_name                 = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_server_name"]
      port                        = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_port"]
      database_name               = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_database_name"]
      username                    = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_username"]
      password                    = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_password"]
      extra_connection_attributes = local.cacentral1_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]
    }

    destination4 = {
      endpoint_id     = "${local.name}-${local.environment}-${local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
      kms_key_arn     = null
      certificate_arn = null
      ssl_mode        = "none"

      endpoint_type               = "target"
      engine_name                 = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_engine_name"]
      server_name                 = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_server_name"]
      port                        = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_port"]
      database_name               = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_database_name"]
      username                    = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_username"]
      password                    = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_password"]
      extra_connection_attributes = local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]
    }

    destination5 = {
      endpoint_id     = "${local.name}-${local.environment}-${local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
      kms_key_arn     = null
      certificate_arn = null
      ssl_mode        = "none"

      endpoint_type               = "target"
      engine_name                 = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_engine_name"]
      server_name                 = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_server_name"]
      port                        = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_port"]
      database_name               = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_database_name"]
      username                    = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_username"]
      password                    = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_password"]
      extra_connection_attributes = local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]
    }

    destination6 = {
      endpoint_id     = "${local.name}-${local.environment}-${local.westeurope_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
      kms_key_arn     = null
      certificate_arn = null
      ssl_mode        = "none"

      endpoint_type               = "target"
      engine_name                 = local.westeurope_dms_target_endpoint_properties["dms_endpoint_engine_name"]
      server_name                 = local.westeurope_dms_target_endpoint_properties["dms_endpoint_server_name"]
      port                        = local.westeurope_dms_target_endpoint_properties["dms_endpoint_port"]
      database_name               = local.westeurope_dms_target_endpoint_properties["dms_endpoint_database_name"]
      username                    = local.westeurope_dms_target_endpoint_properties["dms_endpoint_username"]
      password                    = local.westeurope_dms_target_endpoint_properties["dms_endpoint_password"]
      extra_connection_attributes = local.westeurope_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]
    }

    destination7 = {
      # endpoint_id     = "${local.name}-${local.environment}-${local.westus2_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-target-endpoint"
      kms_key_arn     = null
      certificate_arn = null
      ssl_mode        = "none"

      endpoint_type               = "target"
      engine_name                 = local.westus2_dms_target_endpoint_properties["dms_endpoint_engine_name"]
      server_name                 = local.westus2_dms_target_endpoint_properties["dms_endpoint_server_name"]
      port                        = local.westus2_dms_target_endpoint_properties["dms_endpoint_port"]
      database_name               = local.westus2_dms_target_endpoint_properties["dms_endpoint_database_name"]
      username                    = local.westus2_dms_target_endpoint_properties["dms_endpoint_username"]
      password                    = local.westus2_dms_target_endpoint_properties["dms_endpoint_password"]
      extra_connection_attributes = local.westus2_dms_target_endpoint_properties["dms_endpoint_extra_connection_attributes"]
    }
  }

  # enable DMS replication subnet group
  enable_dms_replication_subnet_group                               = true
  dms_replication_subnet_group_replication_subnet_group_id          = "${local.name}-${local.environment}-dms-replication-subnet-group"
  dms_replication_subnet_group_replication_subnet_group_description = "DMS replication subnet group for ${local.name}-${local.environment}-dms-endpoint"
  dms_replication_subnet_group_subnet_ids = [
    # Privates
    # "subnet-0dee889c36614e335",
    # "subnet-088c170d9effb07fe",
    # "subnet-00c642659b07d3338"

    # Publics
    "subnet-037db53111e8153de",
    "subnet-0e5282f3671f45ff6",
    "subnet-0b03db82a941204fc"
  ]

  # Enable DMS replication instance
  enable_dms_replication_instance = true
  # Types: https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReplicationInstance.Types.html
  dms_replication_instance_replication_instance_class = "dms.c5.xlarge"
  dms_replication_instance_replication_instance_id    = "${local.name}-${local.environment}-dms-replication-instance"

  dms_replication_instance_allocated_storage            = 100
  dms_replication_instance_apply_immediately            = true
  dms_replication_instance_auto_minor_version_upgrade   = false
  dms_replication_instance_availability_zone            = "us-east-1c"
  dms_replication_instance_engine_version               = "3.4.7"
  dms_replication_instance_kms_key_arn                  = null
  dms_replication_instance_multi_az                     = false
  dms_replication_instance_preferred_maintenance_window = "sun:10:30-sun:14:30"
  dms_replication_instance_publicly_accessible          = true
  dms_replication_instance_vpc_security_group_ids = [
    module.sg_single_db_mysql.security_group_id
  ]

  # Enable DMS tasks
  enable_dms_replication_task = true
  dms_replication_tasks = {
    src1_dest1 = {
      source_endpoint_key = "source1"
      target_endpoint_key = "destination1"

      migration_type      = "full-load"
      replication_task_id = "${local.name}-${local.environment}-${local.eucentral1_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
      table_mappings      = data.template_file.table_mappings.rendered

      cdc_start_time            = ""
      replication_task_settings = ""
    }

    src1_dest2 = {
      source_endpoint_key = "source1"
      target_endpoint_key = "destination2"

      migration_type      = "full-load"
      replication_task_id = "${local.name}-${local.environment}-${local.euwest2_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
      table_mappings      = data.template_file.table_mappings.rendered

      cdc_start_time            = ""
      replication_task_settings = ""
    }

    src1_dest3 = {
      source_endpoint_key = "source1"
      target_endpoint_key = "destination3"

      migration_type      = "full-load"
      replication_task_id = "${local.name}-${local.environment}-${local.cacentral1_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
      table_mappings      = data.template_file.table_mappings.rendered

      cdc_start_time            = ""
      replication_task_settings = ""
    }

    src1_dest4 = {
      source_endpoint_key = "source1"
      target_endpoint_key = "destination4"

      migration_type      = "full-load"
      replication_task_id = "${local.name}-${local.environment}-${local.apnortheast1_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
      table_mappings      = data.template_file.table_mappings.rendered

      cdc_start_time            = ""
      replication_task_settings = ""
    }

    src1_dest5 = {
      source_endpoint_key = "source1"
      target_endpoint_key = "destination5"

      migration_type      = "full-load"
      replication_task_id = "${local.name}-${local.environment}-${local.apsoutheast2_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
      table_mappings      = data.template_file.table_mappings.rendered

      cdc_start_time            = ""
      replication_task_settings = ""
    }

    src1_dest6 = {
      source_endpoint_key = "source1"
      target_endpoint_key = "destination6"

      migration_type      = "full-load"
      replication_task_id = "${local.name}-${local.environment}-${local.westeurope_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
      table_mappings      = data.template_file.table_mappings.rendered

      cdc_start_time            = ""
      replication_task_settings = ""
    }

    src1_dest7 = {
      source_endpoint_key = "source1"
      target_endpoint_key = "destination7"

      migration_type = "full-load"
      # replication_task_id      = "${local.name}-${local.environment}-${local.westus2_dms_target_endpoint_properties["dms_endpoint_region"]}-dms-replication-task"
      table_mappings = data.template_file.table_mappings.rendered

      cdc_start_time            = ""
      replication_task_settings = ""
    }
  }

  # Enable DMS event subscription
  enable_dms_event_subscription = true
  dms_event_subscriptions = [
    {
      name                             = "instance-events"
      enabled                          = true
      instance_event_subscription_keys = ["example"]
      source_ids                       = []
      source_type                      = "replication-instance"
      sns_topic_arn                    = module.dms_sns.sns_topic_arn
      # https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DescribeEventCategories.html
      event_categories = [
        "failure",
        "creation",
        "deletion",
        "maintenance",
        "failover",
        "low storage",
        "configuration change"
      ],
      tags = {}
    },
    {
      name                             = "task-events"
      enabled                          = true
      instance_event_subscription_keys = ["cdc_ex"]
      source_ids                       = []
      source_type                      = "replication-task"
      sns_topic_arn                    = module.dms_sns.sns_topic_arn
      # https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DescribeEventCategories.html
      event_categories = [
        "failure",
        "state change",
        "creation",
        "deletion",
        "configuration change"
      ],
      tags = {}
    }
  ]


  tags = local.tags

  depends_on = [
    module.time_sleep,
    module.dms_sns,
    module.sg_single_db_mysql
  ]
}

# Reference the DMS table mappings
data "template_file" "table_mappings" {
  template = file("./additional_files/dms_replication_task_table_mappings.json.tpl")
}
