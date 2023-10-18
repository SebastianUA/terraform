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

output "sagemaker_model_package_group_model_package_group_name" {
  description = "The name of Model Package Group."
  value       = element(concat(aws_sagemaker_model_package_group.sagemaker_model_package_group.*.model_package_group_name, [""]), 0)
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

# output "sagemaker_feature_group_name" {
#  description = "The name of the Feature Group."
#  value       = element(concat(aws_sagemaker_feature_group.sagemaker_feature_group.*.name, [""]), 0)
# }

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
# AWS sagemaker app
#---------------------------------------------------
output "sagemaker_app_id" {
  description = "The Amazon Resource Name (ARN) of the app."
  value       = element(concat(aws_sagemaker_app.sagemaker_app.*.id, [""]), 0)
}

output "sagemaker_app_arn" {
  description = "The Amazon Resource Name (ARN) of the app."
  value       = element(concat(aws_sagemaker_app.sagemaker_app.*.arn, [""]), 0)
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

#---------------------------------------------------
# AWS Sagemaker device fleet
#---------------------------------------------------
output "sagemaker_device_fleet_id" {
  description = "The name of the Device Fleet."
  value       = element(concat(aws_sagemaker_device_fleet.sagemaker_device_fleet.*.id, [""]), 0)
}

output "sagemaker_device_fleet_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Device Fleet."
  value       = element(concat(aws_sagemaker_device_fleet.sagemaker_device_fleet.*.arn, [""]), 0)
}

output "sagemaker_device_fleet_device_fleet_name" {
  description = "The Name assigned by AWS to this Device Fleet."
  value       = element(concat(aws_sagemaker_device_fleet.sagemaker_device_fleet.*.device_fleet_name, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker device
#---------------------------------------------------
output "sagemaker_device_id" {
  description = "The name of the Device."
  value       = element(concat(aws_sagemaker_device.sagemaker_device.*.id, [""]), 0)
}

output "sagemaker_device_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Device."
  value       = element(concat(aws_sagemaker_device.sagemaker_device.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker model package group policy
#---------------------------------------------------
output "sagemaker_model_package_group_policy_id" {
  description = "The name of the Model Package Package Group."
  value       = element(concat(aws_sagemaker_model_package_group_policy.sagemaker_model_package_group_policy.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker project
#---------------------------------------------------
output "sagemaker_project_id" {
  description = "The name of the Project."
  value       = element(concat(aws_sagemaker_project.sagemaker_project.*.id, [""]), 0)
}

output "sagemaker_project_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Project."
  value       = element(concat(aws_sagemaker_project.sagemaker_project.*.arn, [""]), 0)
}

output "sagemaker_project_project_id" {
  description = "The ID of the project."
  value       = element(concat(aws_sagemaker_project.sagemaker_project.*.project_id, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker workteam
#---------------------------------------------------
output "sagemaker_workteam_id" {
  description = "The name of the Workteam."
  value       = element(concat(aws_sagemaker_workteam.sagemaker_workteam.*.id, [""]), 0)
}

output "sagemaker_workteam_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Workteam."
  value       = element(concat(aws_sagemaker_workteam.sagemaker_workteam.*.arn, [""]), 0)
}

output "sagemaker_workteam_subdomain" {
  description = "The subdomain for your OIDC Identity Provider."
  value       = element(concat(aws_sagemaker_workteam.sagemaker_workteam.*.subdomain, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker workforce
#---------------------------------------------------
output "sagemaker_workforce_id" {
  description = "The name of the Workforce."
  value       = element(concat(aws_sagemaker_workforce.sagemaker_workforce.*.id, [""]), 0)
}

output "sagemaker_workforce_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Workforce."
  value       = element(concat(aws_sagemaker_workforce.sagemaker_workforce.*.arn, [""]), 0)
}

output "sagemaker_workforce_subdomain" {
  description = "The subdomain for your OIDC Identity Provider."
  value       = element(concat(aws_sagemaker_workforce.sagemaker_workforce.*.subdomain, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker studio lifecycle config
#---------------------------------------------------
output "sagemaker_studio_lifecycle_config_id" {
  description = "The name of the Studio Lifecycle Config."
  value       = element(concat(aws_sagemaker_studio_lifecycle_config.sagemaker_studio_lifecycle_config.*.id, [""]), 0)
}

output "sagemaker_studio_lifecycle_config_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Studio Lifecycle Config."
  value       = element(concat(aws_sagemaker_studio_lifecycle_config.sagemaker_studio_lifecycle_config.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker flow definition
#---------------------------------------------------
output "sagemaker_flow_definition_id" {
  description = "The name of the Flow Definition."
  value       = element(concat(aws_sagemaker_flow_definition.sagemaker_flow_definition.*.id, [""]), 0)
}

output "sagemaker_flow_definition_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Flow Definition."
  value       = element(concat(aws_sagemaker_flow_definition.sagemaker_flow_definition.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker human task ui
#---------------------------------------------------
output "sagemaker_human_task_ui_id" {
  description = "The name of the Human Task UI."
  value       = element(concat(aws_sagemaker_human_task_ui.sagemaker_human_task_ui.*.id, [""]), 0)
}

output "sagemaker_human_task_ui_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this Human Task UI."
  value       = element(concat(aws_sagemaker_human_task_ui.sagemaker_human_task_ui.*.arn, [""]), 0)
}

output "sagemaker_human_task_ui_template" {
  description = "The Liquid template for the worker user interface"
  value       = concat(aws_sagemaker_human_task_ui.sagemaker_human_task_ui.*.ui_template, [""])
}

#---------------------------------------------------
# AWS Sagemaker space
#---------------------------------------------------
output "sagemaker_space_id" {
  description = "The space's Amazon Resource Name (ARN)."
  value       = element(concat(aws_sagemaker_space.sagemaker_space.*.id, [""]), 0)
}

output "sagemaker_space_arn" {
  description = "The space's Amazon Resource Name (ARN)."
  value       = element(concat(aws_sagemaker_space.sagemaker_space.*.arn, [""]), 0)
}

output "sagemaker_space_home_efs_file_system_uid" {
  description = "The ID of the space's profile in the Amazon Elastic File System volume."
  value       = element(concat(aws_sagemaker_space.sagemaker_space.*.home_efs_file_system_uid, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker servicecatalog portfolio status
#---------------------------------------------------
output "sagemaker_servicecatalog_portfolio_status_id" {
  description = "The AWS Region the Servicecatalog portfolio status resides in."
  value       = element(concat(aws_sagemaker_servicecatalog_portfolio_status.sagemaker_servicecatalog_portfolio_status.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker monitoring schedule
#---------------------------------------------------
output "sagemaker_monitoring_schedule_id" {
  description = "ID assigned by AWS to this monitoring schedule."
  value       = element(concat(aws_sagemaker_monitoring_schedule.sagemaker_monitoring_schedule.*.id, [""]), 0)
}

output "sagemaker_monitoring_schedule_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this monitoring schedule."
  value       = element(concat(aws_sagemaker_monitoring_schedule.sagemaker_monitoring_schedule.*.arn, [""]), 0)
}

output "sagemaker_monitoring_schedule_name" {
  description = "The name of the monitoring schedule."
  value       = element(concat(aws_sagemaker_monitoring_schedule.sagemaker_monitoring_schedule.*.name, [""]), 0)
}

#---------------------------------------------------
# AWS Sagemaker data quality job definition
#---------------------------------------------------
output "sagemaker_data_quality_job_definition_id" {
  description = "The ID of the data quality job definition."
  value       = element(concat(aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definition.*.id, [""]), 0)
}

output "sagemaker_data_quality_job_definition_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this data quality job definition."
  value       = element(concat(aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definition.*.arn, [""]), 0)
}

output "sagemaker_data_quality_job_definition_name" {
  description = "The name of the data quality job definition."
  value       = element(concat(aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definition.*.name, [""]), 0)
}
