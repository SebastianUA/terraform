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
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS Gagemaker model
#---------------------------------------------------
variable "enable_sagemaker_model" {
  description = "Enable sagemaker model usage"
  default     = false
}

variable "sagemaker_model_name" {
  description = "The name of the model (must be unique). If omitted, Terraform will assign a random, unique name."
  default     = ""
}

variable "sagemaker_model_execution_role_arn" {
  description = "(Required) A role that SageMaker can assume to access model artifacts and docker images for deployment."
  default     = null
}

variable "sagemaker_model_enable_network_isolation" {
  description = "(Optional) - Isolates the model container. No inbound or outbound network calls can be made to or from the model container."
  default     = null
}

variable "sagemaker_model_vpc_config" {
  description = "(Optional) - Specifies the VPC that you want your model to connect to. VpcConfig is used in hosting services and in batch transform."
  default     = []
}

variable "sagemaker_model_inference_execution_config" {
  description = "(Optional) Specifies details of how containers in a multi-container endpoint are called"
  default     = []
}

variable "sagemaker_model_primary_container" {
  description = "(Optional) The primary docker image containing inference code that is used when the model is deployed for predictions. If not specified, the container argument is required."
  default     = []
}

variable "sagemaker_model_container" {
  description = "(Optional) - Specifies containers in the inference pipeline. If not specified, the primary_container argument is required."
  default     = []
}

#---------------------------------------------------
# AWS Sagemaker endpoint configuration
#---------------------------------------------------
variable "enable_sagemaker_endpoint_configuration" {
  description = "Enable sagemaker endpoint configuration usage"
  default     = false
}

variable "sagemaker_endpoint_configuration_name" {
  description = "(Optional) The name of the endpoint configuration. If omitted, Terraform will assign a random, unique name."
  default     = ""
}

variable "sagemaker_endpoint_configuration_name_prefix" {
  description = "(Optional) Creates a unique endpoint configuration name beginning with the specified prefix. Conflicts with name"
  default     = ""
}

variable "sagemaker_endpoint_configuration_kms_key_arn" {
  description = "(Optional) Amazon Resource Name (ARN) of a AWS Key Management Service key that Amazon SageMaker uses to encrypt data on the storage volume attached to the ML compute instance that hosts the endpoint."
  default     = null
}

variable "sagemaker_endpoint_configuration_production_variants" {
  description = "(Required) Fields for endpoint"
  default     = []
}

variable "sagemaker_endpoint_configuration_data_capture_config" {
  description = "(Optional) Specifies the parameters to capture input/output of SageMaker models endpoints"
  default     = []
}

variable "sagemaker_endpoint_configuration_shadow_production_variants" {
  description = "(Optional) Array of ProductionVariant objects. There is one for each model that you want to host at this endpoint in shadow mode with production traffic replicated from the model specified on ProductionVariants.If you use this field, you can only specify one variant for ProductionVariants and one variant for ShadowProductionVariants"
  default     = []
}

variable "sagemaker_endpoint_configuration_async_inference_config" {
  description = "(Optional) Specifies configuration for how an endpoint performs asynchronous inference."
  default     = []
}

variable "sagemaker_endpoint_deployment_config" {
  description = "(Optional) The deployment configuration for an endpoint, which contains the desired deployment strategy and rollback configurations"
  default     = []
}

#---------------------------------------------------
# AWS Sagemaker endpoint
#---------------------------------------------------
variable "enable_sagemaker_endpoint" {
  description = "Enable sagemaker endpoint usage"
  default     = false
}

variable "sagemaker_endpoint_name" {
  description = "The name of the endpoint. If omitted, Terraform will assign a random, unique name."
  default     = null
}

variable "sagemaker_endpoint_endpoint_config_name" {
  description = "The name of the endpoint configuration to use."
  default     = ""
}

#---------------------------------------------------
# AWS sagemaker notebook instance lifecycle configuration
#---------------------------------------------------
variable "enable_sagemaker_notebook_instance_lifecycle_configuration" {
  description = "Enable sagemaker notebook instance lifecycle configuration usage"
  default     = false
}

variable "sagemaker_notebook_instance_lifecycle_configuration_name" {
  description = "The name of the lifecycle configuration (must be unique). If omitted, Terraform will assign a random, unique name."
  default     = null
}

variable "sagemaker_notebook_instance_lifecycle_configuration_on_create" {
  description = "(Optional) A shell script (base64-encoded) that runs only once when the SageMaker Notebook Instance is created."
  default     = null
}

