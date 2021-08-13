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
  description = "Enable glue catalog database usage"
  default     = false
}

variable "glue_catalog_database_name" {
  description = "The name of the database."
  default     = ""
}

variable "glue_catalog_database_description" {
  description = "(Optional) Description of the database."
  default     = null
}

variable "glue_catalog_database_catalog_id" {
  description = "(Optional) ID of the Glue Catalog to create the database in. If omitted, this defaults to the AWS Account ID."
  default     = null
}

variable "glue_catalog_database_location_uri" {
  description = "(Optional) The location of the database (for example, an HDFS path)."
  default     = null
}

variable "glue_catalog_database_parameters" {
  description = "(Optional) A list of key-value pairs that define parameters and properties of the database."
  default     = null
}

#---------------------------------------------------
# AWS Glue catalog table
#---------------------------------------------------
variable "enable_glue_catalog_table" {
  description = "Enable glue catalog table usage"
  default     = false
}

variable "glue_catalog_table_name" {
  description = "Name of the table. For Hive compatibility, this must be entirely lowercase."
  default     = ""
}

variable "glue_catalog_table_database_name" {
  description = "Name of the metadata database where the table metadata resides. For Hive compatibility, this must be all lowercase."
  default     = ""
}

variable "glue_catalog_table_description" {
  description = "(Optional) Description of the table."
  default     = null
}

variable "glue_catalog_table_catalog_id" {
  description = "(Optional) ID of the Glue Catalog and database to create the table in. If omitted, this defaults to the AWS Account ID plus the database name."
  default     = null
}

variable "glue_catalog_table_owner" {
  description = "(Optional) Owner of the table."
  default     = null
}

variable "glue_catalog_table_retention" {
  description = "(Optional) Retention time for this table."
  default     = null
}

variable "glue_catalog_table_partition_keys" {
  description = "(Optional) A list of columns by which the table is partitioned. Only primitive types are supported as partition keys."
  default     = []
}

variable "glue_catalog_table_view_original_text" {
  description = "(Optional) If the table is a view, the original text of the view; otherwise null."
  default     = null
}

variable "glue_catalog_table_view_expanded_text" {
  description = "(Optional) If the table is a view, the expanded text of the view; otherwise null."
  default     = null
}

variable "glue_catalog_table_table_type" {
  description = "(Optional) The type of this table (EXTERNAL_TABLE, VIRTUAL_VIEW, etc.)."
  default     = null
}

variable "glue_catalog_table_parameters" {
  description = "(Optional) Properties associated with this table, as a list of key-value pairs."
  default     = null
}

variable "glue_catalog_table_storage_descriptor" {
  description = "(Optional) A storage descriptor object containing information about the physical storage of this table. You can refer to the Glue Developer Guide for a full explanation of this object."
  default = {
    location                  = null
    input_format              = null
    output_format             = null
    compressed                = null
    number_of_buckets         = null
    bucket_columns            = null
    parameters                = null
    stored_as_sub_directories = null
  }
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
  description = "Enable glue classifier usage"
  default     = false
}

variable "glue_classifier_name" {
  description = "The name of the classifier."
  default     = ""
}

variable "glue_classifier_csv_classifier" {
  description = "(Optional) A classifier for Csv content. "
  default     = []
}

variable "glue_classifier_grok_classifier" {
  description = "(Optional) A classifier for grok content. "
  default     = []
}

variable "glue_classifier_json_classifier" {
  description = "(Optional) A classifier for json content. "
  default     = []
}

variable "glue_classifier_xml_classifier" {
  description = "(Optional) A classifier for xml content. "
  default     = []
}

#---------------------------------------------------
# AWS Glue connection
#---------------------------------------------------
variable "enable_glue_connection" {
  description = "Enable glue connection usage"
  default     = false
}

variable "glue_connection_name" {
  description = "The name of the connection."
  default     = ""
}

variable "glue_connection_connection_properties" {
  description = "(Required) A map of key-value pairs used as parameters for this connection."
  default     = {}
}

