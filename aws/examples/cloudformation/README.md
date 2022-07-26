# Work with CLOUDFORMATION via terraform

A terraform module for making CLOUDFORMATION.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
}

#module "AWSCloudFormationStackSetExecutionRole" {
#    source                                          = "../../modules/iam_role"
#    name                                            = "TEST"
#    environment                                     = "stage"
#
#    # Using IAM role
#    enable_iam_role                                 = true
#    iam_role_name                                   = "AWSCloudFormationStackSetExecutionRole"
#    iam_role_description                            = "Role for cloudformation"
#    assume_role_policy                              = file("additional_files/AWSCloudFormationStackSetExecutionRole-assume_role_policy.json")
#
#    iam_role_force_detach_policies                  = true
#    iam_role_path                                   = "/"
#    iam_role_max_session_duration                   = 3600
#
#    # Using IAM role policy
#    enable_iam_role_policy                          = true
#    iam_role_policy_name                            = "AWSCloudFormationStackSetExecutionRole"
#    iam_role_policy                                 = file("additional_files/AWSCloudFormationStackSetExecutionRole-policy.json")
#
#    # Using IAM instance profile
#    enable_iam_instance_profile                     = true
#    iam_instance_profile_name                       = "AWSCloudFormationStackSetExecutionRole-instance-profile"
#}

module "iam_role" {
  source      = "../../modules/iam_role"
  name        = "TEST"
  environment = "stage"

  # Using IAM role
  enable_iam_role      = true
  iam_role_name        = "cloudformation-role"
  iam_role_description = "Role for cloudformation"
  assume_role_policy   = file("additional_files/assume_role_policy.json")

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy
  enable_iam_role_policy = true
  iam_role_policy_name   = "cloudformation-policy"
  iam_role_policy        = file("additional_files/policy.json")

  # Using IAM instance profile
  enable_iam_instance_profile = true
  iam_instance_profile_name   = "cloudformation-instance-profile"
}

module "cloudformation" {
  source      = "../../modules/cloudformation"
  name        = "TEST"
  environment = "stage"
  region      = "us-east-1"

  enable_cloudformation_stack        = true
  cloudformation_stack_name          = ""
  cloudformation_stack_template_body = file("additional_files/template_body.json")
  cloudformation_stack_parameters = merge(
    {
      VPCCidr = "10.0.0.0/16"
    },
  )


  enable_cloudformation_stack_set                  = true
  cloudformation_stack_set_name                    = ""
  cloudformation_stack_set_administration_role_arn = module.iam_role.iam_role_arn
  cloudformation_stack_set_template_body           = file("additional_files/template_body.json")
  cloudformation_stack_set_parameters = merge(
    {
      VPCCidr = "10.0.0.0/16"
    },
  )

