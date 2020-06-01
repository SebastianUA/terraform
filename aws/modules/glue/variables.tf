#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "tags" {
    description = "A list of tag blocks. Each element should have keys named key, value, etc."
    type        = map(string)
    default     = {}
}

#---------------------------------------------------
# AWS Glue catalog database
#---------------------------------------------------
variable "enable_glue_catalog_database" {
  description   = "Enable glue catalog database usage"
  default       = false
}

variable "glue_catalog_database_name" {
  description   = "The name of the database."
  default       = ""
}

variable "glue_catalog_database_description" {
  description   = "(Optional) Description of the database."
  default       = null
}

variable "glue_catalog_database_catalog_id" {
  description   = "(Optional) ID of the Glue Catalog to create the database in. If omitted, this defaults to the AWS Account ID."
  default       = null
}

variable "glue_catalog_database_location_uri" {
  description   = "(Optional) The location of the database (for example, an HDFS path)."
  default       = null
}

variable "glue_catalog_database_parameters" {
  description   = "(Optional) A list of key-value pairs that define parameters and properties of the database."
  default       = null
}

#---------------------------------------------------
# AWS Glue catalog table
#---------------------------------------------------
variable "enable_glue_catalog_table" {
  description   = "Enable glue catalog table usage"
  default       = false
}

variable "glue_catalog_table_name" {
  description   = "Name of the table. For Hive compatibility, this must be entirely lowercase."
  default       = ""
}

variable "glue_catalog_table_database_name" {
  description   = "Name of the metadata database where the table metadata resides. For Hive compatibility, this must be all lowercase."
  default       = ""
}

variable "glue_catalog_table_description" {
  description   = "(Optional) Description of the table."
  default       = null
}

variable "glue_catalog_table_catalog_id" {
  description   = "(Optional) ID of the Glue Catalog and database to create the table in. If omitted, this defaults to the AWS Account ID plus the database name."
  default       = null
}

variable "glue_catalog_table_owner" {
  description   = "(Optional) Owner of the table."
  default       = null
}

variable "glue_catalog_table_retention" {
  description   = "(Optional) Retention time for this table."
  default       = null
}

variable "glue_catalog_table_partition_keys" {
  description   = "(Optional) A list of columns by which the table is partitioned. Only primitive types are supported as partition keys."
  default       = []
}

variable "glue_catalog_table_view_original_text" {
  description   = "(Optional) If the table is a view, the original text of the view; otherwise null."
  default       = null
}

variable "glue_catalog_table_view_expanded_text" {
  description   = "(Optional) If the table is a view, the expanded text of the view; otherwise null."
  default       = null
}

variable "glue_catalog_table_table_type" {
  description   = "(Optional) The type of this table (EXTERNAL_TABLE, VIRTUAL_VIEW, etc.)."
  default       = null
}

variable "glue_catalog_table_parameters" {
  description   = "(Optional) Properties associated with this table, as a list of key-value pairs."
  default       = null
}

variable "storage_descriptor_location" {
  description = "(Optional) The physical location of the table. By default this takes the form of the warehouse location, followed by the database location in the warehouse, followed by the table name."
  default     = null
}

variable "storage_descriptor_input_format" {
  description = "(Optional) The input format: SequenceFileInputFormat (binary), or TextInputFormat, or a custom format."
  default     = null
}

variable "storage_descriptor_output_format" {
  description = "(Optional) The output format: SequenceFileOutputFormat (binary), or IgnoreKeyTextOutputFormat, or a custom format."
  default     = []
}

variable "storage_descriptor_compressed" {
  description = "(Optional) True if the data in the table is compressed, or False if not."
  default     = null
}

variable "storage_descriptor_number_of_buckets" {
  description = "(Optional) Must be specified if the table contains any dimension columns."
  default     = null
}

variable "storage_descriptor_bucket_columns" {
  description = "(Optional) A list of reducer grouping columns, clustering columns, and bucketing columns in the table."
  default     = null
}

variable "storage_descriptor_parameters" {
  description = "(Optional) User-supplied properties in key-value form."
  default     = null
}

