# Work with SECRETSMANAGER via terraform

A terraform module for making SECRETSMANAGER.


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

module "secretsmanager" {
  source = "../../modules/secretsmanager"

  # AWS secretsmanager secret
  enable_secretsmanager_secret      = true
  secretsmanager_secret_name        = "test-secretmanager-secret"
  secretsmanager_secret_description = "Managing by Terrafrom"
  secretsmanager_secret_rotation_rules = [{
    automatically_after_days = 7
  }]

  # AWS secretsmanager secret version
  enable_secretsmanager_secret_version = true
  secretsmanager_secret_version_secret_string = jsonencode(
    {
      key1  = "value1"
      key2  = "value2"
      test  = "test"
      test2 = "test2"
    }
  )

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_secretsmanager_secret` - Enable secretsmanager secret usage (`default = False`)
- `secretsmanager_secret_name` - (Optional) Specifies the friendly name of the new secret. The secret name can consist of uppercase letters, lowercase letters, digits, and any of the following characters: /_+=.@- Conflicts with secretsmanager_secret_name_prefix. (`default = null`)
- `secretsmanager_secret_name_prefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with secretsmanager_secret_name. (`default = null`)
- `secretsmanager_secret_description` - (Optional) A description of the secret. (`default = null`)
- `secretsmanager_secret_kms_key_id` - (Optional) Specifies the ARN or alias of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret. If you don't specify this value, then Secrets Manager defaults to using the AWS account's default CMK (the one named aws/secretsmanager). If the default KMS CMK with that name doesn't yet exist, then AWS Secrets Manager creates it for you automatically the first time. (`default = null`)
- `secretsmanager_secret_policy` - (Optional) A valid JSON document representing a resource policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. (`default = null`)
- `secretsmanager_secret_recovery_window_in_days` - (Optional) Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 30. (`default = 30`)
- `secretsmanager_secret_rotation_lambda_arn` - description (`default = null`)
- `secretsmanager_secret_rotation_rules` - (Optional) A structure that defines the rotation configuration for this secret. (`default = []`)
- `enable_secretsmanager_secret_version` - Enable secretsmanager secret version usage (`default = False`)
- `secretsmanager_secret_version_secret_id` - Specifies the secret to which you want to add a new version. You can specify either the Amazon Resource Name (ARN) or the friendly name of the secret. The secret must already exist. (`default = ""`)
- `secretsmanager_secret_version_secret_string` - (Optional) Specifies text data that you want to encrypt and store in this version of the secret. This is required if secret_binary is not set. (`default = null`)
- `secretsmanager_secret_version_secret_binary` - (Optional) Specifies binary data that you want to encrypt and store in this version of the secret. This is required if secret_string is not set. Needs to be encoded to base64. (`default = null`)
- `secretsmanager_secret_version_version_stages` - (Optional) Specifies a list of staging labels that are attached to this version of the secret. A staging label must be unique to a single version of the secret. If you specify a staging label that's already associated with a different version of the same secret then that staging label is automatically removed from the other version and attached to this version. If you do not specify a value, then AWS Secrets Manager automatically moves the staging label AWSCURRENT to this new version on creation. (`default = null`)
- `enable_secretsmanager_secret_rotation` - Enable secretsmanager secret rotation usage (`default = False`)
- `secretsmanager_secret_rotation_secret_id` - Specifies the secret to which you want to add a new version. You can specify either the Amazon Resource Name (ARN) or the friendly name of the secret. The secret must already exist. (`default = ""`)
- `secretsmanager_secret_rotation_rotation_lambda_arn` - (Required) Specifies the ARN of the Lambda function that can rotate the secret. (`default = null`)
- `secretsmanager_secret_rotation_rotation_rules` - (Required) A structure that defines the rotation configuration for this secret. (`default = []`)
- `enable_secretsmanager_secret_policy` - Enable secretsmanager secret policy usage (`default = False`)
- `secretsmanager_secret_policy_secret_arn` - Secret ARN. (`default = ""`)
- `secretsmanager_secret_policy_policy` - (Required) A valid JSON document representing a resource policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. (`default = null`)
- `secretsmanager_secret_policy_block_public_policy` - (Optional) Makes an optional API call to Zelkova to validate the Resource Policy to prevent broad access to your secret. (`default = null`)

## Module Output Variables
----------------------
- `secretsmanager_secret_id` - Amazon Resource Name (ID) of the secret.
- `secretsmanager_secret_arn` - Amazon Resource Name (ARN) of the secret.
- `secretsmanager_secret_rotation_enabled` - Specifies whether automatic rotation is enabled for this secret.
- `secretsmanager_secret_version_id` - A pipe delimited combination of secret ID and version ID.
- `secretsmanager_secret_version_arn` - The ARN of the secret.
- `secretsmanager_secret_version_version_id` - The unique identifier of the version of the secret.
- `secretsmanager_secret_version_secret_string` - Get secret string
- `secretsmanager_secret_rotation_id` - Amazon Resource Name (ARN) of the secret.
- `secretsmanager_secret_rotation_arn` - Amazon Resource Name (ARN) of the secret.
- `secretsmanager_secret_rotation_rotation_enabled` - Specifies whether automatic rotation is enabled for this secret.
- `secretsmanager_secret_policy_id` - Amazon Resource Name (ARN) of the secret.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