variable "glue_connection_description" {
  description = "(Optional) Description of the connection."
  default     = null
}

variable "glue_connection_catalog_id" {
  description = "(Optional) The ID of the Data Catalog in which to create the connection. If none is supplied, the AWS account ID is used by default."
  default     = null
}

variable "glue_connection_connection_type" {
  description = "(Optional) The type of the connection. Supported are: JDBC, MONGODB. Defaults to JDBC."
  default     = "JDBC"
}

variable "glue_connection_match_criteria" {
  description = "(Optional) A list of criteria that can be used in selecting this connection."
  default     = null
}

variable "glue_connection_physical_connection_requirements" {
  description = "(Optional) A map of physical connection requirements, such as VPC and SecurityGroup. "
  default     = []
}

#---------------------------------------------------
# AWS Glue crawler
#---------------------------------------------------
variable "enable_glue_crawler" {
  description = "Enable glue crawler usage"
  default     = false
}

variable "glue_crawler_name" {
  description = "Name of the crawler."
  default     = ""
}

variable "glue_crawler_database_name" {
  description = "Glue database where results are written."
  default     = ""
}

variable "glue_crawler_role" {
  description = "(Required) The IAM role friendly name (including path without leading slash), or ARN of an IAM role, used by the crawler to access other resources."
  default     = ""
}

variable "glue_crawler_description" {
  description = "(Optional) Description of the crawler."
  default     = null
}

variable "glue_crawler_classifiers" {
  description = "(Optional) List of custom classifiers. By default, all AWS classifiers are included in a crawl, but these custom classifiers always override the default classifiers for a given classification."
  default     = null
}

variable "glue_crawler_configuration" {
  description = "(Optional) JSON string of configuration information."
  default     = null
}

variable "glue_crawler_schedule" {
  description = "(Optional) A cron expression used to specify the schedule. For more information, see Time-Based Schedules for Jobs and Crawlers. For example, to run something every day at 12:15 UTC, you would specify: cron(15 12 * * ? *)."
  default     = null
}

variable "glue_crawler_security_configuration" {
  description = "(Optional) The name of Security Configuration to be used by the crawler"
  default     = null
}

variable "glue_crawler_table_prefix" {
  description = "(Optional) The table prefix used for catalog tables that are created."
  default     = null
}

variable "glue_crawler_dynamodb_target" {
  description = "(Optional) List of nested DynamoDB target arguments."
  default     = []
}

variable "glue_crawler_jdbc_target" {
  description = "(Optional) List of nested JBDC target arguments. "
  default     = []
}

variable "glue_crawler_s3_target" {
  description = "(Optional) List nested Amazon S3 target arguments."
  default     = []
}

variable "glue_crawler_catalog_target" {
  description = "(Optional) List nested Amazon catalog target arguments."
  default     = []
}

variable "glue_crawler_schema_change_policy" {
  description = "(Optional) Policy for the crawler's update and deletion behavior."
  default     = []
}

variable "glue_crawler_recrawl_policy" {
  description = "Optional) A policy that specifies whether to crawl the entire dataset again, or to crawl only folders that were added since the last crawler run."
  default     = []
}

variable "glue_crawler_mongodb_target" {
  description = "(Optional) List nested MongoDB target arguments."
  default     = []
}

variable "glue_crawler_lineage_configuration" {
  description = "(Optional) Specifies data lineage configuration settings for the crawler."
  default     = []
}

#---------------------------------------------------
# AWS glue security configuration
#---------------------------------------------------
variable "enable_glue_security_configuration" {
  description = "Enable glue security configuration usage"
  default     = false
}

variable "glue_security_configuration_name" {
  description = "Name of the security configuration."
  default     = ""
}

variable "glue_security_configuration_cloudwatch_encryption" {
  description = "(Required) A cloudwatch_encryption block as described below, which contains encryption configuration for CloudWatch."
  default     = []
}

variable "glue_security_configuration_job_bookmarks_encryption" {
  description = "(Required) A job_bookmarks_encryption block as described below, which contains encryption configuration for job bookmarks."
  default     = []
}

