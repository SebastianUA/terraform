# Work with VPC_ENDPOINT via terraform

A terraform module for making VPC_ENDPOINT.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#---------------------------------------------------------------
# VPC Endpoint
#---------------------------------------------------------------

variable "vpc_id" {
  default = "vpc-0ea8873ab2bf7900d"
}


module "vpc_endpoint" {
  source      = "../../modules/vpc_endpoint"
  name        = "endpoint"
  environment = "stage"

  # VPC endpoints
  enable_vpc_endpoint = true

  vpc_endpoint_stack = [
    {
      vpc_id = var.vpc_id

      name              = "s3-endpoint-for-emr"
      service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
      vpc_endpoint_type = "Gateway"
      auto_accept       = true

      policy              = null
      route_table_ids     = null
      subnet_ids          = null
      security_group_ids  = null
      private_dns_enabled = null
    },
    {
      vpc_id = var.vpc_id

      name                = "sqs-endpoint-for-emr"
      service_name        = "com.amazonaws.${data.aws_region.current.name}.sqs"
      vpc_endpoint_type   = "Interface"
      security_group_ids  = ["sg-04c894799d3d0d9dd", "sg-0cfb43249902af8f2"]
      auto_accept         = true
      private_dns_enabled = true
    },
    {
      vpc_id = var.vpc_id

      name                = "sns-endpoint-for-emr"
      service_name        = "com.amazonaws.${data.aws_region.current.name}.sns"
      vpc_endpoint_type   = "Interface"
      security_group_ids  = ["sg-04c894799d3d0d9dd", "sg-0cfb43249902af8f2"]
      auto_accept         = true
      private_dns_enabled = true
    },
    // {
    //       vpc_id = var.vpc_id

    //       name              = "dynamodb-endpoint-for-emr"
    //       service_name      = "com.amazonaws.${data.aws_region.current.name}.dynamodb"
    //       vpc_endpoint_type = "Gateway"
    //       auto_accept       = true

    //       policy              = null
    //       route_table_ids     = null
    //       subnet_ids          = null
    //       security_group_ids  = null
    //       private_dns_enabled = null
    //     },
  ]

  # VPC endpoint connection notification
  enable_vpc_endpoint_connection_notification                      = false
  vpc_endpoint_connection_notification_connection_notification_arn = "arn:aws:sns:us-east-1:${data.aws_caller_identity.current.id}:sns_topic"
  vpc_endpoint_connection_notification_connection_events           = ["Accept", "Reject"]


  # VPC endpoint route table association
  enable_vpc_endpoint_route_table_association         = false
  vpc_endpoint_route_table_association_route_table_id = "rtb-07472044c2935ac68"


  # VPC endpoint subnet association
  enable_vpc_endpoint_subnet_association = false


  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}


module "vpc_endpoint_service" {
  source      = "../../modules/vpc_endpoint"
  name        = "endpoint_service"
  environment = "stage"

  # VPC endpoint service
  enable_vpc_endpoint_service = false
  vpc_endpoint_service_stack = [
    {
      acceptance_required = false

      name                       = "test-end-svc"
      gateway_load_balancer_arns = null
      network_load_balancer_arns = null
      allowed_principals         = null
      private_dns_name           = null
    },
    {
      acceptance_required = true

      name                       = "test-end-svc2"
      gateway_load_balancer_arns = null
      network_load_balancer_arns = null
      allowed_principals         = null
      private_dns_name           = true
    }
  ]

  # VPC endpoint service allowed principal
  enable_vpc_endpoint_service_allowed_principal        = false
  vpc_endpoint_service_allowed_principal_principal_arn = data.aws_caller_identity.current.arn

