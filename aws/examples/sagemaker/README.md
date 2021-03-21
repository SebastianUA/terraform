# Work with AWS SAGEMAKER via terraform

A terraform module for making SAGEMAKER.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "sagemaker" {
  source      = "../../modules/sagemaker"
  name        = "TEST"
  environment = "stage"

  # Sagemaker model
  enable_sagemaker_model             = true
  sagemaker_model_name               = ""
  sagemaker_model_execution_role_arn = "arn:aws:iam::167127734783:role/admin-role"

  sagemaker_model_primary_container = [{
    image = "167127734783.dkr.ecr.us-east-1.amazonaws.com/sagemaker-sparkml-serving"
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
  sagemaker_notebook_instance_role_arn      = "arn:aws:iam::167127734783:role/admin-role"
  sagemaker_notebook_instance_instance_type = "ml.t2.medium"

  sagemaker_notebook_instance_subnet_id              = null
  sagemaker_notebook_instance_security_groups        = null
  sagemaker_notebook_instance_kms_key_id             = null
  sagemaker_notebook_instance_direct_internet_access = null

  tags = map("Env", "dev", "Orchestration", "Terraform", "Createdby", "Vitalii Natarov")
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
- `sagemaker_user_profile_sharing_settings` - (Optional) The sharing settings. (`default = []`)
- `sagemaker_user_profile_tensor_board_app_settings` - (Optional) The TensorBoard app settings. (`default = []`)
- `sagemaker_user_profile_jupyter_server_app_settings` - (Optional) The Jupyter server's app settings. (`default = []`)
- `sagemaker_user_profile_kernel_gateway_app_settings` - (Optional) The kernel gateway app settings. (`default = []`)
- `enable_sagemaker_domain` - Enable sagemaker domain usage (`default = False`)
- `sagemaker_domain_name` - The domain name. (`default = ""`)
- `sagemaker_domain_auth_mode` - (Required) The mode of authentication that members use to access the domain. Valid values are IAM and SSO (`default = null`)
- `sagemaker_domain_vpc_id` - (Required) The ID of the Amazon Virtual Private Cloud (VPC) that Studio uses for communication. (`default = null`)
- `sagemaker_domain_subnet_ids` - (Required) The VPC subnets that Studio uses for communication. (`default = null`)
- `sagemaker_domain_kms_key_id` - (Optional) The AWS KMS customer managed CMK used to encrypt the EFS volume attached to the domain. (`default = null`)
- `sagemaker_domain_app_network_access_type` - (Optional) Specifies the VPC used for non-EFS traffic. The default value is PublicInternetOnly. Valid values are PublicInternetOnly and VpcOnly. (`default = null`)
- `sagemaker_domain_default_user_settings` - (Required) The default user settings. (`default = {'execution_role': None, 'security_groups': None}`)
- `sagemaker_domain_sharing_settings` - (Optional) The sharing settings.  (`default = []`)
- `sagemaker_domain_tensor_board_app_settings` - (Optional) The TensorBoard app settings. (`default = []`)
- `sagemaker_domain_jupyter_server_app_settings` - (Optional) The Jupyter server's app settings. (`default = []`)
- `sagemaker_domain_kernel_gateway_app_settings` - (Optional) The kernel gateway app settings. (`default = []`)
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
- `sagemaker_feature_group_s3_storage_config` - (Required) The Amazon Simple Storage (Amazon S3) location of OfflineStore. (`default = []`)
- `sagemaker_feature_group_data_catalog_config` - (Optional) The meta data of the Glue table that is autogenerated when an OfflineStore is created. (`default = []`)
- `sagemaker_feature_group_security_config` - (Required) Security config for at-rest encryption of your OnlineStore. (`default = []`)
- `enable_sagemaker_code_repository` - Enable sagemaker code repository usage (`default = False`)
- `sagemaker_code_repository_name` - The name of the Code Repository (must be unique). (`default = ""`)
- `sagemaker_code_repository_git_config` - (Required) Specifies details about the repository. (`default = []`)
- `enable_sagemaker_app_image_config` - Enable sagemaker app image config usage (`default = False`)
- `sagemaker_app_image_config_name` - The name of the App Image Config. (`default = ""`)
- `sagemaker_app_image_config_kernel_spec` - (Required) The default branch for the Git repository. (`default = []`)
- `sagemaker_app_image_config_file_system_config` - (Optional) The URL where the Git repository is located. (`default = []`)

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
- `sagemaker_image_id` - The name of the Image.
- `sagemaker_image_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Image.
- `sagemaker_image_version_id` - The name of the Image version.
- `sagemaker_image_version_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Image version.
- `sagemaker_feature_group_id` - The name of the feature group.
- `sagemaker_feature_group_arn` - The Amazon Resource Name (ARN) assigned by AWS to this feature_group.
- `sagemaker_feature_group_name` - The name of the Feature Group.
- `sagemaker_code_repository_id` - The name of the Code Repository.
- `sagemaker_code_repository_arn` - The Amazon Resource Name (ARN) assigned by AWS to this Code Repository.
- `sagemaker_app_image_config_id` - The name of the app image config.
- `sagemaker_app_image_config_arn` - The Amazon Resource Name (ARN) assigned by AWS to this App Image Config.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