variable "glue_security_configuration_s3_encryption" {
  description = "(Required) A s3_encryption block as described below, which contains encryption configuration for S3 data."
  default     = []
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

variable "glue_job_command" {
  description = "(Required) The command of the job."
  default     = []
}

variable "glue_job_description" {
  description = "(Optional) Description of the job."
  default     = null
}

variable "glue_job_connections" {
  description = "(Optional) The list of connections used for this job."
  default     = null
}

variable "glue_job_additional_connections" {
  description = "(Optional) The list of connections used for the job."
  default     = []
}

variable "glue_job_default_arguments" {
  description = "(Optional) The map of default arguments for this job. You can specify arguments here that your own job-execution script consumes, as well as arguments that AWS Glue itself consumes. For information about how to specify and consume your own Job arguments, see the Calling AWS Glue APIs in Python topic in the developer guide. For information about the key-value pairs that AWS Glue consumes to set up your job, see the Special Parameters Used by AWS Glue topic in the developer guide."
  default = {
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

variable "glue_trigger_actions" {
  description = "(Required) List of actions initiated by this trigger when it fires. "
  default     = []
}

variable "glue_trigger_timeouts" {
  description = "Set timeouts for glue trigger"
  default     = {}
}

variable "glue_trigger_predicate" {
  description = "(Optional) A predicate to specify when the new trigger should fire. Required when trigger type is CONDITIONAL"
  default     = {}
}

#---------------------------------------------------
# AWS Glue data catalog encryption settings
#---------------------------------------------------
variable "enable_glue_data_catalog_encryption_settings" {
  description = "Enable glue data catalog encryption settings usage"
  default     = false
}

variable "glue_data_catalog_encryption_settings_connection_password_encryption" {
  description = "(Required) When connection password protection is enabled, the Data Catalog uses a customer-provided key to encrypt the password as part of CreateConnection or UpdateConnection and store it in the ENCRYPTED_PASSWORD field in the connection properties. You can enable catalog encryption or only password encryption. see Connection Password Encryption."
  default     = []
}

variable "glue_data_catalog_encryption_settings_encryption_at_rest" {
  description = "(Required) Specifies the encryption-at-rest configuration for the Data Catalog. see Encryption At Rest."
  default     = []
}

variable "glue_data_catalog_encryption_settings_catalog_id" {
  description = "(Optional) The ID of the Data Catalog to set the security configuration for. If none is provided, the AWS account ID is used by default."
  default     = null
}

#---------------------------------------------------
# AWS Glue dev endpoint
#---------------------------------------------------
variable "enable_glue_dev_endpoint" {
  description = "Enable glue dev endpoint usage"
  default     = false
}

variable "glue_dev_endpoint_name" {
  description = "The name of this endpoint. It must be unique in your account."
  default     = ""
}

variable "glue_dev_endpoint_role_arn" {
  description = "(Required) The IAM role for this endpoint."
  default     = null
}

variable "glue_dev_endpoint_arguments" {
  description = "(Optional) A map of arguments used to configure the endpoint."
  default     = null
}

variable "glue_dev_endpoint_extra_jars_s3_path" {
  description = "(Optional) Path to one or more Java Jars in an S3 bucket that should be loaded in this endpoint."
  default     = null
}

variable "glue_dev_endpoint_extra_python_libs_s3_path" {
  description = "(Optional) Path(s) to one or more Python libraries in an S3 bucket that should be loaded in this endpoint. Multiple values must be complete paths separated by a comma."
  default     = null
}

variable "glue_dev_endpoint_glue_version" {
  description = "(Optional) - Specifies the versions of Python and Apache Spark to use. Defaults to AWS Glue version 0.9."
  default     = null
}

variable "glue_dev_endpoint_number_of_nodes" {
  description = "(Optional) The number of AWS Glue Data Processing Units (DPUs) to allocate to this endpoint. Conflicts with worker_type"
  default     = null
}

variable "glue_dev_endpoint_number_of_workers" {
  description = "(Optional) The number of workers of a defined worker type that are allocated to this endpoint. This field is available only when you choose worker type G.1X or G.2X."
  default     = null
}

variable "glue_dev_endpoint_public_key" {
  description = "(Optional) The public key to be used by this endpoint for authentication."
  default     = null
}

variable "glue_dev_endpoint_public_keys" {
  description = "(Optional) A list of public keys to be used by this endpoint for authentication."
  default     = null
}

variable "glue_dev_endpoint_security_configuration" {
  description = "(Optional) The name of the Security Configuration structure to be used with this endpoint."
  default     = null
}

variable "glue_dev_endpoint_security_group_ids" {
  description = "(Optional) Security group IDs for the security groups to be used by this endpoint."
  default     = null
}

variable "glue_dev_endpoint_subnet_id" {
  description = "(Optional) The subnet ID for the new endpoint to use."
  default     = null
}

variable "glue_dev_endpoint_worker_type" {
  description = "(Optional) The type of predefined worker that is allocated to this endpoint. Accepts a value of Standard, G.1X, or G.2X."
  default     = null
}

#---------------------------------------------------
# AWS Glue ml transform
#---------------------------------------------------
variable "enable_glue_ml_transform" {
  description = "Enable glue ml transform usage"
  default     = false
}

variable "glue_ml_transform_name" {
  description = "The name you assign to this ML Transform. It must be unique in your account."
  default     = ""
}

variable "glue_ml_transform_role_arn" {
  description = "(Required) The ARN of the IAM role associated with this ML Transform."
  default     = null
}

variable "glue_ml_transform_input_record_tables" {
  description = "(Required) A list of AWS Glue table definitions used by the transform. see Input Record Tables."
  default     = []
}

variable "glue_ml_transform_parameters" {
  description = "(Required) The algorithmic parameters that are specific to the transform type used. Conditionally dependent on the transform type. see Parameters."
  default     = []
}

variable "glue_ml_transform_description" {
  description = "(Optional) Description of the ML Transform."
  default     = null
}

variable "glue_ml_transform_glue_version" {
  description = "(Optional) The version of glue to use, for example '1.0'. For information about available versions, see the AWS Glue Release Notes."
  default     = null
}

variable "glue_ml_transform_max_capacity" {
  description = "(Optional) The number of AWS Glue data processing units (DPUs) that are allocated to task runs for this transform. You can allocate from 2 to 100 DPUs; the default is 10. max_capacity is a mutually exclusive option with number_of_workers and worker_type."
  default     = null
}

variable "glue_ml_transform_max_retries" {
  description = "(Optional) The maximum number of times to retry this ML Transform if it fails."
  default     = null
}

variable "glue_ml_transform_timeout" {
  description = "(Optional) The ML Transform timeout in minutes. The default is 2880 minutes (48 hours)."
  default     = null
}

variable "glue_ml_transform_worker_type" {
  description = "(Optional) The type of predefined worker that is allocated when an ML Transform runs. Accepts a value of Standard, G.1X, or G.2X. Required with number_of_workers."
  default     = null
}

variable "glue_ml_transform_number_of_workers" {
  description = "(Optional) The number of workers of a defined worker_type that are allocated when an ML Transform runs. Required with worker_type"
  default     = null
}

#---------------------------------------------------
# AWS Glue partition
#---------------------------------------------------
variable "enable_glue_partition" {
  description = "Enable glue partition usage"
  default     = false
}

variable "glue_partition_database_name" {
  description = "Name of the metadata database where the table metadata resides. For Hive compatibility, this must be all lowercase."
  default     = ""
}

variable "glue_partition_table_name" {
  description = "Table name"
  default     = ""
}

variable "glue_partition_partition_values" {
  description = "(Required) The values that define the partition."
  default     = []
}

variable "glue_partition_catalog_id" {
  description = "(Optional) ID of the Glue Catalog and database to create the table in. If omitted, this defaults to the AWS Account ID plus the database name."
  default     = null
}

variable "glue_partition_parameters" {
  description = "(Optional) Properties associated with this table, as a list of key-value pairs."
  default     = null
}

variable "glue_partition_storage_descriptor_columns" {
  description = "(Optional) A list of the Columns in the table."
  default     = []
}

variable "glue_partition_storage_descriptor_ser_de_info" {
  description = "(Optional) Serialization/deserialization (SerDe) information."
  default     = []
}

variable "glue_partition_storage_descriptor_sort_columns" {
  description = "(Optional) A list of Order objects specifying the sort order of each bucket in the table."
  default     = []
}

variable "glue_partition_storage_descriptor_skewed_info" {
  description = "(Optional) Information about values that appear very frequently in a column (skewed values)."
  default     = []
}

variable "glue_partition_storage_descriptor" {
  description = "(Optional) A storage descriptor object containing information about the physical storage of this table. You can refer to the Glue Developer Guide for a full explanation of this object."
  default = {
    location                  = null
    input_format              = null
    output_format             = null
    compressed                = null
    number_of_buckets         = null
    bucket_columns            = null
    parameters                = null
    stored_as_sub_directories = null
  }
}

#---------------------------------------------------
# AWS Glue registry
#---------------------------------------------------
variable "enable_glue_registry" {
  description = "Enable glue registry usage"
  default     = false
}

variable "glue_registry_name" {
  description = "The Name of the registry."
  default     = ""
}

variable "glue_registry_description" {
  description = "(Optional) A description of the registry."
  default     = null
}

#---------------------------------------------------
# AWS Glue resource policy
#---------------------------------------------------
variable "enable_glue_resource_policy" {
  description = "Enable glue resource policy usage"
  default     = false
}

variable "glue_resource_policy" {
  description = "(Required) The policy to be applied to the aws glue data catalog."
  default     = null
}

#---------------------------------------------------
# AWS Glue schema
#---------------------------------------------------
variable "enable_glue_schema" {
  description = "Enable glue schema usage"
  default     = false
}

variable "glue_schema_name" {
  description = "The Name of the schema."
  default     = ""
}

variable "glue_schema_registry_arn" {
  description = "The ARN of the Glue Registry to create the schema in."
  default     = ""
}

variable "glue_schema_data_format" {
  description = "(Required) The data format of the schema definition. Currently only AVRO is supported."
  default     = null
}

variable "glue_schema_compatibility" {
  description = "(Required) The compatibility mode of the schema. Values values are: NONE, DISABLED, BACKWARD, BACKWARD_ALL, FORWARD, FORWARD_ALL, FULL, and FULL_ALL."
  default     = null
}

variable "glue_schema_schema_definition" {
  description = "(Required) The schema definition using the data_format setting for schema_name."
  default     = null
}

variable "glue_schema_description" {
  description = "(Optional) A description of the schema."
  default     = null
}

#---------------------------------------------------
# AWS Glue user defined function
#---------------------------------------------------
variable "enable_glue_user_defined_function" {
  description = "Enable glue user defined function usage"
  default     = false
}

variable "glue_user_defined_function_name" {
  description = "The name of the function."
  default     = ""
}

variable "glue_user_defined_function_database_name" {
  description = "The name of the Database to create the Function."
  default     = ""
}

variable "glue_user_defined_function_class_name" {
  description = "(Required) The Java class that contains the function code."
  default     = null
}

variable "glue_user_defined_function_owner_name" {
  description = "(Required) The owner of the function."
  default     = null
}

variable "glue_user_defined_function_owner_type" {
  description = "(Required) The owner type. can be one of USER, ROLE, and GROUP."
  default     = null
}

variable "glue_user_defined_function_catalog_id" {
  description = "(Optional) ID of the Glue Catalog to create the function in. If omitted, this defaults to the AWS Account ID."
  default     = null
}

variable "glue_user_defined_function_resource_uris" {
  description = "(Optional) The configuration block for Resource URIs. See resource uris below for more details."
  default     = []
}