  enable_cloudformation_stack_set_instance = true

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
- `tags` - Add additional tags (`default = {}`)
- `enable_cloudformation_stack` - Enable cloudformation stack usage (`default = False`)
- `cloudformation_stack_name` - Stack name. (`default = ""`)
- `cloudformation_stack_template_body` - (Optional) Structure containing the template body (max size: 51,200 bytes). (`default = null`)
- `cloudformation_stack_template_url` - (Optional) Location of a file containing the template body (max size: 460,800 bytes). (`default = null`)
- `cloudformation_stack_capabilities` - (Optional) A list of capabilities. Valid values: CAPABILITY_IAM, CAPABILITY_NAMED_IAM, or CAPABILITY_AUTO_EXPAND (`default = null`)
- `cloudformation_stack_disable_rollback` - (Optional) Set to true to disable rollback of the stack if stack creation failed. Conflicts with on_failure. (`default = null`)
- `cloudformation_stack_notification_arns` - (Optional) A list of SNS topic ARNs to publish stack related events. (`default = null`)
- `cloudformation_stack_on_failure` - (Optional) Action to be taken if stack creation fails. This must be one of: DO_NOTHING, ROLLBACK, or DELETE. Conflicts with disable_rollback. (`default = null`)
- `cloudformation_stack_policy_body` - (Optional) Structure containing the stack policy body. Conflicts w/ policy_url. (`default = null`)
- `cloudformation_stack_policy_url` - (Optional) Location of a file containing the stack policy. Conflicts w/ policy_body. (`default = null`)
- `cloudformation_stack_iam_role_arn` - (Optional) The ARN of an IAM role that AWS CloudFormation assumes to create the stack. If you don't specify a value, AWS CloudFormation uses the role that was previously associated with the stack. If no role is available, AWS CloudFormation uses a temporary session that is generated from your user credentials. (`default = null`)
- `cloudformation_stack_timeout_in_minutes` - (Optional) The amount of time that can pass before the stack status becomes CREATE_FAILED. (`default = null`)
- `cloudformation_stack_parameters` - (Optional) A map of Parameter structures that specify input parameters for the stack. (`default = null`)
- `enable_cloudformation_stack_set` - Enable cloudformation stack set usage (`default = False`)
- `cloudformation_stack_set_name` - Name of the Stack Set. The name must be unique in the region where you create your Stack Set. The name can contain only alphanumeric characters (case-sensitive) and hyphens. It must start with an alphabetic character and cannot be longer than 128 characters. (`default = ""`)
- `cloudformation_stack_set_administration_role_arn` - (Required) Amazon Resource Number (ARN) of the IAM Role in the administrator account. (`default = ""`)
- `cloudformation_stack_set_capabilities` - (Optional) A list of capabilities. Valid values: CAPABILITY_IAM, CAPABILITY_NAMED_IAM, CAPABILITY_AUTO_EXPAND. (`default = null`)
- `cloudformation_stack_set_description` - (Optional) Description of the Stack Set. (`default = null`)
- `cloudformation_stack_set_execution_role_name` - (Optional) Name of the IAM Role in all target accounts for Stack Set operations. Defaults to AWSCloudFormationStackSetExecutionRole. (`default = null`)
- `cloudformation_stack_set_parameters` - (Optional) Key-value map of input parameters for the Stack Set template. All template parameters, including those with a Default, must be configured or ignored with lifecycle configuration block ignore_changes argument. All NoEcho template parameters must be ignored with the lifecycle configuration block ignore_changes argument. (`default = null`)
- `cloudformation_stack_set_template_body` - (Optional) String containing the CloudFormation template body. Maximum size: 51,200 bytes. Conflicts with template_url. (`default = null`)
- `cloudformation_stack_set_template_url` - (Optional) String containing the location of a file containing the CloudFormation template body. The URL must point to a template that is located in an Amazon S3 bucket. Maximum location file size: 460,800 bytes. Conflicts with template_body. (`default = null`)
- `cloudformation_stack_set_timeouts` - Set timeouts for cloudformation stack set (`default = {}`)
- `enable_cloudformation_stack_set_instance` - Enable cloudformation stack set instance usage (`default = False`)
- `cloudformation_stack_set_instance_stack_set_name` - Name of the Stack Set. (`default = ""`)
- `cloudformation_stack_set_instance_account_id` - (Optional) Target AWS Account ID to create a Stack based on the Stack Set. Defaults to current account. (`default = null`)
- `cloudformation_stack_set_instance_parameter_overrides` - (Optional) Key-value map of input parameters to override from the Stack Set for this Instance. (`default = null`)
- `cloudformation_stack_set_instance_retain_stack` - (Optional) During Terraform resource destroy, remove Instance from Stack Set while keeping the Stack and its associated resources. Must be enabled in Terraform state before destroy operation to take effect. You cannot reassociate a retained Stack or add an existing, saved Stack to a new Stack Set. Defaults to false. (`default = False`)
- `cloudformation_stack_set_instance_timeouts` - Set timeouts for cloudformation stack set instance (`default = {}`)

## Module Output Variables
----------------------
- `cloudformation_stack_id` - A unique identifier of the stack.
- `cloudformation_stack_outputs` - A map of outputs from the stack.
- `cloudformation_stack_set_id` - Name of the Stack Set.
- `cloudformation_stack_set_arn` - Amazon Resource Name (ARN) of the Stack Set.
- `cloudformation_stack_set_stack_set_id` - Unique identifier of the Stack Set.
- `cloudformation_stack_set_instance_id` - Stack Set name, target AWS account ID, and target AWS region separated by commas (,)
- `cloudformation_stack_set_instance_stack_id` - Stack identifier


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
