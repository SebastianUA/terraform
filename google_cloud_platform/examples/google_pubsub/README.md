# Work with Google Cloud  Platform (google pubsub) via terraform

A terraform module for making google pubsub.
 
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
module "google_pubsub" {
    source                              = "../../modules/google_pubsub"
    name                                = "TEST"

    #
    enable_pubsub_topic                 = true
    #
    #enable_pubsub_topic_iam_policy      = true
    #topic                               = "test-ps-topic-stage"
    #
    #enable_pubsub_topic_iam_binding     = true
    #topic                               = "test-ps-topic-stage"
    #members                              = ["OWNER:solo.metal@bigmir.net"]
    #
    #enable_pubsub_topic_iam_member       = true
    #members                              = ["OWNER:solo.metal@bigmir.net"]   
    #
    #enable_pubsub_subscription_default   = true  
    #
    #enable_pubsub_subscription_iam_policy  = true
    #
    #enable_pubsub_subscription_iam_binding = true
    #members                                = ["OWNER:solo.metal@bigmir.net"]
    #
    #enable_pubsub_subscription_iam_member  = true
    #members                                = ["OWNER:solo.metal@bigmir.net"]
}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `orchestration` - "Type of orchestration" (`    default     = "Terraform"`)
- `project` - "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `enable_pubsub_topic` - "Enable pubsub topic" (`    default     = "true"`)
- `enable_pubsub_topic_iam_policy` - "Enable pubsub topic iam policy" (`    default     = "false"`)
- `role` - "(Required) The role that should be applied. Only one google_pubsub_topic_iam_binding can be used per role. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}." (`    default     = "roles/editor"`)
- `members` - "(Required) Identities that will be granted the privilege in role." (`    default     = []`)
- `topic` - "(Required) The topic name or id to bind to attach IAM policy to." (`    default     = ""`)
- `enable_pubsub_topic_iam_binding` - "Enable pubsub topic iam binding" (`    default     = "false"`)
- `enable_pubsub_topic_iam_member` - "Enable pubsub topic iam member" (`    default     = "false"`)
- `enable_pubsub_subscription_default` - "Enable pubsub subscription for default" (`    default     = "true"`)
- `ack_deadline_seconds` - "(Optional) The maximum number of seconds a subscriber has to acknowledge a received message, otherwise the message is redelivered. Changing this forces a new resource to be created." (`    default     = "20"`)
- `push_config_push_endpoint` - "(Required) The URL of the endpoint to which messages should be pushed. Changing this forces a new resource to be created." (`    default     = ""`)
- `enable_pubsub_subscription_iam_policy` - "Enable pubsub subscription iam policy"  (`    default     = "false"`)
- `enable_pubsub_subscription_iam_binding` - "Enable pubsub subscription iam binding"  (`    default     = "false"`)
- `subscription` - "(Required) The subscription name or id to bind to attach IAM policy to." (`    default     = ""`)
- `enable_pubsub_subscription_iam_member` - "Enable pubsub subscription iam member" (`    default     = "false"`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
