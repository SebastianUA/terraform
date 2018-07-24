# Work with Google Cloud  Platform (storage bucket) via terraform

A terraform module for making google storage bucket.
 
## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "google" {
    credentials = "${file("/Users/captain/.config/gcloud/creds/terraform_creds.json")}"
    project     = "terraform-2018"
    region      = "us-east1"
}   
module "storage_bucket" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = true
    lifecycle_rule_action_type          = "Delete"
    versioning_enabled                  = false
}

module "storage_bucket_acl" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_bucket_acl           = false
    bucket                              = "test-sb-stage"
    role_entity                         = ["OWNER:solo.metal@bigmir.net"]
    
}

module "storage_bucket_iam_binding" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"
    
    enable_storage_bucket               = false
    enable_storage_bucket_iam_binding   = false
}

module "storage_bucket_iam_member" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_bucket_iam_member    = false
    members                             = ["solo.metal@bigmir.net"]
} 

module "storage_bucket_iam_policy" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"
    
    enable_storage_bucket               = false
    enable_storage_bucket_iam_policy    = false
} 

module "storage_default_object_acl" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_default_object_acl   = false
    role_entity                         = ["OWNER:solo.metal@bigmir.net"]
} 

module "storage_object_acl" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_object_acl           = false
    role_entity                         = ["OWNER:solo.metal@bigmir.net"]
}    

module "storage_bucket_object" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_bucket_object        = true
    bucket                              = "${element(module.storage_bucket.google_storage_bucket_name, 0)}"
    source_path                         = "/Users/captain/Downloads/line-bot-google-cloud-functions-example-master.zip"
} 

