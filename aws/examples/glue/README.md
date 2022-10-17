# Work with GLUE via terraform

A terraform module for making GLUE.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_glue_catalog_database` - Enable glue catalog database usage (`default = False`)
- `glue_catalog_database_name` - The name of the database. (`default = ""`)
- `glue_catalog_database_description` - (Optional) Description of the database. (`default = null`)
- `glue_catalog_database_catalog_id` - (Optional) ID of the Glue Catalog to create the database in. If omitted, this defaults to the AWS Account ID. (`default = null`)
- `glue_catalog_database_location_uri` - (Optional) The location of the database (for example, an HDFS path). (`default = null`)
- `glue_catalog_database_parameters` - (Optional) A list of key-value pairs that define parameters and properties of the database. (`default = null`)
- `enable_glue_catalog_table` - Enable glue catalog table usage (`default = False`)
- `glue_catalog_table_name` - Name of the table. For Hive compatibility, this must be entirely lowercase. (`default = ""`)
- `glue_catalog_table_database_name` - Name of the metadata database where the table metadata resides. For Hive compatibility, this must be all lowercase. (`default = ""`)
- `glue_catalog_table_description` - (Optional) Description of the table. (`default = null`)
- `glue_catalog_table_catalog_id` - (Optional) ID of the Glue Catalog and database to create the table in. If omitted, this defaults to the AWS Account ID plus the database name. (`default = null`)
- `glue_catalog_table_owner` - (Optional) Owner of the table. (`default = null`)
- `glue_catalog_table_retention` - (Optional) Retention time for this table. (`default = null`)
- `glue_catalog_table_partition_keys` - (Optional) A list of columns by which the table is partitioned. Only primitive types are supported as partition keys. (`default = []`)
- `glue_catalog_table_view_original_text` - (Optional) If the table is a view, the original text of the view; otherwise null. (`default = null`)
- `glue_catalog_table_view_expanded_text` - (Optional) If the table is a view, the expanded text of the view; otherwise null. (`default = null`)
- `glue_catalog_table_table_type` - (Optional) The type of this table (EXTERNAL_TABLE, VIRTUAL_VIEW, etc.). (`default = null`)
- `glue_catalog_table_parameters` - (Optional) Properties associated with this table, as a list of key-value pairs. (`default = null`)
- `glue_catalog_table_storage_descriptor` - (Optional) A storage descriptor object containing information about the physical storage of this table. You can refer to the Glue Developer Guide for a full explanation of this object. (`default = {'location': None, 'input_format': None, 'output_format': None, 'compressed': None, 'number_of_buckets': None, 'bucket_columns': None, 'parameters': None, 'stored_as_sub_directories': None}`)
- `enable_glue_classifier` - Enable glue classifier usage (`default = False`)
- `glue_classifier_name` - The name of the classifier. (`default = ""`)
- `glue_classifier_csv_classifier` - (Optional) A classifier for Csv content.  (`default = []`)
- `glue_classifier_grok_classifier` - (Optional) A classifier for grok content.  (`default = []`)
- `glue_classifier_json_classifier` - (Optional) A classifier for json content.  (`default = []`)
- `glue_classifier_xml_classifier` - (Optional) A classifier for xml content.  (`default = []`)
- `enable_glue_connection` - Enable glue connection usage (`default = False`)
- `glue_connection_name` - The name of the connection. (`default = ""`)
- `glue_connection_connection_properties` - (Required) A map of key-value pairs used as parameters for this connection. (`default = {}`)
- `glue_connection_description` - (Optional) Description of the connection. (`default = null`)
- `glue_connection_catalog_id` - (Optional) The ID of the Data Catalog in which to create the connection. If none is supplied, the AWS account ID is used by default. (`default = null`)
- `glue_connection_connection_type` - (Optional) The type of the connection. Supported are: JDBC, MONGODB. Defaults to JDBC. (`default = JDBC`)
- `glue_connection_match_criteria` - (Optional) A list of criteria that can be used in selecting this connection. (`default = null`)
- `glue_connection_physical_connection_requirements` - (Optional) A map of physical connection requirements, such as VPC and SecurityGroup.  (`default = []`)
- `enable_glue_crawler` - Enable glue crawler usage (`default = False`)
- `glue_crawler_name` - Name of the crawler. (`default = ""`)
- `glue_crawler_database_name` - Glue database where results are written. (`default = ""`)
- `glue_crawler_role` - (Required) The IAM role friendly name (including path without leading slash), or ARN of an IAM role, used by the crawler to access other resources. (`default = ""`)
- `glue_crawler_description` - (Optional) Description of the crawler. (`default = null`)
- `glue_crawler_classifiers` - (Optional) List of custom classifiers. By default, all AWS classifiers are included in a crawl, but these custom classifiers always override the default classifiers for a given classification. (`default = null`)
- `glue_crawler_configuration` - (Optional) JSON string of configuration information. (`default = null`)
- `glue_crawler_schedule` - (Optional) A cron expression used to specify the schedule. For more information, see Time-Based Schedules for Jobs and Crawlers. For example, to run something every day at 12:15 UTC, you would specify: cron(15 12 * * ? *). (`default = null`)
- `glue_crawler_security_configuration` - (Optional) The name of Security Configuration to be used by the crawler (`default = null`)
- `glue_crawler_table_prefix` - (Optional) The table prefix used for catalog tables that are created. (`default = null`)
- `glue_crawler_dynamodb_target` - (Optional) List of nested DynamoDB target arguments. (`default = []`)
- `glue_crawler_jdbc_target` - (Optional) List of nested JBDC target arguments.  (`default = []`)
- `glue_crawler_s3_target` - (Optional) List nested Amazon S3 target arguments. (`default = []`)
- `glue_crawler_catalog_target` - (Optional) List nested Amazon catalog target arguments. (`default = []`)
- `glue_crawler_schema_change_policy` - (Optional) Policy for the crawler's update and deletion behavior. (`default = []`)
- `glue_crawler_recrawl_policy` - Optional) A policy that specifies whether to crawl the entire dataset again, or to crawl only folders that were added since the last crawler run. (`default = []`)
- `glue_crawler_mongodb_target` - (Optional) List nested MongoDB target arguments. (`default = []`)
- `glue_crawler_lineage_configuration` - (Optional) Specifies data lineage configuration settings for the crawler. (`default = []`)
- `enable_glue_security_configuration` - Enable glue security configuration usage (`default = False`)
- `glue_security_configuration_name` - Name of the security configuration. (`default = ""`)
- `glue_security_configuration_encryption_configuration` - Set encryption configuration for Glue security configuration (`default = {}`)
- `enable_glue_workflow` - Enable glue workflow usage (`default = False`)
- `glue_workflow_name` - The name you assign to this workflow. (`default = ""`)
- `glue_workflow_description` - (Optional) Description of the workflow. (`default = null`)
- `glue_workflow_default_run_properties` - (Optional) A map of default run properties for this workflow. These properties are passed to all jobs associated to the workflow. (`default = null`)
- `enable_glue_job` - Enable glue job usage (`default = False`)
- `glue_job_name` - The name you assign to this job. It must be unique in your account. (`default = ""`)
- `glue_job_role_arn` - The ARN of the IAM role associated with this job. (`default = null`)
- `glue_job_command` - (Required) The command of the job. (`default = []`)
- `glue_job_description` - (Optional) Description of the job. (`default = null`)
- `glue_job_connections` - (Optional) The list of connections used for this job. (`default = []`)
- `glue_job_additional_connections` - (Optional) The list of connections used for the job. (`default = []`)
- `glue_job_default_arguments` - (Optional) The map of default arguments for this job. You can specify arguments here that your own job-execution script consumes, as well as arguments that AWS Glue itself consumes. For information about how to specify and consume your own Job arguments, see the Calling AWS Glue APIs in Python topic in the developer guide. For information about the key-value pairs that AWS Glue consumes to set up your job, see the Special Parameters Used by AWS Glue topic in the developer guide. (`default = {'--job-language': 'python'}`)
- `glue_job_execution_property` - (Optional) Execution property of the job. (`default = []`)
- `glue_job_glue_version` - (Optional) The version of glue to use, for example '1.0'. For information about available versions, see the AWS Glue Release Notes. (`default = null`)
- `glue_job_execution_class` - (Optional) Indicates whether the job is run with a standard or flexible execution class. The standard execution class is ideal for time-sensitive workloads that require fast job startup and dedicated resources. Valid value: FLEX, STANDARD. (`default = null`)
- `glue_job_max_capacity` - (Optional) The maximum number of AWS Glue data processing units (DPUs) that can be allocated when this job runs. Required when pythonshell is set, accept either 0.0625 or 1.0. (`default = null`)
- `glue_job_max_retries` - (Optional) The maximum number of times to retry this job if it fails. (`default = null`)
- `glue_job_notification_property` - (Optional) Notification property of the job. (`default = []`)
- `glue_job_timeout` - (Optional) The job timeout in minutes. The default is 2880 minutes (48 hours). (`default = 2880`)
- `glue_job_security_configuration` - (Optional) The name of the Security Configuration to be associated with the job. (`default = null`)
- `glue_job_worker_type` - (Optional) The type of predefined worker that is allocated when a job runs. Accepts a value of Standard, G.1X, or G.2X. (`default = null`)
- `glue_job_number_of_workers` - (Optional) The number of workers of a defined workerType that are allocated when a job runs. (`default = null`)
- `enable_glue_trigger` - Enable glue trigger usage (`default = False`)
- `glue_trigger_name` - The name of the trigger. (`default = ""`)
- `glue_trigger_type` - (Required) The type of trigger. Valid values are CONDITIONAL, ON_DEMAND, and SCHEDULED. (`default = ON_DEMAND`)
- `glue_trigger_description` - (Optional) A description of the new trigger. (`default = null`)
- `glue_trigger_enabled` - (Optional) Start the trigger. Defaults to true. Not valid to disable for ON_DEMAND type. (`default = null`)
- `glue_trigger_schedule` - (Optional) A cron expression used to specify the schedule. Time-Based Schedules for Jobs and Crawlers (`default = null`)
- `glue_trigger_workflow_name` - (Optional) A workflow to which the trigger should be associated to. Every workflow graph (DAG) needs a starting trigger (ON_DEMAND or SCHEDULED type) and can contain multiple additional CONDITIONAL triggers. (`default = null`)
- `glue_trigger_actions` - (Required) List of actions initiated by this trigger when it fires.  (`default = []`)
- `glue_trigger_timeouts` - Set timeouts for glue trigger (`default = {}`)
- `glue_trigger_predicate` - (Optional) A predicate to specify when the new trigger should fire. Required when trigger type is CONDITIONAL (`default = {}`)
- `enable_glue_data_catalog_encryption_settings` - Enable glue data catalog encryption settings usage (`default = False`)
- `glue_data_catalog_encryption_settings_data_catalog_encryption_settings` - Set data_catalog_encryption_settings block for Glue data catalog encryption (`default = {}`)
- `glue_data_catalog_encryption_settings_catalog_id` - (Optional) The ID of the Data Catalog to set the security configuration for. If none is provided, the AWS account ID is used by default. (`default = null`)
- `enable_glue_dev_endpoint` - Enable glue dev endpoint usage (`default = False`)
- `glue_dev_endpoint_name` - The name of this endpoint. It must be unique in your account. (`default = ""`)
- `glue_dev_endpoint_role_arn` - (Required) The IAM role for this endpoint. (`default = null`)
- `glue_dev_endpoint_arguments` - (Optional) A map of arguments used to configure the endpoint. (`default = null`)
- `glue_dev_endpoint_extra_jars_s3_path` - (Optional) Path to one or more Java Jars in an S3 bucket that should be loaded in this endpoint. (`default = null`)
- `glue_dev_endpoint_extra_python_libs_s3_path` - (Optional) Path(s) to one or more Python libraries in an S3 bucket that should be loaded in this endpoint. Multiple values must be complete paths separated by a comma. (`default = null`)
- `glue_dev_endpoint_glue_version` - (Optional) - Specifies the versions of Python and Apache Spark to use. Defaults to AWS Glue version 0.9. (`default = null`)
- `glue_dev_endpoint_number_of_nodes` - (Optional) The number of AWS Glue Data Processing Units (DPUs) to allocate to this endpoint. Conflicts with worker_type (`default = null`)
- `glue_dev_endpoint_number_of_workers` - (Optional) The number of workers of a defined worker type that are allocated to this endpoint. This field is available only when you choose worker type G.1X or G.2X. (`default = null`)
- `glue_dev_endpoint_public_key` - (Optional) The public key to be used by this endpoint for authentication. (`default = null`)
- `glue_dev_endpoint_public_keys` - (Optional) A list of public keys to be used by this endpoint for authentication. (`default = null`)
- `glue_dev_endpoint_security_configuration` - (Optional) The name of the Security Configuration structure to be used with this endpoint. (`default = null`)
- `glue_dev_endpoint_security_group_ids` - (Optional) Security group IDs for the security groups to be used by this endpoint. (`default = null`)
- `glue_dev_endpoint_subnet_id` - (Optional) The subnet ID for the new endpoint to use. (`default = null`)
- `glue_dev_endpoint_worker_type` - (Optional) The type of predefined worker that is allocated to this endpoint. Accepts a value of Standard, G.1X, or G.2X. (`default = null`)
- `enable_glue_ml_transform` - Enable glue ml transform usage (`default = False`)
- `glue_ml_transform_name` - The name you assign to this ML Transform. It must be unique in your account. (`default = ""`)
- `glue_ml_transform_role_arn` - (Required) The ARN of the IAM role associated with this ML Transform. (`default = null`)
- `glue_ml_transform_input_record_tables` - (Required) A list of AWS Glue table definitions used by the transform. see Input Record Tables. (`default = []`)
- `glue_ml_transform_parameters` - (Required) The algorithmic parameters that are specific to the transform type used. Conditionally dependent on the transform type. see Parameters. (`default = []`)
- `glue_ml_transform_description` - (Optional) Description of the ML Transform. (`default = null`)
- `glue_ml_transform_glue_version` - (Optional) The version of glue to use, for example '1.0'. For information about available versions, see the AWS Glue Release Notes. (`default = null`)
- `glue_ml_transform_max_capacity` - (Optional) The number of AWS Glue data processing units (DPUs) that are allocated to task runs for this transform. You can allocate from 2 to 100 DPUs; the default is 10. max_capacity is a mutually exclusive option with number_of_workers and worker_type. (`default = null`)
- `glue_ml_transform_max_retries` - (Optional) The maximum number of times to retry this ML Transform if it fails. (`default = null`)
- `glue_ml_transform_timeout` - (Optional) The ML Transform timeout in minutes. The default is 2880 minutes (48 hours). (`default = null`)
- `glue_ml_transform_worker_type` - (Optional) The type of predefined worker that is allocated when an ML Transform runs. Accepts a value of Standard, G.1X, or G.2X. Required with number_of_workers. (`default = null`)
- `glue_ml_transform_number_of_workers` - (Optional) The number of workers of a defined worker_type that are allocated when an ML Transform runs. Required with worker_type (`default = null`)
- `enable_glue_partition` - Enable glue partition usage (`default = False`)
- `glue_partition_database_name` - Name of the metadata database where the table metadata resides. For Hive compatibility, this must be all lowercase. (`default = ""`)
- `glue_partition_table_name` - Table name (`default = ""`)
- `glue_partition_partition_values` - (Required) The values that define the partition. (`default = []`)
- `glue_partition_catalog_id` - (Optional) ID of the Glue Catalog and database to create the table in. If omitted, this defaults to the AWS Account ID plus the database name. (`default = null`)
- `glue_partition_parameters` - (Optional) Properties associated with this table, as a list of key-value pairs. (`default = null`)
- `glue_partition_storage_descriptor` - (Optional) A storage descriptor object containing information about the physical storage of this table. You can refer to the Glue Developer Guide for a full explanation of this object. (`default = {'location': None, 'input_format': None, 'output_format': None, 'compressed': None, 'number_of_buckets': None, 'bucket_columns': None, 'parameters': None, 'stored_as_sub_directories': None}`)
- `enable_glue_registry` - Enable glue registry usage (`default = False`)
- `glue_registry_name` - The Name of the registry. (`default = ""`)
- `glue_registry_description` - (Optional) A description of the registry. (`default = null`)
- `enable_glue_resource_policy` - Enable glue resource policy usage (`default = False`)
- `glue_resource_policy` - (Required) The policy to be applied to the aws glue data catalog. (`default = null`)
- `enable_glue_schema` - Enable glue schema usage (`default = False`)
- `glue_schema_name` - The Name of the schema. (`default = ""`)
- `glue_schema_registry_arn` - The ARN of the Glue Registry to create the schema in. (`default = ""`)
- `glue_schema_data_format` - (Required) The data format of the schema definition. Currently only AVRO is supported. (`default = null`)
- `glue_schema_compatibility` - (Required) The compatibility mode of the schema. Values values are: NONE, DISABLED, BACKWARD, BACKWARD_ALL, FORWARD, FORWARD_ALL, FULL, and FULL_ALL. (`default = null`)
- `glue_schema_schema_definition` - (Required) The schema definition using the data_format setting for schema_name. (`default = null`)
- `glue_schema_description` - (Optional) A description of the schema. (`default = null`)
- `enable_glue_user_defined_function` - Enable glue user defined function usage (`default = False`)
- `glue_user_defined_function_name` - The name of the function. (`default = ""`)
- `glue_user_defined_function_database_name` - The name of the Database to create the Function. (`default = ""`)
- `glue_user_defined_function_class_name` - (Required) The Java class that contains the function code. (`default = null`)
- `glue_user_defined_function_owner_name` - (Required) The owner of the function. (`default = null`)
- `glue_user_defined_function_owner_type` - (Required) The owner type. can be one of USER, ROLE, and GROUP. (`default = null`)
- `glue_user_defined_function_catalog_id` - (Optional) ID of the Glue Catalog to create the function in. If omitted, this defaults to the AWS Account ID. (`default = null`)
- `glue_user_defined_function_resource_uris` - (Optional) The configuration block for Resource URIs. See resource uris below for more details. (`default = []`)
- `enable_glue_partition_index` - Enable glue partition index usage (`default = False`)
- `glue_partition_index_table_name` - Name of the table. For Hive compatibility, this must be entirely lowercase. (`default = ""`)
- `glue_partition_index_database_name` - (Required) Name of the metadata database where the table metadata resides. For Hive compatibility, this must be all lowercase. (`default = ""`)
- `glue_partition_index_catalog_id` - (Optional) The catalog ID where the table resides. (`default = ""`)
- `glue_partition_index_partition_index` - (Required) Configuration block for a partition index. (`default = []`)
- `glue_partition_index_timeouts` - Set timeouts glue partition index (`default = {}`)

## Module Output Variables
----------------------
- `glue_catalog_database_arn` - ARN for glue catalog database
- `glue_catalog_database_id` - ID for glue catalog database
- `glue_catalog_database_name` - Name for glue catalog database
- `glue_catalog_table_arn` - ARN for glue catalog table
- `glue_catalog_table_id` - ID for glue catalog table
- `glue_catalog_table_name` - Name for glue catalog table
- `glue_classifier_id` - Name of the classifier
- `glue_connection_id` - Catalog ID and name of the connection
- `glue_crawler_id` - Crawler name
- `glue_crawler_arn` - The ARN of the crawler
- `glue_security_configuration_id` - Glue security configuration name
- `glue_workflow_id` - Glue workflow name
- `glue_job_id` - Glue job name
- `glue_job_arn` - Amazon Resource Name (ARN) of Glue Job
- `glue_trigger_id` - Trigger name
- `glue_trigger_arn` - Amazon Resource Name (ARN) of Glue Trigger
- `glue_data_catalog_encryption_settings_id` - The ID of the Data Catalog to set the security configuration for.
- `glue_dev_endpoint_id` - The ID of the endpoint.
- `glue_dev_endpoint_arn` - The ARN of the endpoint.
- `glue_dev_endpoint_name` - The name of the new endpoint.
- `glue_dev_endpoint_private_address` - A private IP address to access the endpoint within a VPC, if this endpoint is created within one.
- `glue_dev_endpoint_public_address` - The public IP address used by this endpoint. The PublicAddress field is present only when you create a non-VPC endpoint.
- `glue_dev_endpoint_yarn_endpoint_address` - The YARN endpoint address used by this endpoint.
- `glue_dev_endpoint_zeppelin_remote_spark_interpreter_port` - The Apache Zeppelin port for the remote Apache Spark interpreter.
- `glue_dev_endpoint_availability_zone` - The AWS availability zone where this endpoint is located.
- `glue_dev_endpoint_vpc_id` - The ID of the VPC used by this endpoint.
- `glue_dev_endpoint_status` - The current status of this endpoint.
- `glue_dev_endpoint_failure_reason` - The reason for a current failure in this endpoint.
- `glue_ml_transform_id` - Glue ML Transform ID.
- `glue_ml_transform_arn` - Amazon Resource Name (ARN) of Glue ML Transform.
- `glue_ml_transform_label_count` - The number of labels available for this transform.
- `glue_ml_transform_schema` - The object that represents the schema that this transform accepts. see Schema.
- `glue_partition_id` - partition id.
- `glue_partition_creation_time` - The time at which the partition was created.
- `glue_partition_last_analyzed_time` - The last time at which column statistics were computed for this partition.
- `glue_partition_last_accessed_time` - The last time at which the partition was accessed.
- `glue_registry_id` - Amazon Resource Name (ARN) of Glue Registry.
- `glue_registry_arn` - Amazon Resource Name (ARN) of Glue Registry.
- `glue_resource_policy_id` - The ID of Glue resource policy.
- `glue_schema_id` - Amazon Resource Name (ARN) of the schema.
- `glue_schema_arn` - Amazon Resource Name (ARN) of the schema.
- `glue_schema_registry_name` - The name of the Glue Registry.
- `glue_schema_latest_schema_version` - The latest version of the schema associated with the returned schema definition.
- `glue_schema_next_schema_version` - The next version of the schema associated with the returned schema definition.
- `glue_schema_schema_checkpoint` - The version number of the checkpoint (the last time the compatibility mode was changed).
- `glue_user_defined_function_id` - The id of the Glue User Defined Function.
- `glue_user_defined_function_arn` - The ARN of the Glue User Defined Function.
- `glue_user_defined_function_create_time` - The time at which the function was created.
- `glue_partition_index_id` - Catalog ID, Database name, table name, and index name.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