variable "sagemaker_notebook_instance_lifecycle_configuration_on_start" {
  description = "(Optional) A shell script (base64-encoded) that runs every time the SageMaker Notebook Instance is started including the time it's created."
  default     = null
}

#---------------------------------------------------
# AWS Sagemaker notebook instance
#---------------------------------------------------
variable "enable_sagemaker_notebook_instance" {
  description = "Enable sagemaker notebook instance usage"
  default     = false
}

variable "sagemaker_notebook_instance_name" {
  description = "The name of the notebook instance (must be unique)."
  default     = ""
}

variable "sagemaker_notebook_instance_role_arn" {
  description = "(Required) The ARN of the IAM role to be used by the notebook instance which allows SageMaker to call other services on your behalf."
  default     = null
}

variable "sagemaker_notebook_instance_instance_type" {
  description = "(Required) The name of ML compute instance type."
  default     = "ml.t2.medium"
}

variable "sagemaker_notebook_instance_platform_identifier" {
  description = "(Optional) The platform identifier of the notebook instance runtime environment. This value can be either notebook-al1-v1, notebook-al2-v1, or notebook-al2-v2, depending on which version of Amazon Linux you require."
  default     = null
}

variable "sagemaker_notebook_instance_volume_size" {
  description = "(Optional) The size, in GB, of the ML storage volume to attach to the notebook instance. The default value is 5 GB."
  default     = null
}

variable "sagemaker_notebook_instance_subnet_id" {
  description = "(Optional) The VPC subnet ID."
  default     = null
}

variable "sagemaker_notebook_instance_security_groups" {
  description = "(Optional) The associated security groups."
  default     = null
}

variable "sagemaker_notebook_instance_accelerator_types" {
  description = "(Optional) A list of Elastic Inference (EI) instance types to associate with this notebook instance. See Elastic Inference Accelerator for more details. Valid values: ml.eia1.medium, ml.eia1.large, ml.eia1.xlarge, ml.eia2.medium, ml.eia2.large, ml.eia2.xlarge"
  default     = null
}

variable "sagemaker_notebook_instance_additional_code_repositories" {
  description = "(Optional) An array of up to three Git repositories to associate with the notebook instance. These can be either the names of Git repositories stored as resources in your account, or the URL of Git repositories in AWS CodeCommit or in any other Git repository. These repositories are cloned at the same level as the default repository of your notebook instance."
  default     = null
}

variable "sagemaker_notebook_instance_default_code_repository" {
  description = "(Optional) The Git repository associated with the notebook instance as its default code repository. This can be either the name of a Git repository stored as a resource in your account, or the URL of a Git repository in AWS CodeCommit or in any other Git repository."
  default     = null
}

variable "sagemaker_notebook_instance_root_access" {
  description = "(Optional) Whether root access is Enabled or Disabled for users of the notebook instance. The default value is Enabled"
  default     = null
}

variable "sagemaker_notebook_instance_kms_key_id" {
  description = "(Optional) The AWS Key Management Service (AWS KMS) key that Amazon SageMaker uses to encrypt the model artifacts at rest using Amazon S3 server-side encryption."
  default     = null
}

variable "sagemaker_notebook_instance_lifecycle_config_name" {
  description = "(Optional) The name of a lifecycle configuration to associate with the notebook instance."
  default     = null
}

variable "sagemaker_notebook_instance_direct_internet_access" {
  description = "(Optional) Set to Disabled to disable internet access to notebook. Requires security_groups and subnet_id to be set. Supported values: Enabled (Default) or Disabled. If set to Disabled, the notebook instance will be able to access resources only in your VPC, and will not be able to connect to Amazon SageMaker training and endpoint services unless your configure a NAT Gateway in your VPC."
  default     = null
}

variable "sagemaker_notebook_instance_instance_metadata_service_configuration" {
  description = "(Optional) Information on the IMDS configuration of the notebook instance"
  default     = []
}

#---------------------------------------------------
# AWS Sagemaker user profile
#---------------------------------------------------
variable "enable_sagemaker_user_profile" {
  description = "Enable sagemaker user profile usage"
  default     = false
}

variable "sagemaker_user_profile_name" {
  description = "The name for the User Profile."
  default     = ""
}

variable "sagemaker_user_profile_domain_id" {
  description = "The ID of the associated Domain."
  default     = ""
}

variable "sagemaker_user_profile_single_sign_on_user_value" {
  description = "(Required) The username of the associated AWS Single Sign-On User for this User Profile. If the Domain's AuthMode is SSO, this field is required, and must match a valid username of a user in your directory. If the Domain's AuthMode is not SSO, this field cannot be specified."
  default     = null
}

