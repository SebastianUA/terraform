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
