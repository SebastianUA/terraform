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
  description = "Add additional tags"
  default     = {}
}

#---------------------------------------------------
# AWS elasticsearch domain
#---------------------------------------------------
variable "enable_elasticsearch_domain" {
  description = "Enable elasticsearch domain usage"
  default     = false
}

variable "elasticsearch_domain_name" {
  description = "Name of the domain."
  default     = ""
}

variable "elasticsearch_domain_advanced_security_options" {
  description = "(Optional) Options for fine-grained access control."
  default     = {}
}

variable "elasticsearch_domain_ebs_options" {
  description = "(Optional) EBS related options, may be required based on chosen instance size."
  default     = {}
}

variable "elasticsearch_domain_encrypt_at_rest" {
  description = "(Optional) Encrypt at rest options. Only available for certain instance types."
  default     = {}
}

variable "elasticsearch_domain_node_to_node_encryption" {
  description = "(Optional) Node-to-node encryption options. "
  default     = {}
}

variable "elasticsearch_domain_cluster_config" {
  description = "(Optional) Cluster configuration of the domain"
  default     = []
}

variable "elasticsearch_domain_vpc_options" {
  description = "(Optional) VPC related options. Adding or removing this configuration forces a new resource (documentation)."
  default     = {}
}

variable "elasticsearch_domain_snapshot_options" {
  description = "(Optional) Snapshot related options"
  default     = {}
}

variable "elasticsearch_domain_log_publishing_options" {
  description = "(Optional) Options for publishing slow and application logs to CloudWatch Logs. This block can be declared multiple times, for each log_type, within the same resource."
  default     = {}
}

variable "elasticsearch_domain_cognito_options" {
  description = "(Optional) Options for authenticating Kibana with Cognito."
  default     = {}
}

variable "elasticsearch_domain_domain_endpoint_options" {
  description = "(Optional) Domain endpoint HTTP(S) related options."
  default     = {}
}

variable "elasticsearch_domain_timeouts" {
  description = "Set timeouts for elasticsearch domain"
  default     = {}
}

variable "elasticsearch_domain_elasticsearch_version" {
  description = "(Optional) The version of Elasticsearch to deploy. Defaults to 1.5"
  default     = null
}

variable "elasticsearch_domain_advanced_options" {
  description = "(Optional) Key-value string pairs to specify advanced configuration options. Note that the values for these configuration options must be strings (wrapped in quotes) or they may be wrong and cause a perpetual diff, causing Terraform to want to recreate your Elasticsearch domain on every apply."
  default     = null
}

variable "elasticsearch_domain_access_policies" {
  description = "(Optional) IAM policy document specifying the access policies for the domain"
  default     = null
}

#---------------------------------------------------
# AWS elasticsearch domain policy
#---------------------------------------------------
variable "enable_elasticsearch_domain_policy" {
  description = "Enable elasticsearch domain policy usage"
  default     = false
}

variable "elasticsearch_domain_policy_domain_name" {
  description = "Name of the domain."
  default     = ""
}

variable "elasticsearch_domain_policy_access_policies" {
  description = "(Optional) IAM policy document specifying the access policies for the domain"
  default     = null
}
