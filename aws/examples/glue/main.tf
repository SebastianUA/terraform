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


module "aws_user_tags" {
  source = "./aws_user_tags"

  environment = "DEV"
  custom_tags = {
    "CreatedBy" = "Vitalii Natarov"
  }
}

# Create example glue service policy from template
module "iam_glue_example_service_policy" {
  source      = "git@github.com:SebastianUA/terraform.git//aws/modules/iam_policy?ref=master"
  name        = "TEST-iam-policy"
  environment = "stage"

  # Using IAM policy
  enable_iam_policy      = true
  iam_policy_name        = "glue_example_service_policy"
  iam_policy_description = "Example Glue Service Policy"
  iam_policy_path        = "/"
  iam_policy_policy = templatefile(
    "./templates/json/glue_service_policy.json",
    {
      partition = data.aws_partition.current.partition
    }
  )
}

# Create example glue user policy from template
module "iam_glue_example_user_policy" {
  source      = "git@github.com:SebastianUA/terraform.git//aws/modules/iam_policy?ref=master"
  name        = "TEST-iam-policy"
  environment = "stage"

  # Using IAM policy
  enable_iam_policy      = true
  iam_policy_name        = "glue_example_user_policy"
  iam_policy_description = "Example Glue User Policy"
  iam_policy_path        = "/"
  iam_policy_policy = templatefile(
    "./templates/json/glue_user_policy.json",
    {
      partition = data.aws_partition.current.partition
    }
  )
}

module "glue_example_admin_role" {
  source      = "git@github.com:SebastianUA/terraform.git//aws/modules/iam_role?ref=master"
  name        = "test"
  environment = "DEV"

  # Using IAM role
  enable_iam_role      = true
  iam_role_name        = "glue_example_role"
  iam_role_description = "glue example role"

  iam_role_assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "glue.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy
  // enable_iam_role_policy = true
  // iam_role_policy_name   = "my-iam-role-policy-for-testing-terraform"
  // iam_role_policy        = file("templates/iam_role_policy.json")

  # Using IAM role policy attachment
  enable_iam_role_policy_attachment = true
  iam_role_policy_attachment_policy_arns = [
    // Attach AWS managed policy: AWSCloudFormationReadOnlyAccess
    "arn:${data.aws_partition.current.partition}:iam::${data.aws_partition.current.partition}:policy/AWSCloudFormationReadOnlyAccess",
    // Attach AWS managed policy: AWSGlueConsoleFullAccess
    "arn:${data.aws_partition.current.partition}:iam::${data.aws_partition.current.partition}:policy/AWSGlueConsoleFullAccess",
    // Attach AWS managed policy: AWSGlueConsoleSageMakerNotebookFullAccess
    "arn:${data.aws_partition.current.partition}:iam::${data.aws_partition.current.partition}:policy/AWSGlueConsoleSageMakerNotebookFullAccess",
    // Attach AWS managed policy: AWSGlueSchemaRegistryFullAccess
    "arn:${data.aws_partition.current.partition}:iam::${data.aws_partition.current.partition}:policy/AWSGlueSchemaRegistryFullAccess",
    // Attach AWS managed policy: AmazonAthenaFullAccess
    "arn:${data.aws_partition.current.partition}:iam::${data.aws_partition.current.partition}:policy/AmazonAthenaFullAccess",
    // Attach AWS managed policy: AmazonS3FullAccess
    "arn:${data.aws_partition.current.partition}:iam::${data.aws_partition.current.partition}:policy/AmazonS3FullAccess",
    // Attach AWS managed policy: CloudWatchLogsReadOnlyAccess
    "arn:${data.aws_partition.current.partition}:iam::${data.aws_partition.current.partition}:policy/CloudWatchLogsReadOnlyAccess"
  ]
}

module "s3_private_glue_catalog" {
  source      = "git@github.com:SebastianUA/terraform.git//aws/modules/s3?ref=master"
  name        = "test"
  environment = "DEV"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "glue-catalog-${data.aws_caller_identity.current.account_id}"
  s3_bucket_acl    = "private"

  # Create test folder in the bucket
  enable_s3_bucket_object = true
  s3_bucket_object_stack = [
    {
      key = "/catalog"
    }
  ]

  tags = merge(
    module.aws_user_tags.tags,
    var.example_tags
  )
}

# Create glue crawler bucket (account_id ensures unique name across accounts)
module "s3_private_glue_crawler" {
  source      = "git@github.com:SebastianUA/terraform.git//aws/modules/s3?ref=master"
  name        = "test"
  environment = "DEV"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "glue-crawler-${data.aws_caller_identity.current.account_id}"
  s3_bucket_acl    = "private"

  # Create crawler folder in the bucket
  enable_s3_bucket_object = true
  s3_bucket_object_stack = [
    {
      key = "/crawler"
    }
  ]

  tags = merge(
    module.aws_user_tags.tags,
    var.example_tags
  )
}

# Create Glue job bucket (account_id ensures unique name across accounts)
module "s3_private_glue_jobs" {
  source      = "git@github.com:SebastianUA/terraform.git//aws/modules/s3?ref=master"
  name        = "test"
  environment = "DEV"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "glue-jobs-${data.aws_caller_identity.current.account_id}"
  s3_bucket_acl    = "private"

