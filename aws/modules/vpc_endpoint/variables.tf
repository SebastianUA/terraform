#---------------------------------------------------------------
# Global or/and default variables
#---------------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
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
# AWS VPC endpoint
#---------------------------------------------------
variable "enable_vpc_endpoint" {
  description = "Enable VPC endpoint usage"
  default     = false
}

variable "vpc_endpoint_stack" {
  description = "Set list of endpoints settings"
  default     = []
}

variable "vpc_endpoint_name" {
  description = "Set name for VPC endpoint"
  default     = ""
}

// variable "vpc_endpoint_vpc_id" {
//   description = "Set vpc_id for endpoint"
//   default     = ""
// }

// variable "vpc_endpoint_service_name" {
//   description = "(Required) The service name. For AWS services the service name is usually in the form com.amazonaws.<region>.<service> (the SageMaker Notebook service is an exception to this rule, the service name is in the form aws.sagemaker.<region>.notebook)."
//   default     = null
// }

// variable "vpc_endpoint_auto_accept" {
//   description = "(Optional) Accept the VPC endpoint (the VPC endpoint and service need to be in the same AWS account)."
//   default     = null
// }

// variable "vpc_endpoint_policy" {
//   description = "(Optional) A policy to attach to the endpoint that controls access to the service. Defaults to full access. All Gateway and some Interface endpoints support policies - see the relevant AWS documentation for more details. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
//   default     = null
// }

// variable "vpc_endpoint_private_dns_enabled" {
//   description = "(Optional; AWS services and AWS Marketplace partner services only) Whether or not to associate a private hosted zone with the specified VPC. Applicable for endpoints of type Interface. Defaults to false."
//   default     = false
// }

// variable "vpc_endpoint_route_table_ids" {
//   description = "(Optional) One or more route table IDs. Applicable for endpoints of type Gateway."
//   default     = null
// }

// variable "vpc_endpoint_subnet_ids" {
//   description = "(Optional) The ID of one or more subnets in which to create a network interface for the endpoint. Applicable for endpoints of type Interface."
//   default     = []
// }

// variable "vpc_endpoint_security_group_ids" {
//   description = "(Optional) The ID of one or more security groups to associate with the network interface. Required for endpoints of type Interface."
//   default     = null
// }

// variable "vpc_endpoint_vpc_endpoint_type" {
//   description = "(Optional) The VPC endpoint type, Gateway or Interface. Defaults to Gateway."
//   default     = "Gateway"
// }

variable "vpc_endpoint_timeouts" {
  description = "Set timeouts used for creating a VPC endpoint"
  default     = {}
}

#---------------------------------------------------
# AWS VPC endpoint subnet association
#---------------------------------------------------
variable "enable_vpc_endpoint_subnet_association" {
  description = "Enable VPC endpoint subnet association usage"
  default     = false
}

variable "vpc_endpoint_subnet_association_subnet_id" {
  description = "The ID of the subnet to be associated with the VPC endpoint."
  default     = ""
}

variable "vpc_endpoint_subnet_association_vpc_endpoint_id" {
  description = "The ID of the VPC endpoint with which the subnet will be associated."
  default     = null
}

variable "vpc_endpoint_subnet_association_timeouts" {
  description = "Set timeouts used for creating the association"
  default     = {}
}

#---------------------------------------------------
# AWS VPC endpoint route table association
#---------------------------------------------------
variable "enable_vpc_endpoint_route_table_association" {
  description = "Enable vpc endpoint route table association usage"
  default     = false
}

variable "vpc_endpoint_route_table_association_route_table_id" {
  description = "Identifier of the EC2 Route Table to be associated with the VPC Endpoint."
  default     = ""
}

variable "vpc_endpoint_route_table_association_vpc_endpoint_id" {
  description = "Identifier of the VPC Endpoint with which the EC2 Route Table will be associated."
  default     = null
}

#---------------------------------------------------
# AWS VPC endpoint service
#---------------------------------------------------
variable "enable_vpc_endpoint_service" {
  description = "Enable vpc endpoint service usage"
  default     = false
}

variable "vpc_endpoint_service_stack" {
  description = "Set list of endpoint services"
  default     = []
}

variable "vpc_endpoint_service_filter" {
  description = "Set service filter"
  default     = []
}

#---------------------------------------------------
# AWS VPC endpoint service allowed principal
#---------------------------------------------------
variable "enable_vpc_endpoint_service_allowed_principal" {
  description = "Enable vpc endpoint service allowed principal usage"
  default     = false
}

variable "vpc_endpoint_service_allowed_principal_principal_arn" {
  description = "(Required) The ARN of the principal to allow permissions."
  default     = ""
}

variable "vpc_endpoint_service_allowed_principal_vpc_endpoint_service_id" {
  description = "The ID of the VPC endpoint service to allow permission."
  default     = null
}

#---------------------------------------------------
# AWS VPC endpoint connection notification
#---------------------------------------------------
variable "enable_vpc_endpoint_connection_notification" {
  description = "Enable vpc endpoint connection notification usage"
  default     = false
}

variable "vpc_endpoint_connection_notification_connection_notification_arn" {
  description = "(Required) The ARN of the SNS topic for the notifications."
  default     = ""
}

variable "vpc_endpoint_connection_notification_connection_events" {
  description = "(Required) One or more endpoint events for which to receive notifications."
  default     = ["Accept", "Reject"]
}

variable "vpc_endpoint_connection_notification_vpc_endpoint_service_id" {
  description = "(Optional) The ID of the VPC Endpoint Service to receive notifications for."
  default     = ""
}

variable "vpc_endpoint_connection_notification_vpc_endpoint_id" {
  description = "(Optional) The ID of the VPC Endpoint to receive notifications for."
  default     = ""
}