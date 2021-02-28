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

#---------------------------------------------------
# AWS Sagemaker user profile
#---------------------------------------------------
output "sagemaker_user_profile_id" {
  description = "The user profile Amazon Resource Name (ARN)."
  value       = element(concat(aws_sagemaker_user_profile.sagemaker_user_profile.*.id, [""]), 0)
}

output "sagemaker_user_profile_arn" {
  description = "The user profile Amazon Resource Name (ARN)."
  value       = element(concat(aws_sagemaker_user_profile.sagemaker_user_profile.*.arn, [""]), 0)
}

output "sagemaker_user_profile_home_efs_file_system_uid" {
  description = "The ID of the user's profile in the Amazon Elastic File System (EFS) volume."
  value       = element(concat(aws_sagemaker_user_profile.sagemaker_user_profile.*.home_efs_file_system_uid, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker domain
#---------------------------------------------------
output "sagemaker_domain_id" {
  description = "The ID of the Domain."
  value       = element(concat(aws_sagemaker_domain.sagemaker_domain.*.id, [""]), 0)
}

output "sagemaker_domain_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Domain."
  value       = element(concat(aws_sagemaker_domain.sagemaker_domain.*.arn, [""]), 0)
}

output "sagemaker_domain_url" {
  description = "The domain's URL."
  value       = element(concat(aws_sagemaker_domain.sagemaker_domain.*.url, [""]), 0)
}

output "sagemaker_domain_single_sign_on_managed_application_instance_id" {
  description = "The SSO managed application instance ID."
  value       = element(concat(aws_sagemaker_domain.sagemaker_domain.*.single_sign_on_managed_application_instance_id, [""]), 0)
}

output "sagemaker_domain_home_efs_file_system_id" {
  description = "The ID of the Amazon Elastic File System (EFS) managed by this Domain."
  value       = element(concat(aws_sagemaker_domain.sagemaker_domain.*.home_efs_file_system_id, [""]), 0)
}

#---------------------------------------------------
# AWS sagemaker model package group
#---------------------------------------------------
output "sagemaker_model_package_group_id" {
  description = "The name of the Model Package Group."
  value       = element(concat(aws_sagemaker_model_package_group.sagemaker_model_package_group.*.id, [""]), 0)
}

output "sagemaker_model_package_group_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Model Package Group."
  value       = element(concat(aws_sagemaker_model_package_group.sagemaker_model_package_group.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS sagemaker image
#---------------------------------------------------
output "sagemaker_image_id" {
  description = "The name of the Image."
  value       = element(concat(aws_sagemaker_image.sagemaker_image.*.id, [""]), 0)
}

output "sagemaker_image_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Image."
  value       = element(concat(aws_sagemaker_image.sagemaker_image.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS sagemaker image version
#---------------------------------------------------
output "sagemaker_image_version_id" {
  description = "The name of the Image version."
  value       = element(concat(aws_sagemaker_image_version.sagemaker_image_version.*.id, [""]), 0)
}

output "sagemaker_image_version_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Image version."
  value       = element(concat(aws_sagemaker_image_version.sagemaker_image_version.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS sagemaker feature group
#---------------------------------------------------
output "sagemaker_feature_group_id" {
  description = "The name of the feature group."
  value       = element(concat(aws_sagemaker_feature_group.sagemaker_feature_group.*.id, [""]), 0)
}

output "sagemaker_feature_group_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this feature_group."
  value       = element(concat(aws_sagemaker_feature_group.sagemaker_feature_group.*.arn, [""]), 0)
}

output "sagemaker_feature_group_name" {
  description = "The name of the Feature Group."
  value       = element(concat(aws_sagemaker_feature_group.sagemaker_feature_group.*.name, [""]), 0)
}

#---------------------------------------------------
# AWS sagemaker code repository
#---------------------------------------------------
output "sagemaker_code_repository_id" {
  description = "The name of the Code Repository."
  value       = element(concat(aws_sagemaker_code_repository.sagemaker_code_repository.*.id, [""]), 0)
}

output "sagemaker_code_repository_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Code Repository."
  value       = element(concat(aws_sagemaker_code_repository.sagemaker_code_repository.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS sagemaker app image config
#---------------------------------------------------
output "sagemaker_app_image_config_id" {
  description = "The name of the app image config."
  value       = element(concat(aws_sagemaker_app_image_config.sagemaker_app_image_config.*.id, [""]), 0)
}

output "sagemaker_app_image_config_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this App Image Config."
  value       = element(concat(aws_sagemaker_app_image_config.sagemaker_app_image_config.*.arn, [""]), 0)
}
