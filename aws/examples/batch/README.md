# Work with BATCH via terraform

A terraform module for making BATCH.


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

module "batch" {
  source      = "../../modules/batch"
  name        = "TEST"
  environment = "dev"

  # Batch job definition
  enable_batch_job_definition = true
  batch_job_definition_name   = ""
  batch_job_definition_type   = "container"

  batch_job_definition_container_properties = file("./additional_files/job_definition-container_properties.json")

  # Batch compute environment
  enable_batch_compute_environment            = false
  batch_compute_environment_name              = "batch-comp-env"
  batch_compute_environment_service_role      = "role_here"
  batch_compute_environment_type              = "MANAGED"
  batch_compute_environment_compute_resources = []

  # Batch job queue
  enable_batch_job_queue               = false
  batch_job_queue_name                 = ""
  batch_job_queue_state                = "ENABLED"
  batch_job_queue_priority             = 1
  batch_job_queue_compute_environments = []

}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_batch_job_definition` - Enable batch job definition usage (`default = False`)
- `batch_job_definition_name` - Specifies the name of the job definition. (`default = ""`)
- `batch_job_definition_type` - (Required) The type of job definition. Must be container (`default = container`)
- `batch_job_definition_container_properties` - (Optional) A valid container properties provided as a single valid JSON document. This parameter is required if the type parameter is container. (`default = null`)
- `batch_job_definition_parameters` - (Optional) Specifies the parameter substitution placeholders to set in the job definition. (`default = null`)
- `batch_job_definition_retry_strategy` - (Optional) Specifies the retry strategy to use for failed jobs that are submitted with this job definition. Maximum number of retry_strategy is 1 (`default = []`)
- `batch_job_definition_timeout` - (Optional) Specifies the timeout for jobs so that if a job runs longer, AWS Batch terminates the job. Maximum number of timeout is 1. (`default = []`)
- `enable_batch_compute_environment` - Enable batch compute environment usage (`default = False`)
- `batch_compute_environment_name` - (Optional, Forces new resource) The name for your compute environment. Up to 128 letters (uppercase and lowercase), numbers, and underscores are allowed. If omitted, Terraform will assign a random, unique name. (`default = null`)
- `batch_compute_environment_name_prefix` - (Optional, Forces new resource) Creates a unique compute environment name beginning with the specified prefix. Conflicts with compute_environment_name. (`default = null`)
- `batch_compute_environment_service_role` - (Required) The full Amazon Resource Name (ARN) of the IAM role that allows AWS Batch to make calls to other AWS services on your behalf. (`default = null`)
- `batch_compute_environment_type` - (Required) The type of the compute environment. Valid items are MANAGED or UNMANAGED. (`default = MANAGED`)
- `batch_compute_environment_state` - (Optional) The state of the compute environment. If the state is ENABLED, then the compute environment accepts jobs from a queue and can scale out automatically based on queues. Valid items are ENABLED or DISABLED. Defaults to ENABLED. (`default = ENABLED`)
- `batch_compute_environment_compute_resources` - (Optional) Details of the compute resources managed by the compute environment. This parameter is required for managed compute environments. (`default = []`)
- `enable_batch_job_queue` - Enable batch job queue usage (`default = False`)
- `batch_job_queue_name` - Specifies the name of the job queue. (`default = ""`)
- `batch_job_queue_state` - (Required) The state of the job queue. Must be one of: ENABLED or DISABLED (`default = ENABLED`)
- `batch_job_queue_priority` - (Required) The priority of the job queue. Job queues with a higher priority are evaluated first when associated with the same compute environment. (`default = 1`)
- `batch_job_queue_compute_environments` - (Required) Specifies the set of compute environments mapped to a job queue and their order. The position of the compute environments in the list will dictate the order. You can associate up to 3 compute environments with a job queue. (`default = []`)

## Module Output Variables
----------------------
- `batch_job_definition_id` - Batch job definition ID
- `batch_job_definition_arn` - The Amazon Resource Name of the job definition.
- `batch_job_definition_revision` - The revision of the job definition.
- `batch_compute_environment_id` - Batch compute environment ID
- `batch_compute_environment_arn` - The Amazon Resource Name (ARN) of the compute environment.
- `batch_compute_environment_ecs_cluster_arn` - The Amazon Resource Name (ARN) of the underlying Amazon ECS cluster used by the compute environment.
- `batch_compute_environment_status` - The current status of the compute environment (for example, CREATING or VALID).
- `batch_compute_environment_status_reason` - A short, human-readable string to provide additional details about the current status of the compute environment.
- `batch_job_queue_id` - Batch job queue ID
- `batch_job_queue_arn` - The Amazon Resource Name of the job queue.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
