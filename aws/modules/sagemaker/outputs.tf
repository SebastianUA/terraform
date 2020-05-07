#---------------------------------------------------
# AWS Gagemaker model
#---------------------------------------------------
output "sagemaker_model_id" {
    description = "The ID of sagemaker model"
    value       = element(concat(aws_sagemaker_model.sagemaker_model.*.id, [""]), 0)
}

output "sagemaker_model_name" {
    description = "The name of the model."
    value       = element(concat(aws_sagemaker_model.sagemaker_model.*.name, [""]), 0)
}

output "sagemaker_model_arn" {
    description = "The Amazon Resource Name (ARN) assigned by AWS to this model."
    value       = element(concat(aws_sagemaker_model.sagemaker_model.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker endpoint configuration
#---------------------------------------------------
output "sagemaker_endpoint_configuration_id" {
    description = "The ID of sagemaker endpoint configuration"
    value       = element(concat(aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration.*.id, [""]), 0)
}

output "sagemaker_endpoint_configuration_arn" {
    description = "The Amazon Resource Name (ARN) assigned by AWS to this endpoint configuration."
    value       = element(concat(aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration.*.arn, [""]), 0)
}

output "sagemaker_endpoint_configuration_name" {
    description = "The name of the endpoint configuration."
    value       = element(concat(aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration.*.name, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker endpoint
#---------------------------------------------------
output "sagemaker_endpoint_id" {
    description = "The ID of sagemaker endpoint"
    value       = element(concat(aws_sagemaker_endpoint.sagemaker_endpoint.*.id, [""]), 0)
}

output "sagemaker_endpoint_arn" {
    description = "The Amazon Resource Name (ARN) assigned by AWS to this endpoint."
    value       = element(concat(aws_sagemaker_endpoint.sagemaker_endpoint.*.arn, [""]), 0)
}

output "sagemaker_endpoint_name" {
    description = "The name of the endpoint."
    value       = element(concat(aws_sagemaker_endpoint.sagemaker_endpoint.*.name, [""]), 0)
}

#---------------------------------------------------
# AWS sagemaker notebook instance lifecycle configuration
#---------------------------------------------------
output "sagemaker_notebook_instance_lifecycle_configuration_id" {
    description = "The ID of notebook instance lifecycle configuration"
    value       = element(concat(aws_sagemaker_notebook_instance_lifecycle_configuration.sagemaker_notebook_instance_lifecycle_configuration.*.id, [""]), 0)
}

output "sagemaker_notebook_instance_lifecycle_configuration_arn" {
    description = "The Amazon Resource Name (ARN) assigned by AWS to this lifecycle configuration."
    value       = element(concat(aws_sagemaker_notebook_instance_lifecycle_configuration.sagemaker_notebook_instance_lifecycle_configuration.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker notebook instance
#---------------------------------------------------
output "sagemaker_notebook_instance_id" {
    description = "The name of the notebook instance."
    value       = element(concat(aws_sagemaker_notebook_instance.sagemaker_notebook_instance.*.id, [""]), 0)
}

output "sagemaker_notebook_instance_arn" {
    description = "The Amazon Resource Name (ARN) assigned by AWS to this notebook instance."
    value       = element(concat(aws_sagemaker_notebook_instance.sagemaker_notebook_instance.*.id, [""]), 0)
}
