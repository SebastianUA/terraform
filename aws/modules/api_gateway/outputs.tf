#---------------------------------------------------
# AWS API Gateway account
#---------------------------------------------------
output "api_gateway_account_id" {
  description = "The ID of the apy gateway account"
  value       = element(concat(aws_api_gateway_account.api_gateway_account.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway api key
#---------------------------------------------------
output "api_gateway_api_key_id" {
  description = "The ID of the API key"
  value       = element(concat(aws_api_gateway_api_key.api_gateway_api_key.*.id, [""]), 0)
}

output "api_gateway_api_key_created_date" {
  description = "The creation date of the API key"
  value       = element(concat(aws_api_gateway_api_key.api_gateway_api_key.*.created_date, [""]), 0)
}

output "api_gateway_api_key_last_updated_date" {
  description = "The last update date of the API key"
  value       = element(concat(aws_api_gateway_api_key.api_gateway_api_key.*.last_updated_date, [""]), 0)
}

output "api_gateway_api_key_value" {
  description = "The value of the API key"
  value       = element(concat(aws_api_gateway_api_key.api_gateway_api_key.*.value, [""]), 0)
}

output "api_gateway_api_key_arn" {
  description = "Amazon Resource Name (ARN)"
  value       = element(concat(aws_api_gateway_api_key.api_gateway_api_key.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway rest api
#---------------------------------------------------
output "api_gateway_rest_api_id" {
  description = "The ID of the REST API"
  value       = element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
}

output "api_gateway_rest_api_root_resource_id" {
  description = "The resource ID of the REST API's root"
  value       = element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.root_resource_id, [""]), 0)
}

output "api_gateway_rest_api_created_date" {
  description = "The creation date of the REST API"
  value       = element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.created_date, [""]), 0)
}

output "api_gateway_rest_api_execution_arn" {
  description = "The execution ARN part to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function, e.g. arn:aws:execute-api:eu-west-2:123456789012:z4675bid1j, which can be concatenated with allowed stage, method and resource path."
  value       = element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.execution_arn, [""]), 0)
}

