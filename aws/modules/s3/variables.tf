#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-S3"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}

#-----------------------------------------------------------
# S3 bucket
#-----------------------------------------------------------
variable "enable_s3_bucket" {
    description = "Enable to create S3 bucket by default"
    default     = "false"
}

variable "enable_s3_bucket_website" {
    description = "Enable to create S3 bucket with website"
    default     = false
}

variable "policy" {
    description = "(Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform"
    default     = ""
}

variable "bucket_prefix" {
    description = "Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket."
    default     = ""
}

variable "s3_acl" {
    description = "The canned ACL to apply. Defaults to 'private'."
    default     = "private"
}

variable "enable_versioning" {
    description = "A state of versioning"
    default     = false
}

variable "force_destroy" {
    description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
    default     = false
}

variable "website" {
    description = "List of website fields"
    type        = "list"
    default     = []
}

variable "routing_rules" {
    description = "Routing rules"
    type        = "list"
    default     = []
}

variable "cors_rule" {
    description = "Cors rules"
    type        = "list"
    default     = []
}

variable "logging" {
    description = "Add logging rules"
    type        = "list"
    default     = []
}

variable "enable_lifecycle_rule" {
    description = "Enable lifecycle rule"
    default     = false
}

variable "lifecycle_rule_prefix" {
    description = " Set prefix for lifecycle rule"
    default     = ""
}

variable "noncurrent_version_expiration_days" {
    description = "(Optional) Specifies when noncurrent object versions expire."
    default     = "90"
}

variable "noncurrent_version_transition_days" {
    description = "(Optional) Specifies when noncurrent object versions transitions"
    default     = "30"
}

variable "standard_transition_days" {
    description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier"
    default     = "30"
}

variable "glacier_transition_days" {
    description = "Number of days after which to move the data to the glacier storage tier"
    default     = "60"
}

variable "expiration_days" {
    description = "Number of days after which to expunge the objects"
    default     = "90"
}

variable "kms_master_key_id" {
    description = "Set KMS master ket ID"
    default     = ""
}
#-----------------------------------------------------------
# S3 bucket policy 
#-----------------------------------------------------------
variable "enable_s3_bucket_policy" {
    description = "Enable s3 bucket policy usage"
    default     = false
}

variable "bucket_name" {
    description = "(Required) The name of the bucket to which to apply the policy."
    default     = ""
}

#-----------------------------------------------------------
# S3 bucket object
#-----------------------------------------------------------
variable "enable_s3_bucket_object" {
    description = "Enable s3 bucket object" 
    default     = "false"
}

#variable "s3_bucket_object_key" {
#    description = "(Required) The name of the object once it is in the bucket."
#    default     = ""
#}

variable "s3_bucket_object_source" {
    description = "(Required unless content or content_base64 is set) The path to a file that will be read and uploaded as raw bytes for the object content."
    type        = "list"
    default     = []
}

#variable "s3_bucket_object_content_type" {
#    description = "(Optional) A standard MIME type describing the format of the object data, e.g. application/octet-stream. All Valid MIME Types are valid for this input."
#    default     = "application/zip"
#}

variable "mime_types" {
    default = {
        htm     = "text/html"
        html    = "text/html"
        css     = "text/css"
        txt     = "text/plain"
        js      = "application/javascript"
        map     = "application/javascript"
        json    = "application/json"
        zip     = "application/zip"
  }
}

variable "type_of_file" {
    description = ""
    default     = "zip"
}

variable "s3_bucket_object_server_side_encryption" {
    description = "(Optional) Specifies server-side encryption of the object in S3. Valid values are 'AES256' and 'aws:kms'."
    default     = "AES256"
}
#-----------------------------------------------------------
# S3 bucket notification 
#-----------------------------------------------------------
#
# SNS
#
variable "enable_s3_bucket_notification_sns" {
    description = "Enable s3 bucket notification by SNS topic"
    default     = false
}

variable "topic_arn" {
    description = "(Required) Specifies Amazon SNS topic ARN."
    default     = ""
}

variable "topic_events" {
    description = "(Required) Specifies event for which to send notifications."
    type        = "list"
    default     = ["s3:ObjectCreated:*"]
}

variable "topic_filter_suffix" {
    description = "(Optional) Specifies object key name prefix."
    default     = ".log"
}

variable "topic_filter_prefix" {
    description = "(Optional) Specifies object key name suffix."
    default     = ""
}

#
# SQS
#
variable "enable_s3_bucket_notification_sqs" {
    description = "Enable s3 bucket notification by SQS topic"
    default     = false
}

variable "queue_configuration" {
    description = "Configuration for queue"
    type        = "list"
    default     = [
    {
        queue_arn     = "some arn for queue"
        events        = ["s3:ObjectCreated:*"]
        filter_suffix = ".log"
    }
    ]
}

#
# Lambda Function
#
variable "enable_s3_bucket_notification_lambda_function" {
    description = "Enable s3 bucket notification by Lambda Function"
    default     = false
}

variable "lambda_function_configuration" {
    description = "Configuration for Lambda Function"
    type        = "list"
    default     = [
    {
        lambda_function_arn = "some arn for lambda"
        events              = ["s3:ObjectCreated:*"]
        filter_prefix       = "AWSLogs/"
        filter_suffix       = ".log"
    }
    ]
}