variable "sagemaker_user_profile_single_sign_on_user_identifier" {
  description = "(Optional) A specifier for the type of value specified in single_sign_on_user_value. Currently, the only supported value is UserName. If the Domain's AuthMode is SSO, this field is required. If the Domain's AuthMode is not SSO, this field cannot be specified."
  default     = null
}

variable "sagemaker_user_profile_user_settings" {
  description = "AAA"
  default = {
    execution_role = null

    security_groups = null
  }
}

#---------------------------------------------------
# AWS Sagemaker domain
#---------------------------------------------------
variable "enable_sagemaker_domain" {
  description = "Enable sagemaker domain usage"
  default     = false
}

variable "sagemaker_domain_name" {
  description = "The domain name."
  default     = ""
}

variable "sagemaker_domain_auth_mode" {
  description = "(Required) The mode of authentication that members use to access the domain. Valid values are IAM and SSO"
  default     = null
}

variable "sagemaker_domain_vpc_id" {
  description = "(Required) The ID of the Amazon Virtual Private Cloud (VPC) that Studio uses for communication."
  default     = null
}

variable "sagemaker_domain_subnet_ids" {
  description = "(Required) The VPC subnets that Studio uses for communication."
  default     = null
}

variable "sagemaker_domain_kms_key_id" {
  description = "(Optional) The AWS KMS customer managed CMK used to encrypt the EFS volume attached to the domain."
  default     = null
}

variable "sagemaker_domain_app_network_access_type" {
  description = "(Optional) Specifies the VPC used for non-EFS traffic. The default value is PublicInternetOnly. Valid values are PublicInternetOnly and VpcOnly."
  default     = null
}

variable "sagemaker_domain_app_security_group_management" {
  description = "(Optional) The entity that creates and manages the required security groups for inter-app communication in VPCOnly mode. Valid values are Service and Customer."
  default     = null
}

variable "sagemaker_domain_retention_policy" {
  description = "(Optional) The retention policy for this domain, which specifies whether resources will be retained after the Domain is deleted. By default, all resources are retained"
  default     = {}
}

variable "sagemaker_domain_default_user_settings" {
  description = "(Required) The default user settings."
  default = {
    execution_role = null

    security_groups = null
  }
}

variable "sagemaker_domain_default_space_settings" {
  description = "(Required) The default space settings"
  default     = []
}

variable "sagemaker_domain_settings" {
  description = "(Optional) The domain's settings."
  default     = []
}



#---------------------------------------------------
# AWS sagemaker model package group
#---------------------------------------------------
variable "enable_sagemaker_model_package_group" {
  description = "Enable sagemaker model package group usage"
  default     = false
}

variable "sagemaker_model_package_group_name" {
  description = "The name of the model group."
  default     = ""
}

variable "sagemaker_model_package_group_description" {
  description = "AAA"
  default     = null
}

#---------------------------------------------------
# AWS sagemaker image
#---------------------------------------------------
variable "enable_sagemaker_image" {
  description = "Enable sagemaker image usage"
  default     = false
}

variable "sagemaker_image_name" {
  description = "The name of the image. Must be unique to your account."
  default     = ""
}

variable "sagemaker_image_role_arn" {
  description = "(Required) The Amazon Resource Name (ARN) of an IAM role that enables Amazon SageMaker to perform tasks on your behalf."
  default     = null
}

variable "sagemaker_image_display_name" {
  description = "(Optional) The display name of the image. When the image is added to a domain (must be unique to the domain)."
  default     = null
}

variable "sagemaker_image_description" {
  description = "(Optional) The description of the image."
  default     = null
}

#---------------------------------------------------
# AWS sagemaker image version
#---------------------------------------------------
variable "enable_sagemaker_image_version" {
  description = "Enable sagemaker image version usage"
  default     = false
}

variable "sagemaker_image_version_image_name" {
  description = "The name of the image. Must be unique to your account."
  default     = ""
}

variable "sagemaker_image_version_base_image" {
  description = "(Required) The registry path of the container image on which this image version is based."
  default     = null
}

#---------------------------------------------------
# AWS sagemaker feature group
#---------------------------------------------------
variable "enable_sagemaker_feature_group" {
  description = "Enable sagemaker feature group usage"
  default     = false
}

variable "sagemaker_feature_group_name" {
  description = "The name of the Feature Group. The name must be unique within an AWS Region in an AWS account."
  default     = ""
}