output "api_gateway_rest_api_arn" {
  description = "Amazon Resource Name (ARN)"
  value       = element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway authorizer
#---------------------------------------------------
output "api_gateway_authorizer_id" {
  description = "The ID of the GW authorizer"
  value       = element(concat(aws_api_gateway_authorizer.api_gateway_authorizer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway VPC link
#---------------------------------------------------
output "api_gateway_vpc_link" {
  description = "The identifier of the VpcLink."
  value       = element(concat(aws_api_gateway_vpc_link.api_gateway_vpc_link.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway resource
#---------------------------------------------------
output "api_gateway_resource_id" {
  description = "The resource's identifier."
  value       = element(concat(aws_api_gateway_resource.api_gateway_resource.*.id, [""]), 0)
}

output "api_gateway_resource_path" {
  description = "The complete path for this API resource, including all parent paths."
  value       = element(concat(aws_api_gateway_resource.api_gateway_resource.*.path, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway request validator
#---------------------------------------------------
output "api_gateway_request_validator_id" {
  description = "The unique ID of the request validator"
  value       = element(concat(aws_api_gateway_request_validator.api_gateway_request_validator.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway model
#---------------------------------------------------
output "api_gateway_model_id" {
  description = "The ID of the model"
  value       = element(concat(aws_api_gateway_model.api_gateway_model.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway method
#---------------------------------------------------
output "api_gateway_method_id" {
  description = "The ID of the method"
  value       = element(concat(aws_api_gateway_method.api_gateway_method.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway method response
#---------------------------------------------------
output "api_gateway_method_response_id" {
  description = "The ID of the method response"
  value       = element(concat(aws_api_gateway_method_response.api_gateway_method_response.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway integration
#---------------------------------------------------
output "api_gateway_integration_id" {
  description = "The ID of the integration"
  value       = element(concat(aws_api_gateway_integration.api_gateway_integration.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway integration response
#---------------------------------------------------
output "api_gateway_integration_response_id" {
  description = "The ID of the integration response"
  value       = element(concat(aws_api_gateway_integration_response.api_gateway_integration_response.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway response
#---------------------------------------------------
output "api_gateway_gateway_response_id" {
  description = "The ID of the gateway response"
  value       = element(concat(aws_api_gateway_gateway_response.api_gateway_gateway_response.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway domain name
#---------------------------------------------------
output "api_gateway_domain_name_id" {
  description = "The internal id assigned to this domain name by API Gateway."
  value       = element(concat(aws_api_gateway_domain_name.api_gateway_domain_name.*.id, [""]), 0)
}

output "api_gateway_domain_name_certificate_upload_date" {
  description = "The upload date associated with the domain certificate."
  value       = element(concat(aws_api_gateway_domain_name.api_gateway_domain_name.*.certificate_upload_date, [""]), 0)
}

output "api_gateway_domain_name_cloudfront_domain_name" {
  description = "The hostname created by Cloudfront to represent the distribution that implements this domain name mapping."
  value       = element(concat(aws_api_gateway_domain_name.api_gateway_domain_name.*.cloudfront_domain_name, [""]), 0)
}

output "api_gateway_domain_name_cloudfront_zone_id" {
  description = "For convenience, the hosted zone ID (Z2FDTNDATAQYW2) that can be used to create a Route53 alias record for the distribution."
  value       = element(concat(aws_api_gateway_domain_name.api_gateway_domain_name.*.cloudfront_zone_id, [""]), 0)
}

output "api_gateway_domain_name_regional_zone_id" {
  description = "The hosted zone ID that can be used to create a Route53 alias record for the regional endpoint."
  value       = element(concat(aws_api_gateway_domain_name.api_gateway_domain_name.*.regional_zone_id, [""]), 0)
}

output "api_gateway_domain_name_arn" {
  description = "Amazon Resource Name (ARN)"
  value       = element(concat(aws_api_gateway_domain_name.api_gateway_domain_name.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway client certificate
#---------------------------------------------------
output "api_gateway_client_certificate_id" {
  description = "The identifier of the client certificate."
  value       = element(concat(aws_api_gateway_client_certificate.api_gateway_client_certificate.*.id, [""]), 0)
}

output "api_gateway_client_certificate_created_date" {
  description = "The date when the client certificate was created."
  value       = element(concat(aws_api_gateway_client_certificate.api_gateway_client_certificate.*.created_date, [""]), 0)
}

output "api_gateway_client_certificate_expiration_date" {
  description = "The date when the client certificate will expire."
  value       = element(concat(aws_api_gateway_client_certificate.api_gateway_client_certificate.*.expiration_date, [""]), 0)
}

output "api_gateway_client_certificate_pem_encoded_certificate" {
  description = "The PEM-encoded public key of the client certificate."
  value       = element(concat(aws_api_gateway_client_certificate.api_gateway_client_certificate.*.pem_encoded_certificate, [""]), 0)
}

output "api_gateway_client_certificate_arn" {
  description = "Amazon Resource Name (ARN)"
  value       = element(concat(aws_api_gateway_client_certificate.api_gateway_client_certificate.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway documentation part
#---------------------------------------------------
output "api_gateway_documentation_part_id" {
  description = "The unique ID of the Documentation Part"
  value       = element(concat(aws_api_gateway_documentation_part.api_gateway_documentation_part.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway documentation version
#---------------------------------------------------
output "api_gateway_documentation_version_id" {
  description = "The unique ID of the Documentation version"
  value       = element(concat(aws_api_gateway_documentation_version.api_gateway_documentation_version.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway deployment
#---------------------------------------------------
output "api_gateway_deployment_id" {
  description = "The ID of the deployment"
  value       = element(concat(aws_api_gateway_deployment.api_gateway_deployment.*.id, [""]), 0)
}

output "api_gateway_deployment_invoke_url" {
  description = "The URL to invoke the API pointing to the stage, e.g. https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/prod"
  value       = element(concat(aws_api_gateway_deployment.api_gateway_deployment.*.invoke_url, [""]), 0)
}

output "api_gateway_deployment_execution_arn" {
  description = "The execution ARN to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function, e.g. arn:aws:execute-api:eu-west-2:123456789012:z4675bid1j/prod"
  value       = element(concat(aws_api_gateway_deployment.api_gateway_deployment.*.execution_arn, [""]), 0)
}

output "api_gateway_deployment_created_date" {
  description = "The creation date of the deployment"
  value       = element(concat(aws_api_gateway_deployment.api_gateway_deployment.*.created_date, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway stage
#---------------------------------------------------
output "api_gateway_stage_id" {
  description = "The ID of the stage"
  value       = element(concat(aws_api_gateway_stage.api_gateway_stage.*.id, [""]), 0)
}

output "api_gateway_stage_arn" {
  description = "Amazon Resource Name (ARN)"
  value       = element(concat(aws_api_gateway_stage.api_gateway_stage.*.arn, [""]), 0)
}

output "api_gateway_stage_invoke_url" {
  description = "The URL to invoke the API pointing to the stage, e.g. https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/prod"
  value       = element(concat(aws_api_gateway_stage.api_gateway_stage.*.invoke_url, [""]), 0)
}

output "api_gateway_stage_execution_arn" {
  description = "The execution ARN to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function, e.g. arn:aws:execute-api:eu-west-2:123456789012:z4675bid1j/prod"
  value       = element(concat(aws_api_gateway_stage.api_gateway_stage.*.execution_arn, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway base path mapping
#---------------------------------------------------
output "api_gateway_base_path_mapping_id" {
  description = "The ID of the base path mapping"
  value       = element(concat(aws_api_gateway_base_path_mapping.api_gateway_base_path_mapping.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway method settings
#---------------------------------------------------
output "api_gateway_method_settings_id" {
  description = "The ID of the method settings"
  value       = element(concat(aws_api_gateway_method_settings.api_gateway_method_settings.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway usage plan
#---------------------------------------------------
output "api_gateway_usage_plan_id" {
  description = "The ID of the API resource"
  value       = element(concat(aws_api_gateway_usage_plan.api_gateway_usage_plan.*.id, [""]), 0)
}

output "api_gateway_usage_plan_name" {
  description = "The name of the usage plan."
  value       = element(concat(aws_api_gateway_usage_plan.api_gateway_usage_plan.*.name, [""]), 0)
}

output "api_gateway_usage_plan_description" {
  description = "The description of a usage plan."
  value       = element(concat(aws_api_gateway_usage_plan.api_gateway_usage_plan.*.description, [""]), 0)
}

output "api_gateway_usage_plan_api_stages" {
  description = "The associated API stages of the usage plan."
  value       = concat(aws_api_gateway_usage_plan.api_gateway_usage_plan.*.api_stages, [""])
}

output "api_gateway_usage_plan_quota_settings" {
  description = "The quota of the usage plan."
  value       = concat(aws_api_gateway_usage_plan.api_gateway_usage_plan.*.quota_settings, [""])
}

output "api_gateway_usage_plan_throttle_settings" {
  description = "The throttling limits of the usage plan."
  value       = element(concat(aws_api_gateway_usage_plan.api_gateway_usage_plan.*.throttle_settings, [""]), 0)
}

output "api_gateway_usage_plan_product_code" {
  description = "The AWS Markeplace product identifier to associate with the usage plan as a SaaS product on AWS Marketplace."
  value       = element(concat(aws_api_gateway_usage_plan.api_gateway_usage_plan.*.product_code, [""]), 0)
}

output "api_gateway_usage_plan_arn" {
  description = "Amazon Resource Name (ARN)"
  value       = element(concat(aws_api_gateway_usage_plan.api_gateway_usage_plan.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway usage plan key
#---------------------------------------------------
output "api_gateway_usage_plan_key_id" {
  description = "The Id of a usage plan key."
  value       = element(concat(aws_api_gateway_usage_plan_key.api_gateway_usage_plan_key.*.id, [""]), 0)
}

output "api_gateway_usage_plan_key_key_id" {
  description = "The identifier of the API gateway key resource."
  value       = element(concat(aws_api_gateway_usage_plan_key.api_gateway_usage_plan_key.*.key_id, [""]), 0)
}

output "api_gateway_usage_plan_key_key_type" {
  description = "The type of a usage plan key. Currently, the valid key type is API_KEY."
  value       = element(concat(aws_api_gateway_usage_plan_key.api_gateway_usage_plan_key.*.key_type, [""]), 0)
}

output "api_gateway_usage_plan_key_usage_plan_id" {
  description = "The ID of the API resource"
  value       = element(concat(aws_api_gateway_usage_plan_key.api_gateway_usage_plan_key.*.usage_plan_id, [""]), 0)
}

output "api_gateway_usage_plan_key_name" {
  description = "The name of a usage plan key."
  value       = element(concat(aws_api_gateway_usage_plan_key.api_gateway_usage_plan_key.*.name, [""]), 0)
}

output "api_gateway_usage_plan_key_value" {
  description = "The value of a usage plan key."
  value       = element(concat(aws_api_gateway_usage_plan_key.api_gateway_usage_plan_key.*.value, [""]), 0)
}