  # VPC endpoint connection notification
  enable_vpc_endpoint_connection_notification                      = false
  vpc_endpoint_connection_notification_connection_notification_arn = "arn:aws:sns:us-east-1:${data.aws_caller_identity.current.id}:sns_topic"
  vpc_endpoint_connection_notification_connection_events           = ["Accept", "Reject"]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_vpc_endpoint` - Enable VPC endpoint usage (`default = False`)
- `vpc_endpoint_stack` - Set list of endpoints settings (`default = []`)
- `vpc_endpoint_name` - Set name for VPC endpoint (`default = ""`)
- `vpc_endpoint_timeouts` - Set timeouts used for creating a VPC endpoint (`default = {}`)
- `enable_vpc_endpoint_subnet_association` - Enable VPC endpoint subnet association usage (`default = False`)
- `vpc_endpoint_subnet_association_subnet_id` - The ID of the subnet to be associated with the VPC endpoint. (`default = ""`)
- `vpc_endpoint_subnet_association_vpc_endpoint_id` - The ID of the VPC endpoint with which the subnet will be associated. (`default = null`)
- `vpc_endpoint_subnet_association_timeouts` - Set timeouts used for creating the association (`default = {}`)
- `enable_vpc_endpoint_route_table_association` - Enable vpc endpoint route table association usage (`default = False`)
- `vpc_endpoint_route_table_association_route_table_id` - Identifier of the EC2 Route Table to be associated with the VPC Endpoint. (`default = ""`)
- `vpc_endpoint_route_table_association_vpc_endpoint_id` - Identifier of the VPC Endpoint with which the EC2 Route Table will be associated. (`default = null`)
- `enable_vpc_endpoint_service` - Enable vpc endpoint service usage (`default = False`)
- `vpc_endpoint_service_stack` - Set list of endpoint services (`default = []`)
- `vpc_endpoint_service_filter` - Set service filter (`default = []`)
- `enable_vpc_endpoint_service_allowed_principal` - Enable vpc endpoint service allowed principal usage (`default = False`)
- `vpc_endpoint_service_allowed_principal_principal_arn` - (Required) The ARN of the principal to allow permissions. (`default = ""`)
- `vpc_endpoint_service_allowed_principal_vpc_endpoint_service_id` - The ID of the VPC endpoint service to allow permission. (`default = null`)
- `enable_vpc_endpoint_connection_notification` - Enable vpc endpoint connection notification usage (`default = False`)
- `vpc_endpoint_connection_notification_connection_notification_arn` - (Required) The ARN of the SNS topic for the notifications. (`default = ""`)
- `vpc_endpoint_connection_notification_connection_events` - (Required) One or more endpoint events for which to receive notifications. (`default = ['Accept', 'Reject']`)
- `vpc_endpoint_connection_notification_vpc_endpoint_service_id` - (Optional) The ID of the VPC Endpoint Service to receive notifications for. (`default = ""`)
- `vpc_endpoint_connection_notification_vpc_endpoint_id` - (Optional) The ID of the VPC Endpoint to receive notifications for. (`default = ""`)

## Module Output Variables
----------------------
- `vpc_endpoint_service_id` - The ID of the VPC endpoint service.
- `vpc_endpoint_service_availability_zones` - The Availability Zones in which the service is available.
- `vpc_endpoint_service_base_endpoint_dns_names` - The DNS names for the service.
- `vpc_endpoint_service_manages_vpc_endpoints` - Whether or not the service manages its VPC endpoints - true or false.
- `vpc_endpoint_service_private_dns_name` - The private DNS name for the service.
- `vpc_endpoint_service_service_name` - The service name.
- `vpc_endpoint_service_service_type` - The service type, Gateway or Interface.
- `vpc_endpoint_service_state` - The state of the VPC endpoint service.
- `vpc_endpoint_service_allowed_principal_id` - The ID of the association.
- `vpc_endpoint_id` - The ID of the VPC endpoint.
- `vpc_endpoint_arn` - The Amazon Resource Name (ARN) of the VPC endpoint.
- `vpc_endpoint_cidr_blocks` - The list of CIDR blocks for the exposed AWS service. Applicable for endpoints of type Gateway.
- `vpc_endpoint_dns_entry` - The DNS entries for the VPC Endpoint. Applicable for endpoints of type Interface.
- `vpc_endpoint_network_interface_ids` - One or more network interfaces for the VPC Endpoint. Applicable for endpoints of type Interface.
- `vpc_endpoint_owner_id` - The ID of the AWS account that owns the VPC endpoint.
- `vpc_endpoint_prefix_list_id` - The prefix list ID of the exposed AWS service. Applicable for endpoints of type Gateway.
- `vpc_endpoint_requester_managed` - Whether or not the VPC Endpoint is being managed by its service - true or false.
- `vpc_endpoint_state` - The state of the VPC endpoint.
- `vpc_endpoint_connection_notification_id` - The ID of the VPC connection notification.
- `vpc_endpoint_connection_notification_state` - The state of the notification.
- `vpc_endpoint_connection_notification_notification_type` - The type of notification.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