module "storage_notification" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_notification         = false

    topic                               = "my-topic"
    bucket                              = "test-sb-stage"
} 
```

Module Input Variables
----------------------
- `name` - "(Required) The name of the bucket." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `orchestration` - "Type of orchestration" (`    default     = "Terraform"`)
- `location` - "(Optional, Default: 'US')" (`    default     = "US"`)
- `force_destroy` - "(Optional, Default: false) When deleting a bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run." (`    default     = false`)
- `project` - "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `storage_class` - "(Optional) The Storage Class of the new bucket. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE." (`    default     = "MULTI_REGIONAL"`)
- `lifecycle_rule_action_type` - "The type of the action of this Lifecycle Rule. Supported values include: Delete and SetStorageClass." (`    default     = "SetStorageClass"`)
- `lifecycle_rule_action_storage_class` - "(Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE." (`    default     = "MULTI_REGIONAL"`)
- `lifecycle_rule_condition_age` - "(Optional) Minimum age of an object in days to satisfy this condition." (`    default     = "30"`)
- `lifecycle_rule_condition_created_before` - "(Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition." (`    default     = ""`)
- `lifecycle_rule_condition_is_live` - "(Optional) Defaults to false to match archived objects. If true, this condition matches live objects. Unversioned buckets have only live objects." (`    default     = "false"`)
- `lifecycle_rule_condition_matches_storage_class` - "(Optional) Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY." (`    default     = ["MULTI_REGIONAL"]`)
- `lifecycle_rule_condition_num_newer_versions` - "(Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition." (`    default     = "2"`)
- `versioning_enabled` - "(Optional) While set to true, versioning is fully enabled for this bucket." (`    default     = "false"`)
- `website_main_page_suffix` - "(Optional) Behaves as the bucket's directory index where missing objects are treated as potential directories." (`    default     = "index.html"`)
- `website_not_found_page` - "(Optional) The custom object to return when a requested resource is not found." (`    default     = "404.html"`)
- `cors_origin` - "The list of Origins eligible to receive CORS response headers. Note: '*' is permitted in the list of origins, and means 'any Origin'." (`    default     = ["*"]`)
- `cors_method` - "(Optional) The list of HTTP methods on which to include CORS response headers, (GET, OPTIONS, POST, etc) Note: '*' is permitted in the list of methods, and means 'any method'." (`    default     = ["*"]`)
- `cors_response_header` - "(Optional) The list of HTTP headers other than the simple response headers to give permission for the user-agent to share across domains." (`    default     = ["*"]`)
- `cors_max_age_seconds` - "(Optional) The value, in seconds, to return in the Access-Control-Max-Age header used in preflight responses." (`    default     = "84300"`)
- `logging_log_bucket` - "(Required) The bucket that will receive log objects." (`    default     = ""`)
- `logging_log_object_prefix` - "(Optional, Computed) The object prefix for log objects. If it's not provided, by default GCS sets this to the log_bucket's name." (`    default     = ""`)
- `enable_storage_bucket_acl` - "Enable storage bucket acl" (`    default     = "false"`)
- `bucket` - "(Required) The name of the bucket it applies to." (`    default     = ""`)
- `predefined_acl` - " (Optional) The canned GCS ACL to apply. Must be set if role_entity is not." (`    default     = ""`)
- `role_entity` - "(Optional) List of role/entity pairs in the form ROLE:entity. See GCS Bucket ACL documentation for more details. Must be set if predefined_acl is not." (`    default     = []`)
- `default_acl` - "(Optional) Configure this ACL to be the default ACL." (`    default     = ""`)
- `enable_storage_bucket_iam_binding` - "Enable storage bucket iam binding" (`    default     = "false"`)
- `role` - "The role that should be applied. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}." (`    default     = "roles/storage.objectViewer"`)
- `members` - " (Required) Identities that will be granted the privilege in role." (`    default     = []`)
- `enable_storage_bucket_iam_member` - "Enable storage bucket iam member"  (`    default     = "false"`)
- `enable_storage_bucket_iam_policy` - "Enable storage bucket iam policy" (`    default     = "false"`)
- `enable_storage_default_object_acl` - "Enable storage default object acl"  (`    default     = "false"`)
- `enable_storage_object_acl` - "Enable storage object acl" (`    default     = "false"`)
- `object` - "(Required) The name of the object it applies to." (`    default     = ""`)
- `enable_storage_bucket_object` - "Enable storage bucket object" (`    default     = "false"`)
- `source_path` - "(Optional) A path to the data you want to upload. Must be defined if content is not." (`    default     = ""`)
- `cache_control` - "(Optional) Cache-Control directive to specify caching behavior of object data. If omitted and object is accessible to all anonymous users, the default will be public, max-age (`    default     = ""`)
- `content_disposition` - "(Optional) Content-Disposition of the object data." (`    default     = ""`)
- `content_encoding` - "(Optional) Content-Encoding of the object data." (`    default     = ""`)
- `content_language` - "(Optional) Content-Language of the object data." (`    default     = ""`)
- `content_type` - "(Optional) Content-Type of the object data. Defaults to 'application/octet-stream' or 'text/plain; charset (`    default     = ""`)
- `enable_storage_notification` - "Enable storage notification" (`    default     = "false"`)
- `payload_format` - "(Required) The desired content of the Payload. One of 'JSON_API_V1' or 'NONE'." (`    default     = "NONE"`)
- `topic` - "(Required) The Cloud PubSub topic to which this subscription publishes. Expects either the topic name, assumed to belong to the default GCP provider project, or the project-level name, i.e. projects/my-gcp-project/topics/my-topic or my-topic." (`    default     = ""`)
- `event_types` - "(Optional) List of event type filters for this notification config. If not specified, Cloud Storage will send notifications for all event types. The valid types are: 'OBJECT_FINALIZE', 'OBJECT_METADATA_UPDATE', 'OBJECT_DELETE', 'OBJECT_ARCHIVE'" (`    default     = ["OBJECT_FINALIZE", "OBJECT_METADATA_UPDATE"]`)
- `object_name_prefix` - "(Optional) Specifies a prefix path filter for this notification config. Cloud Storage will only send notifications for objects in this bucket whose names begin with the specified prefix." (`    default     = ""`)
- `enable_storage_bucket` - Enable storage bucket usage (`default = "true"`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
