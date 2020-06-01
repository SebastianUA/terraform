# Work with AWS Glue via terraform

A terraform module for making Glue.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "glue" {
    source                                                  = "../../modules/glue"
    name                                                    = "TEST"
    environment                                             = "stage"

    # AWS Glue catalog DB
    enable_glue_catalog_database                            = true
    glue_catalog_database_name                              = "test-glue-db-test"
    glue_catalog_database_parameters                        = null

    # AWS Glue catalog table
    enable_glue_catalog_table                               = true
    glue_catalog_table_name                                 = "test-glue-table-test"
    glue_catalog_table_description                          = "Those resources are managed by Terraform. Created by Vitaliy Natarov"
    glue_catalog_table_table_type                           = "EXTERNAL_TABLE"
    glue_catalog_table_parameters                           = {
        "sizeKey"                           = 493378
        "tmp"                               = "none"
        "test"                              = "yes"
        "classification"                    = "csv"
    }


    storage_descriptor_location      = "s3://my-test-bucket/test/"
    storage_descriptor_input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    storage_descriptor_output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    storage_descriptor_columns       = [
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


    storage_descriptor_ser_de_info  = []
    storage_descriptor_sort_columns = []
    storage_descriptor_skewed_info  = [
        {
            ser_de_info_name                  = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
            ser_de_info_serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
            ser_de_info_parameters            = map("field.delim", ",")
        }

    ]


    # AWS Glue connection
    enable_glue_connection                                  = true
    glue_connection_connection_properties                   = {
        JDBC_CONNECTION_URL = "jdbc:mysql://aws_rds_cluster.example.endpoint/exampledatabase"
        PASSWORD            = "examplepassword"
        USERNAME            = "exampleusername"
    }

    enable_glue_crawler                                     = true
    glue_crawler_name                                       = ""
    glue_crawler_role                                       = "arn:aws:iam::167127734783:role/emr-service-role"

    #glue_crawler_catalog_target                            = map("database_name", "")
    #glue_crawler_schema_change_policy                      = map("delete_behavior", "LOG", "update_behavior", "LOG")

    enable_glue_security_configuration                      = true
    glue_security_configuration_name                        = ""


    enable_glue_trigger                                     = true
    glue_trigger_name                                       = ""


    tags = map(
        "Env", "stage",
        "Orchestration", "Terraform",
        "Createdby", "Vitalii Natarov"
    )
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
- `storage_descriptor_location` - (Optional) The physical location of the table. By default this takes the form of the warehouse location, followed by the database location in the warehouse, followed by the table name. (`default = null`)
- `storage_descriptor_input_format` - (Optional) The input format: SequenceFileInputFormat (binary), or TextInputFormat, or a custom format. (`default = null`)
- `storage_descriptor_output_format` - (Optional) The output format: SequenceFileOutputFormat (binary), or IgnoreKeyTextOutputFormat, or a custom format. (`default = []`)
- `storage_descriptor_compressed` - (Optional) True if the data in the table is compressed, or False if not. (`default = null`)
- `storage_descriptor_number_of_buckets` - (Optional) Must be specified if the table contains any dimension columns. (`default = null`)
- `storage_descriptor_bucket_columns` - (Optional) A list of reducer grouping columns, clustering columns, and bucketing columns in the table. (`default = null`)
- `storage_descriptor_parameters` - (Optional) User-supplied properties in key-value form. (`default = null`)
- `storage_descriptor_stored_as_sub_directories` - (Optional) True if the table data is stored in subdirectories, or False if not. (`default = null`)
- `storage_descriptor_columns` - (Optional) A list of the Columns in the table. (`default = []`)
- `storage_descriptor_ser_de_info` - (Optional) Serialization/deserialization (SerDe) information. (`default = []`)
- `storage_descriptor_sort_columns` - (Optional) A list of Order objects specifying the sort order of each bucket in the table. (`default = []`)
- `storage_descriptor_skewed_info` - (Optional) Information about values that appear very frequently in a column (skewed values). (`default = []`)
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
- `enable_glue_security_configuration` - Enable glue security configuration usage (`default = False`)
- `glue_security_configuration_name` - Name of the security configuration. (`default = ""`)
- `glue_security_configuration_cloudwatch_encryption_mode` - (Optional) Encryption mode to use for CloudWatch data. Valid values: DISABLED, SSE-KMS. Default value: DISABLED. (`default = DISABLED`)
- `glue_security_configuration_cloudwatch_encryption_kms_key_arn` - (Optional) Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data. (`default = null`)
- `glue_security_configuration_job_bookmarks_encryption_job_bookmarks_encryption_mode` - (Optional) Encryption mode to use for job bookmarks data. Valid values: CSE-KMS, DISABLED. Default value: DISABLED. (`default = DISABLED`)
- `glue_security_configuration_job_bookmarks_encryption_kms_key_arn` - (Optional) Encryption mode to use for job bookmarks data. Valid values: CSE-KMS, DISABLED. Default value: DISABLED. (`default = null`)
- `glue_security_configuration_s3_encryption_s3_encryption_mode` - (Optional) Encryption mode to use for S3 data. Valid values: DISABLED, SSE-KMS, SSE-S3. Default value: DISABLED. (`default = DISABLED`)
- `glue_security_configuration_s3_encryption_kms_key_arn` - (Optional) Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data. (`default = null`)
- `enable_glue_workflow` - Enable glue workflow usage (`default = False`)
- `glue_workflow_name` - The name you assign to this workflow. (`default = ""`)
- `glue_workflow_description` - (Optional) Description of the workflow. (`default = null`)
- `glue_workflow_default_run_properties` - (Optional) A map of default run properties for this workflow. These properties are passed to all jobs associated to the workflow. (`default = null`)
- `enable_glue_job` - Enable glue job usage (`default = False`)
- `glue_job_name` - The name you assign to this job. It must be unique in your account. (`default = ""`)
- `glue_job_role_arn` - The ARN of the IAM role associated with this job. (`default = null`)
- `glue_job_command_script_location` - (Required) Specifies the S3 path to a script that executes a job. (`default = null`)
- `glue_job_command_name` - (Optional) The name of the job command. Defaults to glueetl. Use pythonshell for Python Shell Job Type, max_capacity needs to be set if pythonshell is chosen. (`default = null`)
- `glue_job_command_python_version` - description (`default = null`)
- `glue_job_description` - (Optional) Description of the job. (`default = null`)
- `glue_job_connections` - (Optional) The list of connections used for this job. (`default = null`)
- `glue_job_default_arguments` - (Optional) The map of default arguments for this job. You can specify arguments here that your own job-execution script consumes, as well as arguments that AWS Glue itself consumes. For information about how to specify and consume your own Job arguments, see the Calling AWS Glue APIs in Python topic in the developer guide. For information about the key-value pairs that AWS Glue consumes to set up your job, see the Special Parameters Used by AWS Glue topic in the developer guide. (`default = {'--job-language': 'python'}`)
- `glue_job_execution_property` - (Optional) Execution property of the job. (`default = []`)
- `glue_job_glue_version` - (Optional) The version of glue to use, for example '1.0'. For information about available versions, see the AWS Glue Release Notes. (`default = null`)
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
- `glue_trigger_actions_arguments` - (Optional) Arguments to be passed to the job. You can specify arguments here that your own job-execution script consumes, as well as arguments that AWS Glue itself consumes. (`default = null`)
- `glue_trigger_actions_crawler_name` - (Optional) The name of the crawler to be executed. Conflicts with job_name. (`default = null`)
- `glue_trigger_actions_job_name` - (Optional) The name of a job to be executed. Conflicts with crawler_name. (`default = null`)
- `glue_trigger_actions_timeout` - (Optional) The job run timeout in minutes. It overrides the timeout value of the job. (`default = null`)
- `glue_trigger_timeouts` - Set timeouts for glue trigger (`default = []`)
- `glue_trigger_predicate` - (Optional) A predicate to specify when the new trigger should fire. Required when trigger type is CONDITIONAL (`default = []`)

## Module Output Variables
----------------------
- `glue_catalog_database_id` - ID for glue catalog database
- `glue_catalog_database_name` - Name for glue catalog database
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


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
