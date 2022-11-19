# Work with SAGEMAKER via terraform

A terraform module for making SAGEMAKER.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

# Get the usera and account information
data "aws_caller_identity" "current" {
}

module "sagemaker" {
  source      = "../../modules/sagemaker"
  name        = "TEST"
  environment = "stage"

  # Sagemaker model
  enable_sagemaker_model             = true
  sagemaker_model_name               = ""
  sagemaker_model_execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/admin-role"

  sagemaker_model_primary_container = [{
    image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/sagemaker-sparkml-serving"
  }]
  sagemaker_model_container = []

  # Sagemaker endpoint config
  enable_sagemaker_endpoint_configuration = true
  sagemaker_endpoint_configuration_name   = ""
  sagemaker_endpoint_configuration_production_variants = [{
    initial_instance_count = 1
    instance_type          = "ml.t2.medium"
    variant_name           = "sage-endpoint-config-1"
  }]

  # Sagemaker endpoint
  enable_sagemaker_endpoint = true
  sagemaker_endpoint_name   = ""

  # Sagemaker notebook instance lifecycle configuration
  enable_sagemaker_notebook_instance_lifecycle_configuration    = true
  sagemaker_notebook_instance_lifecycle_configuration_name      = ""
  sagemaker_notebook_instance_lifecycle_configuration_on_create = null
  sagemaker_notebook_instance_lifecycle_configuration_on_start  = null

  # Sagemaker notebook instance
  enable_sagemaker_notebook_instance        = true
  sagemaker_notebook_instance_name          = ""
  sagemaker_notebook_instance_role_arn      = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/admin-role"
  sagemaker_notebook_instance_instance_type = "ml.t2.medium"