variable "storage_descriptor_stored_as_sub_directories" {
  description = "(Optional) True if the table data is stored in subdirectories, or False if not."
  default     = null
}

variable "storage_descriptor_columns" {
  description = "(Optional) A list of the Columns in the table."
  default     = []
}

variable "storage_descriptor_ser_de_info" {
  description = "(Optional) Serialization/deserialization (SerDe) information."
  default     = []
}

variable "storage_descriptor_sort_columns" {
  description = "(Optional) A list of Order objects specifying the sort order of each bucket in the table."
  default     = []
}

variable "storage_descriptor_skewed_info" {
  description = "(Optional) Information about values that appear very frequently in a column (skewed values)."
  default     = []
}

#---------------------------------------------------
# AWS Glue classifier
#---------------------------------------------------
variable "enable_glue_classifier" {
  description   = "Enable glue classifier usage"
  default       = false
}

variable "glue_classifier_name" {
  description   = "The name of the classifier."
  default       = ""
}

variable "glue_classifier_csv_classifier" {
  description   = "(Optional) A classifier for Csv content. "
  default       = []
}

variable "glue_classifier_grok_classifier" {
  description   = "(Optional) A classifier for grok content. "
  default       = []
}

variable "glue_classifier_json_classifier" {
  description   = "(Optional) A classifier for json content. "
  default       = []
}

variable "glue_classifier_xml_classifier" {
  description   = "(Optional) A classifier for xml content. "
  default       = []
}

#---------------------------------------------------
# AWS Glue connection
#---------------------------------------------------
variable "enable_glue_connection" {
  description   = "Enable glue connection usage"
  default       = false
}

variable "glue_connection_name" {
  description   = "The name of the connection."
  default       = ""
}

variable "glue_connection_connection_properties" {
  description   = "(Required) A map of key-value pairs used as parameters for this connection."
  default       = {}
}

variable "glue_connection_description" {
  description   = "(Optional) Description of the connection."
  default       = null
}

variable "glue_connection_catalog_id" {
  description   = "(Optional) The ID of the Data Catalog in which to create the connection. If none is supplied, the AWS account ID is used by default."
  default       = null
}

variable "glue_connection_connection_type" {
  description   = "(Optional) The type of the connection. Supported are: JDBC, MONGODB. Defaults to JDBC."
  default       = "JDBC"
}

variable "glue_connection_match_criteria" {
  description   = "(Optional) A list of criteria that can be used in selecting this connection."
  default       = null
}

variable "glue_connection_physical_connection_requirements" {
  description   = "(Optional) A map of physical connection requirements, such as VPC and SecurityGroup. "
  default       = []
}

#---------------------------------------------------
# AWS Glue crawler
#---------------------------------------------------
variable "enable_glue_crawler" {
  description   = "Enable glue crawler usage"
  default       = false
}

variable "glue_crawler_name" {
  description   = "Name of the crawler."
  default       = ""
}

variable "glue_crawler_database_name" {
  description   = "Glue database where results are written."
  default       = ""
}

variable "glue_crawler_role" {
  description   = "(Required) The IAM role friendly name (including path without leading slash), or ARN of an IAM role, used by the crawler to access other resources."
  default       = ""
}

variable "glue_crawler_description" {
  description   = "(Optional) Description of the crawler."
  default       = null
}

variable "glue_crawler_classifiers" {
  description   = "(Optional) List of custom classifiers. By default, all AWS classifiers are included in a crawl, but these custom classifiers always override the default classifiers for a given classification."
  default       = null
}

variable "glue_crawler_configuration" {
  description   = "(Optional) JSON string of configuration information."
  default       = null
}

variable "glue_crawler_schedule" {
  description   = "(Optional) A cron expression used to specify the schedule. For more information, see Time-Based Schedules for Jobs and Crawlers. For example, to run something every day at 12:15 UTC, you would specify: cron(15 12 * * ? *)."
  default       = null
}

