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
# AWS Batch job definition
#---------------------------------------------------
variable "enable_batch_job_definition" {
  description = "Enable batch job definition usage"
  default     = false
}

variable "batch_job_definition_name" {
  description = "Specifies the name of the job definition."
  default     = ""
}

variable "batch_job_definition_type" {
  description = "(Required) The type of job definition. Must be container"
  default     = "container"
}

variable "batch_job_definition_container_properties" {
  description = "(Optional) A valid container properties provided as a single valid JSON document. This parameter is required if the type parameter is container."
  default     = null
}

variable "batch_job_definition_parameters" {
  description = "(Optional) Specifies the parameter substitution placeholders to set in the job definition."
  default     = null
}

variable "batch_job_definition_retry_strategy" {
  description = "(Optional) Specifies the retry strategy to use for failed jobs that are submitted with this job definition. Maximum number of retry_strategy is 1"
  default     = []
}

variable "batch_job_definition_timeout" {
  description = "(Optional) Specifies the timeout for jobs so that if a job runs longer, AWS Batch terminates the job. Maximum number of timeout is 1."
  default     = []
}

#---------------------------------------------------
# AWS Batch compute environment
#---------------------------------------------------
variable "enable_batch_compute_environment" {
  description = "Enable batch compute environment usage"
  default     = false
}

variable "batch_compute_environment_name" {
  description = "(Optional, Forces new resource) The name for your compute environment. Up to 128 letters (uppercase and lowercase), numbers, and underscores are allowed. If omitted, Terraform will assign a random, unique name."
  default     = null
}

variable "batch_compute_environment_name_prefix" {
  description = "(Optional, Forces new resource) Creates a unique compute environment name beginning with the specified prefix. Conflicts with compute_environment_name."
  default     = null
}

variable "batch_compute_environment_service_role" {
  description = "(Required) The full Amazon Resource Name (ARN) of the IAM role that allows AWS Batch to make calls to other AWS services on your behalf."
  default     = null
}

variable "batch_compute_environment_type" {
  description = "(Required) The type of the compute environment. Valid items are MANAGED or UNMANAGED."
  default     = "MANAGED"
}

variable "batch_compute_environment_state" {
  description = "(Optional) The state of the compute environment. If the state is ENABLED, then the compute environment accepts jobs from a queue and can scale out automatically based on queues. Valid items are ENABLED or DISABLED. Defaults to ENABLED."
  default     = "ENABLED"
}

variable "batch_compute_environment_compute_resources" {
  description = "(Optional) Details of the compute resources managed by the compute environment. This parameter is required for managed compute environments."
  default     = []
}

#---------------------------------------------------
# AWS Batch job queue
#---------------------------------------------------
variable "enable_batch_job_queue" {
  description = "Enable batch job queue usage"
  default     = false
}

variable "batch_job_queue_name" {
  description = "Specifies the name of the job queue."
  default     = ""
}

variable "batch_job_queue_state" {
  description = "(Required) The state of the job queue. Must be one of: ENABLED or DISABLED"
  default     = "ENABLED"
}

variable "batch_job_queue_priority" {
  description = "(Required) The priority of the job queue. Job queues with a higher priority are evaluated first when associated with the same compute environment."
  default     = 1
}

variable "batch_job_queue_compute_environments" {
  description = "(Required) Specifies the set of compute environments mapped to a job queue and their order. The position of the compute environments in the list will dictate the order. You can associate up to 3 compute environments with a job queue."
  default     = []
}