  sagemaker_notebook_instance_subnet_id              = null
  sagemaker_notebook_instance_security_groups        = null
  sagemaker_notebook_instance_kms_key_id             = null
  sagemaker_notebook_instance_direct_internet_access = null

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
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_sagemaker_model` - Enable sagemaker model usage (`default = False`)
- `sagemaker_model_name` - The name of the model (must be unique). If omitted, Terraform will assign a random, unique name. (`default = ""`)
- `sagemaker_model_execution_role_arn` - (Required) A role that SageMaker can assume to access model artifacts and docker images for deployment. (`default = null`)
- `sagemaker_model_enable_network_isolation` - (Optional) - Isolates the model container. No inbound or outbound network calls can be made to or from the model container. (`default = null`)
- `sagemaker_model_vpc_config` - (Optional) - Specifies the VPC that you want your model to connect to. VpcConfig is used in hosting services and in batch transform. (`default = []`)
- `sagemaker_model_primary_container` - (Optional) The primary docker image containing inference code that is used when the model is deployed for predictions. If not specified, the container argument is required.  (`default = []`)
- `sagemaker_model_container` - (Optional) - Specifies containers in the inference pipeline. If not specified, the primary_container argument is required. (`default = []`)
- `enable_sagemaker_endpoint_configuration` - Enable sagemaker endpoint configuration usage (`default = False`)
- `sagemaker_endpoint_configuration_name` - The name of the endpoint configuration. If omitted, Terraform will assign a random, unique name. (`default = ""`)
- `sagemaker_endpoint_configuration_kms_key_arn` - (Optional) Amazon Resource Name (ARN) of a AWS Key Management Service key that Amazon SageMaker uses to encrypt data on the storage volume attached to the ML compute instance that hosts the endpoint. (`default = null`)
- `sagemaker_endpoint_configuration_production_variants` - (Required) Fields for endpoint (`default = []`)
- `enable_sagemaker_endpoint` - Enable sagemaker endpoint usage (`default = False`)
- `sagemaker_endpoint_name` - The name of the endpoint. If omitted, Terraform will assign a random, unique name. (`default = null`)
- `sagemaker_endpoint_endpoint_config_name` - The name of the endpoint configuration to use. (`default = ""`)
- `enable_sagemaker_notebook_instance_lifecycle_configuration` - Enable sagemaker notebook instance lifecycle configuration usage (`default = False`)
- `sagemaker_notebook_instance_lifecycle_configuration_name` - The name of the lifecycle configuration (must be unique). If omitted, Terraform will assign a random, unique name. (`default = null`)
- `sagemaker_notebook_instance_lifecycle_configuration_on_create` - (Optional) A shell script (base64-encoded) that runs only once when the SageMaker Notebook Instance is created. (`default = null`)
- `sagemaker_notebook_instance_lifecycle_configuration_on_start` - (Optional) A shell script (base64-encoded) that runs every time the SageMaker Notebook Instance is started including the time it's created. (`default = null`)
- `enable_sagemaker_notebook_instance` - Enable sagemaker notebook instance usage (`default = False`)
- `sagemaker_notebook_instance_name` - The name of the notebook instance (must be unique). (`default = ""`)
- `sagemaker_notebook_instance_role_arn` - (Required) The ARN of the IAM role to be used by the notebook instance which allows SageMaker to call other services on your behalf. (`default = null`)
- `sagemaker_notebook_instance_instance_type` - (Required) The name of ML compute instance type. (`default = ml.t2.medium`)
- `sagemaker_notebook_instance_platform_identifier` - (Optional) The platform identifier of the notebook instance runtime environment. This value can be either notebook-al1-v1, notebook-al2-v1, or notebook-al2-v2, depending on which version of Amazon Linux you require. (`default = null`)
- `sagemaker_notebook_instance_volume_size` - (Optional) The size, in GB, of the ML storage volume to attach to the notebook instance. The default value is 5 GB. (`default = null`)
- `sagemaker_notebook_instance_subnet_id` - (Optional) The VPC subnet ID. (`default = null`)
- `sagemaker_notebook_instance_security_groups` - (Optional) The associated security groups. (`default = null`)
- `sagemaker_notebook_instance_kms_key_id` - (Optional) The AWS Key Management Service (AWS KMS) key that Amazon SageMaker uses to encrypt the model artifacts at rest using Amazon S3 server-side encryption. (`default = null`)
- `sagemaker_notebook_instance_lifecycle_config_name` - (Optional) The name of a lifecycle configuration to associate with the notebook instance. (`default = null`)
- `sagemaker_notebook_instance_direct_internet_access` - (Optional) Set to Disabled to disable internet access to notebook. Requires security_groups and subnet_id to be set. Supported values: Enabled (Default) or Disabled. If set to Disabled, the notebook instance will be able to access resources only in your VPC, and will not be able to connect to Amazon SageMaker training and endpoint services unless your configure a NAT Gateway in your VPC. (`default = null`)
- `enable_sagemaker_user_profile` - Enable sagemaker user profile usage (`default = False`)
- `sagemaker_user_profile_name` - The name for the User Profile. (`default = ""`)
- `sagemaker_user_profile_domain_id` - The ID of the associated Domain. (`default = ""`)
- `sagemaker_user_profile_single_sign_on_user_value` - (Required) The username of the associated AWS Single Sign-On User for this User Profile. If the Domain's AuthMode is SSO, this field is required, and must match a valid username of a user in your directory. If the Domain's AuthMode is not SSO, this field cannot be specified. (`default = null`)
- `sagemaker_user_profile_single_sign_on_user_identifier` - (Optional) A specifier for the type of value specified in single_sign_on_user_value. Currently, the only supported value is UserName. If the Domain's AuthMode is SSO, this field is required. If the Domain's AuthMode is not SSO, this field cannot be specified. (`default = null`)
- `sagemaker_user_profile_user_settings` - AAA (`default = {'execution_role': None, 'security_groups': None}`)
- `enable_sagemaker_domain` - Enable sagemaker domain usage (`default = False`)
- `sagemaker_domain_name` - The domain name. (`default = ""`)
- `sagemaker_domain_auth_mode` - (Required) The mode of authentication that members use to access the domain. Valid values are IAM and SSO (`default = null`)
- `sagemaker_domain_vpc_id` - (Required) The ID of the Amazon Virtual Private Cloud (VPC) that Studio uses for communication. (`default = null`)
- `sagemaker_domain_subnet_ids` - (Required) The VPC subnets that Studio uses for communication. (`default = null`)
- `sagemaker_domain_kms_key_id` - (Optional) The AWS KMS customer managed CMK used to encrypt the EFS volume attached to the domain. (`default = null`)
- `sagemaker_domain_app_network_access_type` - (Optional) Specifies the VPC used for non-EFS traffic. The default value is PublicInternetOnly. Valid values are PublicInternetOnly and VpcOnly. (`default = null`)
- `sagemaker_domain_default_user_settings` - (Required) The default user settings. (`default = {'execution_role': None, 'security_groups': None}`)
- `enable_sagemaker_model_package_group` - Enable sagemaker model package group usage (`default = False`)
- `sagemaker_model_package_group_name` - The name of the model group. (`default = ""`)
- `sagemaker_model_package_group_description` - AAA (`default = null`)
- `enable_sagemaker_image` - Enable sagemaker image usage (`default = False`)
- `sagemaker_image_name` - The name of the image. Must be unique to your account. (`default = ""`)
- `sagemaker_image_role_arn` - (Required) The Amazon Resource Name (ARN) of an IAM role that enables Amazon SageMaker to perform tasks on your behalf. (`default = null`)
- `sagemaker_image_display_name` - (Optional) The display name of the image. When the image is added to a domain (must be unique to the domain). (`default = null`)
- `sagemaker_image_description` - (Optional) The description of the image. (`default = null`)
- `enable_sagemaker_image_version` - Enable sagemaker image version usage (`default = False`)
- `sagemaker_image_version_image_name` - The name of the image. Must be unique to your account. (`default = ""`)
- `sagemaker_image_version_base_image` - (Required) The registry path of the container image on which this image version is based. (`default = null`)
- `enable_sagemaker_feature_group` - Enable sagemaker feature group usage (`default = False`)
- `sagemaker_feature_group_name` - The name of the Feature Group. The name must be unique within an AWS Region in an AWS account. (`default = ""`)
- `sagemaker_feature_group_record_identifier_feature_name` - The name of the Feature whose value uniquely identifies a Record defined in the Feature Store. Only the latest record per identifier value will be stored in the Online Store. (`default = ""`)
- `sagemaker_feature_group_event_time_feature_name` - The name of the feature that stores the EventTime of a Record in a Feature Group. (`default = ""`)
- `sagemaker_feature_group_role_arn` - (Required) - The Amazon Resource Name (ARN) of the IAM execution role used to persist data into the Offline Store if an offline_store_config is provided. (`default = null`)
- `sagemaker_feature_group_description` - (Optional) - A free-form description of a Feature Group. (`default = null`)
- `sagemaker_feature_group_feature_definition` - (Optional) - A list of Feature names and types. (`default = []`)
- `sagemaker_feature_group_offline_store_config` - (Optional) - The Offline Feature Store Configuration. (`default = []`)
- `sagemaker_feature_group_online_store_config` - (Optional) - The Online Feature Store Configuration. (`default = []`)
- `enable_sagemaker_code_repository` - Enable sagemaker code repository usage (`default = False`)
- `sagemaker_code_repository_name` - The name of the Code Repository (must be unique). (`default = ""`)
- `sagemaker_code_repository_git_config` - (Required) Specifies details about the repository. (`default = []`)
- `enable_sagemaker_app` - Enable sagemaker app usage (`default = False`)
- `sagemaker_app_name` - The name of the app. (`default = ""`)
- `sagemaker_app_type` - (Required) The type of app. Valid values are JupyterServer, KernelGateway and TensorBoard (`default = null`)
- `sagemaker_app_domain_id` - The domain ID. (`default = ""`)
- `sagemaker_app_user_profile_name` - The user profile name. (`default = null`)
- `sagemaker_app_resource_spec` - (Optional) The instance type and the Amazon Resource Name (ARN) of the SageMaker image created on the instance (`default = []`)
- `enable_sagemaker_app_image_config` - Enable sagemaker app image config usage (`default = False`)
- `sagemaker_app_image_config_name` - The name of the App Image Config. (`default = ""`)
- `sagemaker_app_image_config_kernel_gateway_image_config` - (Optional) The configuration for the file system and kernels in a SageMaker image running as a KernelGateway app. (`default = []`)
- `enable_sagemaker_device_fleet` - Enable sagemaker device fleet usage (`default = False`)
- `sagemaker_device_fleet_name` - Set name for sagemaker device fleet (`default = ""`)
- `sagemaker_device_fleet_role_arn` - (Required) The Amazon Resource Name (ARN) that has access to AWS Internet of Things (IoT). (`default = null`)
- `sagemaker_device_fleet_description` - (Optional) A description of the fleet. (`default = null`)
- `sagemaker_device_fleet_enable_iot_role_alias` - (Optional) Whether to create an AWS IoT Role Alias during device fleet creation. The name of the role alias generated will match this pattern: 'SageMakerEdge-{DeviceFleetName}'. (`default = null`)
- `sagemaker_device_fleet_output_config` - (Required) Specifies details about the repository. (`default = []`)
- `enable_sagemaker_device` - Enable sagemaker device usage (`default = False`)
- `sagemaker_device_device_fleet_name` - The name of the Device. (`default = ""`)
- `sagemaker_device_devices` - (Required) The list of devices to register with SageMaker Edge Manager. (`default = []`)
- `enable_sagemaker_model_package_group_policy` - Enable sagemaker model package group policy usage (`default = False`)
- `sagemaker_model_package_group_policy_model_package_group_name` - The name of the model package group. (`default = ""`)
- `sagemaker_model_package_group_policy_resource_policy` - The resource policy for the model package group. (`default = null`)
- `enable_sagemaker_project` - Enable sagemaker project usage (`default = False`)
- `sagemaker_project_name` - The name of the Project. (`default = ""`)
- `sagemaker_project_project_description` - (Optional) A description for the project. (`default = null`)
- `sagemaker_project_service_catalog_provisioning_details` - (Required) The product ID and provisioning artifact ID to provision a service catalog (`default = []`)
- `enable_sagemaker_workteam` - Enable sagemaker workteam usage (`default = False`)
- `sagemaker_workteam_name` - The name of the workforce. (`default = ""`)
- `sagemaker_workteam_workforce_name` - The name of the Workteam (must be unique). (`default = ""`)
- `sagemaker_workteam_description` - (Required) A description of the work team. (`default = null`)
- `sagemaker_workteam_member_definition` - (Required) A list of Member Definitions that contains objects that identify the workers that make up the work team. Workforces can be created using Amazon Cognito or your own OIDC Identity Provider (IdP). For private workforces created using Amazon Cognito use cognito_member_definition. For workforces created using your own OIDC identity provider (IdP) use oidc_member_definition. Do not provide input for both of these parameters in a single request. (`default = []`)
- `sagemaker_workteam_notification_configuration` - (Optional) Configures notification of workers regarding available or expiring work items. (`default = []`)
- `enable_sagemaker_workforce` - Enable sagemaker workforce usage (`default = False`)
- `sagemaker_workforce_name` - The name of the Workforce (must be unique). (`default = ""`)
- `sagemaker_workforce_cognito_config` - (Required) Use this parameter to configure an Amazon Cognito private workforce. A single Cognito workforce is created using and corresponds to a single Amazon Cognito user pool. Conflicts with oidc_config (`default = []`)
- `sagemaker_workforce_oidc_config` - (Required) Use this parameter to configure a private workforce using your own OIDC Identity Provider. Conflicts with cognito_config (`default = []`)
- `sagemaker_workforce_source_ip_config` - (Required) A list of IP address ranges Used to create an allow list of IP addresses for a private workforce. By default, a workforce isn't restricted to specific IP addresses.  (`default = []`)
- `enable_sagemaker_studio_lifecycle_config` - Enable sagemaker studio lifecycle config usage (`default = False`)
- `sagemaker_studio_lifecycle_config_name` - The name of the Studio Lifecycle Configuration to create. (`default = ""`)
- `sagemaker_studio_lifecycle_config_app_type` - (Required) The App type that the Lifecycle Configuration is attached to. Valid values are JupyterServer and KernelGateway. (`default = null`)
- `sagemaker_studio_lifecycle_config_content` - (Required) The content of your Studio Lifecycle Configuration script. This content must be base64 encoded. (`default = null`)
- `enable_sagemaker_flow_definition` - Enable sagemaker flow definition usage (`default = False`)
- `sagemaker_flow_definition_flow_definition_name` - The name of your flow definition. (`default = ""`)
- `sagemaker_flow_definition_role_arn` - (Required) The Amazon Resource Name (ARN) of the role needed to call other services on your behalf. (`default = null`)
- `sagemaker_flow_definition_human_loop_config` - (Required) An object containing information about the tasks the human reviewers will perform (`default = []`)
- `sagemaker_project_output_config` - (Required) An object containing information about where the human review results will be uploaded. (`default = []`)
- `sagemaker_flow_definition_human_loop_activation_config` - (Optional) An object containing information about the events that trigger a human workflow (`default = []`)
- `sagemaker_flow_definition_human_loop_request_source` - (Optional) Container for configuring the source of human task requests. Use to specify if Amazon Rekognition or Amazon Textract is used as an integration source. (`default = []`)
- `enable_sagemaker_human_task_ui` - Enable sagemaker human task ui usage (`default = False`)
- `sagemaker_human_task_ui_name` - The name of the Human Task UI. (`default = ""`)
- `sagemaker_human_task_ui_template` - (Required) The Liquid template for the worker user interface. (`default = []`)

## Module Output Variables
----------------------
- `sagemaker_model_id` - The ID of sagemaker model
- `sagemaker_model_name` - The name of the model.
- `sagemaker_model_arn` - The Amazon Resource Name (ARN) assigned by AWS to this model.
- `sagemaker_endpoint_configuration_id` - The ID of sagemaker endpoint configuration
- `sagemaker_endpoint_configuration_arn` - The Amazon Resource Name (ARN) assigned by AWS to this endpoint configuration.
- `sagemaker_endpoint_configuration_name` - The name of the endpoint configuration.
- `sagemaker_endpoint_id` - The ID of sagemaker endpoint
- `sagemaker_endpoint_arn` - The Amazon Resource Name (ARN) assigned by AWS to this endpoint.
- `sagemaker_endpoint_name` - The name of the endpoint.
- `sagemaker_notebook_instance_lifecycle_configuration_id` - The ID of notebook instance lifecycle configuration
- `sagemaker_notebook_instance_lifecycle_configuration_arn` - The Amazon Resource Name (ARN) assigned by AWS to this lifecycle configuration.
- `sagemaker_notebook_instance_id` - The name of the notebook instance.
- `sagemaker_notebook_instance_arn` - The Amazon Resource Name (ARN) assigned by AWS to this notebook instance.
- `sagemaker_user_profile_id` - The user profile Amazon Resource Name (ARN).
- `sagemaker_user_profile_arn` - The user profile Amazon Resource Name (ARN).
- `sagemaker_user_profile_home_efs_file_system_uid` - The ID of the user's profile in the Amazon Elastic File System (EFS) volume.
- `sagemaker_domain_id` - The ID of the Domain.
- `sagemaker_domain_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Domain.
- `sagemaker_domain_url` - The domain's URL.
- `sagemaker_domain_single_sign_on_managed_application_instance_id` - The SSO managed application instance ID.
- `sagemaker_domain_home_efs_file_system_id` - The ID of the Amazon Elastic File System (EFS) managed by this Domain.
- `sagemaker_model_package_group_id` - The name of the Model Package Group.
- `sagemaker_model_package_group_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Model Package Group.
- `sagemaker_model_package_group_model_package_group_name` - The name of Model Package Group.
- `sagemaker_image_id` - The name of the Image.
- `sagemaker_image_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Image.
- `sagemaker_image_version_id` - The name of the Image version.
- `sagemaker_image_version_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Image version.
- `sagemaker_feature_group_id` - The name of the feature group.
- `sagemaker_feature_group_arn` - The Amazon Resource Name (ARN) assigned by AWS to this feature_group.
- `sagemaker_feature_group_name` - The name of the Feature Group.
- `sagemaker_code_repository_id` - The name of the Code Repository.
- `sagemaker_code_repository_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Code Repository.
- `sagemaker_app_id` - The Amazon Resource Name (ARN) of the app.
- `sagemaker_app_arn` - The Amazon Resource Name (ARN) of the app.
- `sagemaker_app_image_config_id` - The name of the app image config.
- `sagemaker_app_image_config_arn` - The Amazon Resource Name (ARN) assigned by AWS to this App Image Config.
- `sagemaker_device_fleet_id` - The name of the Device Fleet.
- `sagemaker_device_fleet_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Device Fleet.
- `sagemaker_device_fleet_device_fleet_name` - The Name assigned by AWS to this Device Fleet.
- `sagemaker_device_id` - The name of the Device.
- `sagemaker_device_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Device.
- `sagemaker_model_package_group_policy_id` - The name of the Model Package Package Group.
- `sagemaker_project_id` - The name of the Project.
- `sagemaker_project_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Project.
- `sagemaker_project_project_id` - The ID of the project.
- `sagemaker_workteam_id` - The name of the Workteam.
- `sagemaker_workteam_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Workteam.
- `sagemaker_workteam_subdomain` - The subdomain for your OIDC Identity Provider.
- `sagemaker_workforce_id` - The name of the Workforce.
- `sagemaker_workforce_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Workforce.
- `sagemaker_workforce_subdomain` - The subdomain for your OIDC Identity Provider.
- `sagemaker_studio_lifecycle_config_id` - The name of the Studio Lifecycle Config.
- `sagemaker_studio_lifecycle_config_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Studio Lifecycle Config.
- `sagemaker_flow_definition_id` - The name of the Flow Definition.
- `sagemaker_flow_definition_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Flow Definition.
- `sagemaker_human_task_ui_id` - The name of the Human Task UI.
- `sagemaker_human_task_ui_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Human Task UI.
- `sagemaker_human_task_ui_template` - The Liquid template for the worker user interface


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
