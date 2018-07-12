variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
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

variable "project" {
    description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "enable_pubsub_topic" {
    description = "Enable pubsub topic"
    default     = "true"
}

variable "enable_pubsub_topic_iam_policy" {
    description = "Enable pubsub topic iam policy"
    default     = "false"
}

variable "role" {
    description = "(Required) The role that should be applied. Only one google_pubsub_topic_iam_binding can be used per role. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}."
    default     = "roles/editor"
}

variable "members" {
    description = "(Required) Identities that will be granted the privilege in role."
    default     = []
}

variable "topic" {
    description = "(Required) The topic name or id to bind to attach IAM policy to."
    default     = ""
}

variable "enable_pubsub_topic_iam_binding" {
    description = "Enable pubsub topic iam binding"
    default     = "false"
}

variable "enable_pubsub_topic_iam_member" {
    description = "Enable pubsub topic iam member"
    default     = "false"
}

variable "enable_pubsub_subscription_default" {
    description = "Enable pubsub subscription for default"
    default     = "true"
}

variable "ack_deadline_seconds" {
    description = "(Optional) The maximum number of seconds a subscriber has to acknowledge a received message, otherwise the message is redelivered. Changing this forces a new resource to be created."
    default     = "20"
}

variable "push_config_push_endpoint" {
    description = "(Required) The URL of the endpoint to which messages should be pushed. Changing this forces a new resource to be created."
    default     = ""
}

variable "enable_pubsub_subscription_iam_policy" {
    description = "Enable pubsub subscription iam policy" 
    default     = "false"
}

variable "enable_pubsub_subscription_iam_binding" {
    description = "Enable pubsub subscription iam binding" 
    default     = "false"
}

variable "subscription" {
    description = "(Required) The subscription name or id to bind to attach IAM policy to."
    default     = ""
}

variable "enable_pubsub_subscription_iam_member" {
    description = "Enable pubsub subscription iam member"
    default     = "false"
}

