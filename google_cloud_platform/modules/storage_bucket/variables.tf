variable "name" {
    description = "(Required) The name of the bucket."
    default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "location" {
    description = "(Optional, Default: 'US')"
    default     = "US"
}

variable "force_destroy" {
    description = "(Optional, Default: false) When deleting a bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run."
    default     = false
}

variable "project" {
    description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "storage_class" {
    description = "(Optional) The Storage Class of the new bucket. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE."
    default     = "MULTI_REGIONAL"
}

variable "lifecycle_rule_action_type" {
    description = "The type of the action of this Lifecycle Rule. Supported values include: Delete and SetStorageClass."
    default     = "SetStorageClass"
}

variable "lifecycle_rule_action_storage_class" {
    description = "(Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE."
    default     = "MULTI_REGIONAL"
}

variable "lifecycle_rule_condition_age" {
    description = "(Optional) Minimum age of an object in days to satisfy this condition."
    default     = "30"
}

variable "lifecycle_rule_condition_created_before" {
    description = "(Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition."
    default     = ""
}

variable "lifecycle_rule_condition_is_live" {
    description = "(Optional) Defaults to false to match archived objects. If true, this condition matches live objects. Unversioned buckets have only live objects."
    default     = "false"
}

variable "lifecycle_rule_condition_matches_storage_class" {
    description = "(Optional) Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY."
    default     = ["MULTI_REGIONAL"]
}               

variable "lifecycle_rule_condition_num_newer_versions" {
    description = "(Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition."
    default     = "2"
}

variable "versioning_enabled" {
    description = "(Optional) While set to true, versioning is fully enabled for this bucket."
    default     = "false"
}

variable "website_main_page_suffix" {
    description = "(Optional) Behaves as the bucket's directory index where missing objects are treated as potential directories."
    default     = "index.html"
}

variable "website_not_found_page" {
    description = "(Optional) The custom object to return when a requested resource is not found."
    default     = "404.html"
}

variable "cors_origin" {
    description = "The list of Origins eligible to receive CORS response headers. Note: '*' is permitted in the list of origins, and means 'any Origin'."
    default     = ["*"]
}

variable "cors_method" {
    description = "(Optional) The list of HTTP methods on which to include CORS response headers, (GET, OPTIONS, POST, etc) Note: '*' is permitted in the list of methods, and means 'any method'."
    default     = ["*"]
}

variable "cors_response_header" {
    description = "(Optional) The list of HTTP headers other than the simple response headers to give permission for the user-agent to share across domains."
    default     = ["*"]
}

variable "cors_max_age_seconds" {
    description = "(Optional) The value, in seconds, to return in the Access-Control-Max-Age header used in preflight responses."
    default     = "84300"
}

variable "logging_log_bucket" {
    description = "(Required) The bucket that will receive log objects."
    default     = ""
}

variable "logging_log_object_prefix" {
    description = "(Optional, Computed) The object prefix for log objects. If it's not provided, by default GCS sets this to the log_bucket's name."
    default     = ""
}

variable "enable_storage_bucket_acl" {
    description = "Enable storage bucket acl"
    default     = "false"
}

variable "bucket" {
    description = "(Required) The name of the bucket it applies to."
    default     = ""
}

variable "predefined_acl" {
    description = " (Optional) The canned GCS ACL to apply. Must be set if role_entity is not."
    default     = ""
}

variable "role_entity" {
    description = "(Optional) List of role/entity pairs in the form ROLE:entity. See GCS Bucket ACL documentation for more details. Must be set if predefined_acl is not."
    default     = []
}

variable "default_acl" {
    description = "(Optional) Configure this ACL to be the default ACL."
    default     = ""
}

variable "enable_storage_bucket_iam_binding" {
    description = "Enable storage bucket iam binding"
    default     = "false"
}

variable "role" {
    description = "The role that should be applied. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}."
    default     = "roles/storage.objectViewer"
}

variable "members" {
    description = " (Required) Identities that will be granted the privilege in role."
    default     = []
}

variable "enable_storage_bucket_iam_member" {
    description = "Enable storage bucket iam member" 
    default     = "false"
}

variable "enable_storage_bucket_iam_policy" {
    description = "Enable storage bucket iam policy"
    default     = "false"
}

variable "enable_storage_default_object_acl" {
    description = "Enable storage default object acl" 
    default     = "false"
}

variable "enable_storage_object_acl" {
    description = "Enable storage object acl"
    default     = "false"
}

variable "object" {
    description = "(Required) The name of the object it applies to."
    default     = ""
}

variable "enable_storage_bucket_object" {
    description = "Enable storage bucket object"
    default     = "false"
}

variable "source_path" {
    description = "(Optional) A path to the data you want to upload. Must be defined if content is not."
    default     = ""
}

variable "cache_control" {
    description = "(Optional) Cache-Control directive to specify caching behavior of object data. If omitted and object is accessible to all anonymous users, the default will be public, max-age=3600"
    default     = ""
}

variable "content_disposition" {
    description = "(Optional) Content-Disposition of the object data."
    default     = ""
}

variable "content_encoding" {
    description = "(Optional) Content-Encoding of the object data."
    default     = ""
}

variable "content_language" {
    description = "(Optional) Content-Language of the object data."
    default     = ""
}

variable "content_type" {
    description = "(Optional) Content-Type of the object data. Defaults to 'application/octet-stream' or 'text/plain; charset=utf-8'."
    default     = ""
}

variable "enable_storage_notification" {
    description = "Enable storage notification"
    default     = "false"
}

variable "payload_format" {
    description = "(Required) The desired content of the Payload. One of 'JSON_API_V1' or 'NONE'."
    default     = "NONE"
}

variable "topic" {
    description = "(Required) The Cloud PubSub topic to which this subscription publishes. Expects either the topic name, assumed to belong to the default GCP provider project, or the project-level name, i.e. projects/my-gcp-project/topics/my-topic or my-topic."
    default     = ""
}

variable "event_types" {
    description = "(Optional) List of event type filters for this notification config. If not specified, Cloud Storage will send notifications for all event types. The valid types are: 'OBJECT_FINALIZE', 'OBJECT_METADATA_UPDATE', 'OBJECT_DELETE', 'OBJECT_ARCHIVE'"
    default     = ["OBJECT_FINALIZE", "OBJECT_METADATA_UPDATE"]
}

variable "object_name_prefix" {
    description = "(Optional) Specifies a prefix path filter for this notification config. Cloud Storage will only send notifications for objects in this bucket whose names begin with the specified prefix."
    default     = ""
}

variable "enable_storage_bucket" {
    description = "Enable storage bucket usage"
    default     = "true"
}
