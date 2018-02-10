#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-SNS"
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

variable "account-id" {
    description = "Account ID"
    default     = ""
}

variable "delivery_policy" {
    description = "Delivery policy"
    default     = ""
}

variable "sns_protocol" {
    description = "The protocol to use. The possible values for this are: sqs, sms, lambda, application. (http or https are partially supported, see below) (email is option but unsupported, see below)."
    default     = "sqs"
}

variable "sns_endpoint" {
    description = "The endpoint to send data to, the contents will vary with the protocol. (see below for more information)"
    default     = ""
}

variable "confirmation_timeout_in_minutes" {
    description = "Set timeout in minutes. Integer indicating number of minutes to wait in retying mode for fetching subscription arn before marking it as failure. Only applicable for http and https protocols (default is 1 minute)."
    default     = "1"
}

variable "endpoint_auto_confirms" {
    description = "Enable endpoint auto confirms. Boolean indicating whether the end point is capable of auto confirming subscription e.g., PagerDuty (default is false)"
    default     = "false"
}

variable "raw_message_delivery" {
    description = "Set raw message delivery.Boolean indicating whether or not to enable raw message delivery (the original message is directly passed, not wrapped in JSON with the original message in the message property) (default is false)."
    default     = "false"
}

#Delivery policies
variable "minDelayTarget" {
    description = "Set minDelayTarget. Max=20"
    default     = "19"
}

variable "maxDelayTarget" {
    description = "Set maxDelayTarget. Max=20"
    default     = "19"
}

variable "numRetries" {
    description = ""
    default     = "3"
}

variable "numMaxDelayRetries" { 
    description = ""
    default     = "0"
}

variable "numNoDelayRetries" {
    description = ""
    default     = "0"
}

variable "numMinDelayRetries" {
    description = ""
    default     = "0"
}

variable "backoffFunction" {
    description = "Set backoffFunction. Can set: arithmetic, exponential or linear."
    default     = "linear"
}

variable "disableSubscriptionOverrides" {
    description = ""
    default     = "false"
}