variable "sagemaker_feature_group_record_identifier_feature_name" {
  description = "The name of the Feature whose value uniquely identifies a Record defined in the Feature Store. Only the latest record per identifier value will be stored in the Online Store."
  default     = ""
}

variable "sagemaker_feature_group_event_time_feature_name" {
  description = "The name of the feature that stores the EventTime of a Record in a Feature Group."
  default     = ""
}

variable "sagemaker_feature_group_role_arn" {
  description = "(Required) - The Amazon Resource Name (ARN) of the IAM execution role used to persist data into the Offline Store if an offline_store_config is provided."
  default     = null
}

variable "sagemaker_feature_group_description" {
  description = "(Optional) - A free-form description of a Feature Group."
  default     = null
}

variable "sagemaker_feature_group_feature_definition" {
  description = "(Optional) - A list of Feature names and types."
  default     = []
}

variable "sagemaker_feature_group_offline_store_config" {
  description = "(Optional) - The Offline Feature Store Configuration."
  default     = []
}

variable "sagemaker_feature_group_online_store_config" {
  description = "(Optional) - The Online Feature Store Configuration."
  default     = []
}

#---------------------------------------------------
# AWS sagemaker code repository
#---------------------------------------------------
variable "enable_sagemaker_code_repository" {
  description = "Enable sagemaker code repository usage"
  default     = false
}

variable "sagemaker_code_repository_name" {
  description = "The name of the Code Repository (must be unique)."
  default     = ""
}

variable "sagemaker_code_repository_git_config" {
  description = "(Required) Specifies details about the repository."
  default     = []
}


#---------------------------------------------------
# AWS sagemaker app
#---------------------------------------------------
variable "enable_sagemaker_app" {
  description = "Enable sagemaker app usage"
  default     = false
}

variable "sagemaker_app_name" {
  description = "The name of the app."
  default     = ""
}

variable "sagemaker_app_type" {
  description = "(Required) The type of app. Valid values are JupyterServer, KernelGateway and TensorBoard"
  default     = null
}

variable "sagemaker_app_domain_id" {
  description = "The domain ID."
  default     = ""
}

variable "sagemaker_app_user_profile_name" {
  description = "The user profile name."
  default     = null
}

variable "sagemaker_app_space_name" {
  description = "(Optional) The name of the space. At least one of user_profile_name or space_name required."
  default     = null
}

variable "sagemaker_app_resource_spec" {
  description = "(Optional) The instance type and the Amazon Resource Name (ARN) of the SageMaker image created on the instance"
  default     = []
}

#---------------------------------------------------
# AWS sagemaker app image config
#---------------------------------------------------
variable "enable_sagemaker_app_image_config" {
  description = "Enable sagemaker app image config usage"
  default     = false
}

variable "sagemaker_app_image_config_name" {
  description = "The name of the App Image Config."
  default     = ""
}

variable "sagemaker_app_image_config_kernel_gateway_image_config" {
  description = "(Optional) The configuration for the file system and kernels in a SageMaker image running as a KernelGateway app."
  default     = []
}

#---------------------------------------------------
# AWS Sagemaker device fleet
#---------------------------------------------------
variable "enable_sagemaker_device_fleet" {
  description = "Enable sagemaker device fleet usage"
  default     = false
}

variable "sagemaker_device_fleet_name" {
  description = "Set name for sagemaker device fleet"
  default     = ""
}

variable "sagemaker_device_fleet_role_arn" {
  description = "(Required) The Amazon Resource Name (ARN) that has access to AWS Internet of Things (IoT)."
  default     = null
}

variable "sagemaker_device_fleet_description" {
  description = "(Optional) A description of the fleet."
  default     = null
}

variable "sagemaker_device_fleet_enable_iot_role_alias" {
  description = "(Optional) Whether to create an AWS IoT Role Alias during device fleet creation. The name of the role alias generated will match this pattern: 'SageMakerEdge-{DeviceFleetName}'."
  default     = null
}

variable "sagemaker_device_fleet_output_config" {
  description = "(Required) Specifies details about the repository."
  default     = []
}

#---------------------------------------------------
# AWS Sagemaker device
#---------------------------------------------------
variable "enable_sagemaker_device" {
  description = "Enable sagemaker device usage"
  default     = false
}

variable "sagemaker_device_device_fleet_name" {
  description = "The name of the Device."
  default     = ""
}