  # Create crawler folder in the bucket
  enable_s3_bucket_object = true
  s3_bucket_object_stack = [
    {
      key = "/jobs"
    }
  ]

  tags = merge(
    module.aws_user_tags.tags,
    var.example_tags
  )
}

# Generation random password
module "random_glue_connection_password" {
  source = "git@github.com:SebastianUA/terraform.git//random/modules/random?ref=master"

  # Generate random password
  enable_password           = true
  password_length           = 13
  password_special          = true
  password_override_special = "_%@"
}

# terraform-aws-glue module
module "glue" {
  source      = "../../modules/glue"
  name        = "TEST"
  environment = "STAGE"
  # AWS Glue catalog DB
  enable_glue_catalog_database     = true
  glue_catalog_database_name       = "test-glue-db-${data.aws_caller_identity.current.account_id}"
  glue_catalog_database_parameters = null
  # AWS Glue catalog table
  enable_glue_catalog_table      = true
  glue_catalog_table_name        = "test-glue-table-${data.aws_caller_identity.current.account_id}"
  glue_catalog_table_description = "Those resources are managed by Terraform. Created by Vitaliy Natarov"
  glue_catalog_table_table_type  = "EXTERNAL_TABLE"
  glue_catalog_table_parameters = {
    "sizeKey"        = 493378
    "tmp"            = "none"
    "test"           = "yes"
    "classification" = "csv"
  }
  glue_catalog_table_storage_descriptor = {
    location      = "s3://${module.s3_private_glue_catalog.s3_bucket_id}/test"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    columns = [
      {
        columns_name    = "oid"
        columns_type    = "double"
        columns_comment = "oid"
      },
      {
        columns_name    = "oid2"
        columns_type    = "double"
        columns_comment = "oid2"
      },
      {
        columns_name    = "oid3"
        columns_type    = "double"
        columns_comment = "oid3"
      },
    ]

    ser_de_info = [
      {
        ser_de_info_name                  = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
        ser_de_info_serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
        ser_de_info_parameters            = tomap({ "field.delim" = "," })
      }
    ]

    skewed_info = [
      {
        ser_de_info_name                  = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
        ser_de_info_serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
        ser_de_info_parameters            = tomap({ "field.delim" = "," })
      }
    ]

    sort_columns = []
  }


  # AWS Glue connection
  enable_glue_connection = true
  glue_connection_connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:mysql://aws_rds_cluster.example.endpoint/exampledatabase"
    PASSWORD            = module.random_glue_connection_password.password_result
    USERNAME            = var.glue_connection_user_name
  }
  ##glue_connection_physical_connection_requirements        = [{
  #    availability_zone       = "zone_here"
  #    security_group_id_list  = []
  #    subnet_id               = "subnet_here"
  #}]
  enable_glue_crawler                = true
  glue_crawler_name                  = ""
  glue_crawler_role                  = module.glue_example_admin_role.iam_role_arn
  enable_glue_security_configuration = false
  glue_security_configuration_name   = ""
  glue_crawler_s3_target = [
    {
      path       = "s3://${module.s3_private_glue_crawler.s3_bucket_id}/crawler"
      exclusions = []
    }
  ]

  enable_glue_job                 = true
  glue_job_name                   = ""
  glue_job_role_arn               = module.glue_example_admin_role.iam_role_arn
  glue_job_additional_connections = []
  glue_job_execution_property = [
    {
      max_concurrent_runs = 2
    }
  ]
  glue_job_command = [
    {
      script_location = "s3//${module.s3_private_glue_jobs.s3_bucket_id}/jobs"
      name            = "jobs"
    }
  ]
  tags = merge(
    module.aws_user_tags.tags,
    tomap({
      "cost-center" = "00-00000.000.01",
      "Project"     = "My Test Glue Project"
    })
  )

  depends_on = [
    module.aws_user_tags
  ]
}

module "glue_trigger" {
  source      = "../../modules/glue"
  name        = "TEST"
  environment = "STAGE"

  enable_glue_trigger = true
  glue_trigger_name   = ""
  glue_trigger_actions = [
    {
      # Both JobName or CrawlerName cannot be set together in an action
      crawler_name = module.glue.glue_crawler_id # null
      job_name     = null                        # module.glue.glue_job_id
      arguments    = null
      timeout      = null
    }
  ]

  glue_trigger_predicate = {
    logical = "AND"
    conditions = [
      {
        job_name         = "job-name-1"
        state            = null
        crawler_name     = null
        crawl_state      = null
        logical_operator = "EQUALS"
      },
      {
        job_name         = "job-name-2"
        state            = null
        crawler_name     = null
        crawl_state      = null
        logical_operator = "EQUALS"
      }
    ]
  }

  tags = merge(
    module.aws_user_tags.tags,
    tomap({
      "cost-center" = "00-00000.000.01",
      "Project"     = "My Test Glue Project"
    })
  )

  depends_on = [
    module.glue,
    module.aws_user_tags
  ]
}