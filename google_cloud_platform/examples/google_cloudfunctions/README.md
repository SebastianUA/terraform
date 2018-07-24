# Work with Google Cloud  Platform (google cloudfunctions) via terraform

A terraform module for making google cloudfunctions.
 
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

module "storage_bucket_object" {
    source                              = "../../modules/storage_bucket"
    name                                = "TEST"

    enable_storage_bucket               = false
    enable_storage_bucket_object        = true
    bucket                              = "${element(module.storage_bucket.google_storage_bucket_name, 0)}"
    source_path                         = "/Users/captain/Downloads/line-bot-google-cloud-functions-example-master.zip"
}
 
module "google_cloudfunctions" {
    source                              = "../../modules/google_cloudfunctions"
    name                                = "TEST"

    # Use http
    trigger_http                        = true
    source_archive_bucket               = "${element(module.storage_bucket.google_storage_bucket_name, 0)}"
    source_archive_object               = "${element(module.storage_bucket_object.google_storage_bucket_object_name, 0)}"
    entry_point                         = "MyFunction"
}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `orchestration` - "Type of orchestration" (`    default     = "Terraform"`)
- `description` - "(Optional) Description of the function." (`    default     = ""`)
- `available_memory_mb` - "(Optional) Memory (in MB), available to the function. Default value is 256. Allowed values are: 128MB, 256MB, 512MB, 1024MB, and 2048MB." (`    default     = "256"`)
- `source_archive_bucket` - "(Required) The GCS bucket containing the zip archive which contains the function." (`    default     = ""`)
- `source_archive_object` - "(Required) The source archive object (file) in archive bucket." (`    default     = ""`)
- `timeout` - "(Optional) Timeout (in seconds) for the function. Default value is 60 seconds. Cannot be more than 540 seconds." (`    default     = "60"`)
- `entry_point` - "(Optional) Name of a JavaScript function that will be executed when the Google Cloud Function is triggered." (`    default     = ""`)
- `trigger_http` - "(Optional) Boolean variable. Any HTTP request (of a supported type) to the endpoint will trigger function execution. Supported HTTP request types are: POST, PUT, GET, DELETE, and OPTIONS. Endpoint is returned as https_trigger_url. Cannot be used with trigger_bucket and trigger_topic." (`    default     = "true"`)
- `trigger_bucket` - "(Optional) Google Cloud Storage bucket name. Every change in files in this bucket will trigger function execution. Cannot be used with trigger_http and trigger_topic." (`    default     = ""`)
- `trigger_topic` - "(Optional) Name of Pub/Sub topic. Every message published in this topic will trigger function execution with message contents passed as input data. Cannot be used with trigger_http and trigger_bucket." (`    default     = ""`)
- `retry_on_failure` - "(Optional) Whether the function should be retried on failure. This only applies to bucket and topic triggers, not HTTPS triggers." (`    default     = ""`)
- `project` - "Project of the function. If it is not provided, the provider project is used." (`    default     = ""`)
- `region` - "Region of function. Currently can be only 'us-central1'. If it is not provided, the provider region is used." (`    default     = "us-central1"`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