variable "sagemaker_device_devices" {
  description = "(Required) The list of devices to register with SageMaker Edge Manager."
  default     = []
}

#---------------------------------------------------
# AWS Sagemaker model package group policy
#---------------------------------------------------
variable "enable_sagemaker_model_package_group_policy" {
  description = "Enable sagemaker model package group policy usage"
  default     = false
}

variable "sagemaker_model_package_group_policy_model_package_group_name" {
  description = "The name of the model package group."
  default     = ""
}

variable "sagemaker_model_package_group_policy_resource_policy" {
  description = "The resource policy for the model package group."
  default     = null
}

#---------------------------------------------------
# AWS Sagemaker project
#---------------------------------------------------
variable "enable_sagemaker_project" {
  description = "Enable sagemaker project usage"
  default     = false
}

variable "sagemaker_project_name" {
  description = "The name of the Project."
  default     = ""
}

variable "sagemaker_project_project_description" {
  description = "(Optional) A description for the project."
  default     = null
}

variable "sagemaker_project_service_catalog_provisioning_details" {
  description = "(Required) The product ID and provisioning artifact ID to provision a service catalog"
  default     = []
}

#---------------------------------------------------
# AWS Sagemaker workteam
#---------------------------------------------------
variable "enable_sagemaker_workteam" {
  description = "Enable sagemaker workteam usage"
  default     = false
}

variable "sagemaker_workteam_name" {
  description = "The name of the workforce."
  default     = ""
}

variable "sagemaker_workteam_workforce_name" {
  description = "The name of the Workteam (must be unique)."
  default     = ""
}

variable "sagemaker_workteam_description" {
  description = "(Required) A description of the work team."
  default     = null
}

variable "sagemaker_workteam_member_definition" {
  description = "(Required) A list of Member Definitions that contains objects that identify the workers that make up the work team. Workforces can be created using Amazon Cognito or your own OIDC Identity Provider (IdP). For private workforces created using Amazon Cognito use cognito_member_definition. For workforces created using your own OIDC identity provider (IdP) use oidc_member_definition. Do not provide input for both of these parameters in a single request."
  default     = []
}

variable "sagemaker_workteam_notification_configuration" {
  description = "(Optional) Configures notification of workers regarding available or expiring work items."
  default     = []
}

#---------------------------------------------------
# AWS Sagemaker workforce
#---------------------------------------------------
variable "enable_sagemaker_workforce" {
  description = "Enable sagemaker workforce usage"
  default     = false
}

variable "sagemaker_workforce_name" {
  description = "The name of the Workforce (must be unique)."
  default     = ""
}

variable "sagemaker_workforce_cognito_config" {
  description = "(Required) Use this parameter to configure an Amazon Cognito private workforce. A single Cognito workforce is created using and corresponds to a single Amazon Cognito user pool. Conflicts with oidc_config"
  default     = []
}

variable "sagemaker_workforce_oidc_config" {
  description = "(Required) Use this parameter to configure a private workforce using your own OIDC Identity Provider. Conflicts with cognito_config"
  default     = []
}

variable "sagemaker_workforce_source_ip_config" {
  description = "(Required) A list of IP address ranges Used to create an allow list of IP addresses for a private workforce. By default, a workforce isn't restricted to specific IP addresses. "
  default     = []
}

#---------------------------------------------------
# AWS Sagemaker studio lifecycle config
#---------------------------------------------------
variable "enable_sagemaker_studio_lifecycle_config" {
  description = "Enable sagemaker studio lifecycle config usage"
  default     = false
}

variable "sagemaker_studio_lifecycle_config_name" {
  description = "The name of the Studio Lifecycle Configuration to create."
  default     = ""
}

variable "sagemaker_studio_lifecycle_config_app_type" {
  description = "(Required) The App type that the Lifecycle Configuration is attached to. Valid values are JupyterServer and KernelGateway."
  default     = null
}

variable "sagemaker_studio_lifecycle_config_content" {
  description = "(Required) The content of your Studio Lifecycle Configuration script. This content must be base64 encoded."
  default     = null
}

#---------------------------------------------------
# AWS Sagemaker flow definition
#---------------------------------------------------
variable "enable_sagemaker_flow_definition" {
  description = "Enable sagemaker flow definition usage"
  default     = false
}

variable "sagemaker_flow_definition_flow_definition_name" {
  description = "The name of your flow definition."
  default     = ""
}

variable "sagemaker_flow_definition_role_arn" {
  description = "(Required) The Amazon Resource Name (ARN) of the role needed to call other services on your behalf."
  default     = null
}