variable "glue_crawler_security_configuration" {
  description   = "(Optional) The name of Security Configuration to be used by the crawler"
  default       = null
}

variable "glue_crawler_table_prefix" {
  description   = "(Optional) The table prefix used for catalog tables that are created."
  default       = null
}

variable "glue_crawler_dynamodb_target" {
  description   = "(Optional) List of nested DynamoDB target arguments."
  default       = []
}

variable "glue_crawler_jdbc_target" {
  description   = "(Optional) List of nested JBDC target arguments. "
  default       = []
}

variable "glue_crawler_s3_target" {
  description   = "(Optional) List nested Amazon S3 target arguments."
  default       = []
}

variable "glue_crawler_catalog_target" {
  description   = "(Optional) List nested Amazon catalog target arguments."
  default       = []
}

variable "glue_crawler_schema_change_policy" {
  description   = "(Optional) Policy for the crawler's update and deletion behavior."
  default       = []
}

#---------------------------------------------------
# AWS glue security configuration
#---------------------------------------------------
variable "enable_glue_security_configuration" {
  description   = "Enable glue security configuration usage"
  default       = false
}

variable "glue_security_configuration_name" {
  description   = "Name of the security configuration."
  default       = ""
}

variable "glue_security_configuration_cloudwatch_encryption_mode" {
  description   = "(Optional) Encryption mode to use for CloudWatch data. Valid values: DISABLED, SSE-KMS. Default value: DISABLED."
  default       = "DISABLED"
}

variable "glue_security_configuration_cloudwatch_encryption_kms_key_arn" {
  description   = "(Optional) Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data."
  default       = null
}

variable "glue_security_configuration_job_bookmarks_encryption_job_bookmarks_encryption_mode" {
  description   = "(Optional) Encryption mode to use for job bookmarks data. Valid values: CSE-KMS, DISABLED. Default value: DISABLED."
  default       = "DISABLED"
}

variable "glue_security_configuration_job_bookmarks_encryption_kms_key_arn" {
  description   = "(Optional) Encryption mode to use for job bookmarks data. Valid values: CSE-KMS, DISABLED. Default value: DISABLED."
  default       = null
}

variable "glue_security_configuration_s3_encryption_s3_encryption_mode" {
  description   = "(Optional) Encryption mode to use for S3 data. Valid values: DISABLED, SSE-KMS, SSE-S3. Default value: DISABLED."
  default       = "DISABLED"
}

variable "glue_security_configuration_s3_encryption_kms_key_arn" {
  description = "(Optional) Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data."
  default     = null
}

#---------------------------------------------------
# AWS Glue workflow
#---------------------------------------------------
variable "enable_glue_workflow" {
  description = "Enable glue workflow usage"
  default     = false
}

variable "glue_workflow_name" {
  description = "The name you assign to this workflow."
  default     = ""
}

variable "glue_workflow_description" {
  description = "(Optional) Description of the workflow."
  default     = null
}

variable "glue_workflow_default_run_properties" {
  description = "(Optional) A map of default run properties for this workflow. These properties are passed to all jobs associated to the workflow."
  default     = null
}

#---------------------------------------------------
# AWS Glue job
#---------------------------------------------------
variable "enable_glue_job" {
  description = "Enable glue job usage"
  default     = false
}

variable "glue_job_name" {
  description = "The name you assign to this job. It must be unique in your account."
  default     = ""
}

variable "glue_job_role_arn" {
  description = "The ARN of the IAM role associated with this job."
  default     = null
}

variable "glue_job_command_script_location" {
  description = "(Required) Specifies the S3 path to a script that executes a job."
  default     = null
}

variable "glue_job_command_name" {
  description = "(Optional) The name of the job command. Defaults to glueetl. Use pythonshell for Python Shell Job Type, max_capacity needs to be set if pythonshell is chosen."
  default     = null
}

variable "glue_job_command_python_version" {
  description = "description"
  default     = null
}

variable "glue_job_description" {
  description = "(Optional) Description of the job."
  default     = null
}

variable "glue_job_connections" {
  description = "(Optional) The list of connections used for this job."
  default     = null
}

