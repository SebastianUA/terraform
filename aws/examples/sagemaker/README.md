# Work with AWS Sagemaker via terraform

A terraform module for making Sagemaker.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "sagemaker" {
    source                                                                      = "../../modules/sagemaker"
    name                                                                        = "TEST"
    environment                                                                 = "stage"

    # Sagemaker model
    enable_sagemaker_model                                                      = true
    sagemaker_model_name                                                        = ""
    sagemaker_model_execution_role_arn                                          = "arn:aws:iam::167127734783:role/admin-role"

    sagemaker_model_primary_container                                           = [{
        image   = "167127734783.dkr.ecr.us-east-1.amazonaws.com/sagemaker-sparkml-serving"
    }]
    sagemaker_model_container                                                   = []

    # Sagemaker endpoint config
    enable_sagemaker_endpoint_configuration                                     = true
    sagemaker_endpoint_configuration_name                                       = ""
    sagemaker_endpoint_configuration_production_variants                        = [{
        initial_instance_count      = 1
        instance_type               = "ml.t2.medium"
        variant_name                = "sage-endpoint-config-1"
    }]

    # Sagemaker endpoint
    enable_sagemaker_endpoint                                                   = true
    sagemaker_endpoint_name                                                     = ""

    # Sagemaker notebook instance lifecycle configuration
    enable_sagemaker_notebook_instance_lifecycle_configuration                  = true
    sagemaker_notebook_instance_lifecycle_configuration_name                    = ""
    sagemaker_notebook_instance_lifecycle_configuration_on_create               = null
    sagemaker_notebook_instance_lifecycle_configuration_on_start                = null

    # Sagemaker notebook instance
    enable_sagemaker_notebook_instance                                          = true
    sagemaker_notebook_instance_name                                            = ""
    sagemaker_notebook_instance_role_arn                                        = "arn:aws:iam::167127734783:role/admin-role"
    sagemaker_notebook_instance_instance_type                                   = "ml.t2.medium"

    sagemaker_notebook_instance_subnet_id                                       = null
    sagemaker_notebook_instance_security_groups                                 = null
    sagemaker_notebook_instance_kms_key_id                                      = null
    sagemaker_notebook_instance_direct_internet_access                          = null

    tags                                                                        = map("Env", "dev", "Orchestration", "Terraform", "Createdby", "Vitalii Natarov")
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = ""`)
- `enable_sagemaker_model` - Enable sagemaker model usage (`default = ""`)
- `sagemaker_model_name` - The name of the model (must be unique). If omitted, Terraform will assign a random, unique name. (`default = ""`)
- `sagemaker_model_execution_role_arn` - (Required) A role that SageMaker can assume to access model artifacts and docker images for deployment. (`default = ""`)
- `sagemaker_model_enable_network_isolation` - (Optional) - Isolates the model container. No inbound or outbound network calls can be made to or from the model container. (`default = ""`)
- `sagemaker_model_vpc_config` - (Optional) - Specifies the VPC that you want your model to connect to. VpcConfig is used in hosting services and in batch transform. (`default = ""`)
- `sagemaker_model_primary_container` - (Optional) The primary docker image containing inference code that is used when the model is deployed for predictions. If not specified, the container argument is required.  (`default = ""`)
- `sagemaker_model_container` - (Optional) - Specifies containers in the inference pipeline. If not specified, the primary_container argument is required. (`default = ""`)
- `enable_sagemaker_endpoint_configuration` - Enable sagemaker endpoint configuration usage (`default = ""`)
- `sagemaker_endpoint_configuration_name` - The name of the endpoint configuration. If omitted, Terraform will assign a random, unique name. (`default = ""`)
- `sagemaker_endpoint_configuration_kms_key_arn` - (Optional) Amazon Resource Name (ARN) of a AWS Key Management Service key that Amazon SageMaker uses to encrypt data on the storage volume attached to the ML compute instance that hosts the endpoint. (`default = ""`)
- `sagemaker_endpoint_configuration_production_variants` - (Required) Fields for endpoint (`default = ""`)
- `enable_sagemaker_endpoint` - Enable sagemaker endpoint usage (`default = ""`)
- `sagemaker_endpoint_name` - The name of the endpoint. If omitted, Terraform will assign a random, unique name. (`default = ""`)
- `sagemaker_endpoint_endpoint_config_name` - The name of the endpoint configuration to use. (`default = ""`)
- `enable_sagemaker_notebook_instance_lifecycle_configuration` - Enable sagemaker notebook instance lifecycle configuration usage (`default = ""`)
- `sagemaker_notebook_instance_lifecycle_configuration_name` - The name of the lifecycle configuration (must be unique). If omitted, Terraform will assign a random, unique name. (`default = ""`)
- `sagemaker_notebook_instance_lifecycle_configuration_on_create` - (Optional) A shell script (base64-encoded) that runs only once when the SageMaker Notebook Instance is created. (`default = ""`)
- `sagemaker_notebook_instance_lifecycle_configuration_on_start` - (Optional) A shell script (base64-encoded) that runs every time the SageMaker Notebook Instance is started including the time it's created. (`default = ""`)
- `enable_sagemaker_notebook_instance` - Enable sagemaker notebook instance usage (`default = ""`)
- `sagemaker_notebook_instance_name` - The name of the notebook instance (must be unique). (`default = ""`)
- `sagemaker_notebook_instance_role_arn` - (Required) The ARN of the IAM role to be used by the notebook instance which allows SageMaker to call other services on your behalf. (`default = ""`)
- `sagemaker_notebook_instance_instance_type` - (Required) The name of ML compute instance type. (`default = ml.t2.medium`)
- `sagemaker_notebook_instance_subnet_id` - (Optional) The VPC subnet ID. (`default = ""`)
- `sagemaker_notebook_instance_security_groups` - (Optional) The associated security groups. (`default = ""`)
- `sagemaker_notebook_instance_kms_key_id` - (Optional) The AWS Key Management Service (AWS KMS) key that Amazon SageMaker uses to encrypt the model artifacts at rest using Amazon S3 server-side encryption. (`default = ""`)
- `sagemaker_notebook_instance_lifecycle_config_name` - (Optional) The name of a lifecycle configuration to associate with the notebook instance. (`default = ""`)
- `sagemaker_notebook_instance_direct_internet_access` - (Optional) Set to Disabled to disable internet access to notebook. Requires security_groups and subnet_id to be set. Supported values: Enabled (Default) or Disabled. If set to Disabled, the notebook instance will be able to access resources only in your VPC, and will not be able to connect to Amazon SageMaker training and endpoint services unless your configure a NAT Gateway in your VPC. (`default = ""`)

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


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