variable "sagemaker_flow_definition_human_loop_config" {
  description = "(Required) An object containing information about the tasks the human reviewers will perform"
  default     = []
}

variable "sagemaker_project_output_config" {
  description = "(Required) An object containing information about where the human review results will be uploaded."
  default     = []
}

variable "sagemaker_flow_definition_human_loop_activation_config" {
  description = "(Optional) An object containing information about the events that trigger a human workflow"
  default     = []
}

variable "sagemaker_flow_definition_human_loop_request_source" {
  description = "(Optional) Container for configuring the source of human task requests. Use to specify if Amazon Rekognition or Amazon Textract is used as an integration source."
  default     = []
}

#---------------------------------------------------
# AWS Sagemaker human task ui
#---------------------------------------------------
variable "enable_sagemaker_human_task_ui" {
  description = "Enable sagemaker human task ui usage"
  default     = false
}

variable "sagemaker_human_task_ui_name" {
  description = "The name of the Human Task UI."
  default     = ""
}

variable "sagemaker_human_task_ui_template" {
  description = "(Required) The Liquid template for the worker user interface."
  default     = []
}

#---------------------------------------------------
# AWS Sagemaker space
#---------------------------------------------------
variable "enable_sagemaker_space" {
  description = "Enable sagemaker space usage"
  default     = false
}

variable "sagemaker_space_name" {
  description = "The name of the space."
  default     = ""
}

variable "sagemaker_space_domain_id" {
  description = "(Required) The ID of the associated Domain."
  default     = ""
}

variable "sagemaker_space_settings" {
  description = "(Required) A collection of space settings."
  default     = []
}

#---------------------------------------------------
# AWS Sagemaker servicecatalog portfolio status
#---------------------------------------------------
variable "enable_sagemaker_servicecatalog_portfolio_status" {
  description = "Enable sagemaker servicecatalog portfolio status usage"
  default     = false
}

variable "sagemaker_servicecatalog_portfolio_status" {
  description = "(Required) Whether Service Catalog is enabled or disabled in SageMaker. Valid values are Enabled and Disabled"
  default     = null
}

#---------------------------------------------------
# AWS Sagemaker monitoring schedule
#---------------------------------------------------
variable "enable_sagemaker_monitoring_schedule" {
  description = "Enable sagemaker monitoring schedule usage"
  default     = false
}

variable "sagemaker_monitoring_schedule_name" {
  description = "(Optional) The name of the monitoring schedule. The name must be unique within an AWS Region within an AWS account. If omitted, Terraform will assign a random, unique name."
  default     = null
}

variable "sagemaker_monitoring_schedule_config" {
  description = "(Required) The configuration object that specifies the monitoring schedule and defines the monitoring job."
  default     = []
}

#---------------------------------------------------
# AWS Sagemaker data quality job definition
#---------------------------------------------------
variable "enable_sagemaker_data_quality_job_definition" {
  description = "Enable sagemaker data quality job definition usage"
  default     = false
}

variable "sagemaker_data_quality_job_definition_name" {
  description = "(Optional) The name of the data quality job definition. If omitted, Terraform will assign a random, unique name."
  default     = null
}

variable "sagemaker_data_quality_job_definition_role_arn" {
  description = "(Required) The Amazon Resource Name (ARN) of an IAM role that Amazon SageMaker can assume to perform tasks on your behalf."
  default     = null
}

variable "sagemaker_data_quality_job_definition_data_quality_app_specification" {
  description = "(Required) Specifies the container that runs the monitoring job."
  default     = []
}

variable "sagemaker_data_quality_job_definition_data_quality_job_input" {
  description = "(Required) A list of inputs for the monitoring job."
  default     = []
}

variable "sagemaker_data_quality_job_definition_data_quality_job_output_config" {
  description = "(Required) The output configuration for monitoring jobs"
  default     = []
}

variable "sagemaker_data_quality_job_definition_job_resources" {
  description = "(Required) Identifies the resources to deploy for a monitoring job."
  default     = []
}

variable "sagemaker_data_quality_job_definition_data_quality_baseline_config" {
  description = "(Optional) Configures the constraints and baselines for the monitoring job"
  default     = []
}

variable "sagemaker_data_quality_job_definition_network_config" {
  description = "(Optional) Specifies networking configuration for the monitoring job."
  default     = []
}

variable "sagemaker_data_quality_job_definition_stopping_condition" {
  description = "(Optional) A time limit for how long the monitoring job is allowed to run before stopping."
  default     = []
}