variable "glue_job_default_arguments" {
  description = "(Optional) The map of default arguments for this job. You can specify arguments here that your own job-execution script consumes, as well as arguments that AWS Glue itself consumes. For information about how to specify and consume your own Job arguments, see the Calling AWS Glue APIs in Python topic in the developer guide. For information about the key-value pairs that AWS Glue consumes to set up your job, see the Special Parameters Used by AWS Glue topic in the developer guide."
  default     = {
    "--job-language" = "python"
  }
}

variable "glue_job_execution_property" {
  description = "(Optional) Execution property of the job."
  default     = []
}

variable "glue_job_glue_version" {
  description = "(Optional) The version of glue to use, for example '1.0'. For information about available versions, see the AWS Glue Release Notes."
  default     = null
}

variable "glue_job_max_capacity" {
  description = "(Optional) The maximum number of AWS Glue data processing units (DPUs) that can be allocated when this job runs. Required when pythonshell is set, accept either 0.0625 or 1.0."
  default     = null
}

variable "glue_job_max_retries" {
  description = "(Optional) The maximum number of times to retry this job if it fails."
  default     = null
}

variable "glue_job_notification_property" {
  description = "(Optional) Notification property of the job."
  default     = []
}

variable "glue_job_timeout" {
  description = "(Optional) The job timeout in minutes. The default is 2880 minutes (48 hours)."
  default     = 2880
}

variable "glue_job_security_configuration" {
  description = "(Optional) The name of the Security Configuration to be associated with the job."
  default     = null
}

variable "glue_job_worker_type" {
  description = "(Optional) The type of predefined worker that is allocated when a job runs. Accepts a value of Standard, G.1X, or G.2X."
  default     = null
}

variable "glue_job_number_of_workers" {
  description = "(Optional) The number of workers of a defined workerType that are allocated when a job runs."
  default     = null
}

#---------------------------------------------------
# AWS Glue trigger
#---------------------------------------------------
variable "enable_glue_trigger" {
  description = "Enable glue trigger usage"
  default     = false
}

variable "glue_trigger_name" {
  description = "The name of the trigger."
  default     = ""
}

variable "glue_trigger_type" {
  description = "(Required) The type of trigger. Valid values are CONDITIONAL, ON_DEMAND, and SCHEDULED."
  default     = "ON_DEMAND"
}

variable "glue_trigger_description" {
  description = "(Optional) A description of the new trigger."
  default     = null
}

variable "glue_trigger_enabled" {
  description = "(Optional) Start the trigger. Defaults to true. Not valid to disable for ON_DEMAND type."
  default     = null
}

variable "glue_trigger_schedule" {
  description = "(Optional) A cron expression used to specify the schedule. Time-Based Schedules for Jobs and Crawlers"
  default     = null
}

variable "glue_trigger_workflow_name" {
  description = "(Optional) A workflow to which the trigger should be associated to. Every workflow graph (DAG) needs a starting trigger (ON_DEMAND or SCHEDULED type) and can contain multiple additional CONDITIONAL triggers."
  default     = null
}

variable "glue_trigger_actions_arguments" {
  description = "(Optional) Arguments to be passed to the job. You can specify arguments here that your own job-execution script consumes, as well as arguments that AWS Glue itself consumes."
  default     = null
}

variable "glue_trigger_actions_crawler_name" {
  description = "(Optional) The name of the crawler to be executed. Conflicts with job_name."
  default     = null
}

variable "glue_trigger_actions_job_name" {
  description = "(Optional) The name of a job to be executed. Conflicts with crawler_name."
  default     = null
}

variable "glue_trigger_actions_timeout" {
  description = "(Optional) The job run timeout in minutes. It overrides the timeout value of the job."
  default     = null
}

variable "glue_trigger_timeouts" {
  description = "Set timeouts for glue trigger"
  default     = []
}

variable "glue_trigger_predicate" {
  description = "(Optional) A predicate to specify when the new trigger should fire. Required when trigger type is CONDITIONAL"
  default     = []
}
