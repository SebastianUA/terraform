# Work with KMS via terraform

A terraform module for making KMS.


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
  region = "us-east-1"
  # alias                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "iam_role" {
  source      = "../../modules/iam_role"
  name        = "TEST-role"
  environment = "stage"

  # Using IAM role
  enable_iam_role = true
  iam_role_name   = "kms-role-for-lambda"

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy
  enable_iam_role_policy = true
  iam_role_policy_name   = "my-iam-role-policy-for-testing-terraform"
  iam_role_policy        = file("additional_files/policies/kms_policy.json")

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}


data "template_file" "kms_key_policy" {
  template = file("additional_files/policies/kms_key_policy.json.tpl")
}

module "kms" {
  source = "../../modules/kms"

  name        = "tmp"
  environment = "dev"

  # KMS key
  enable_kms_key                  = true
  kms_key_name                    = ""
  kms_key_deletion_window_in_days = 30
  kms_key_policy                  = data.template_file.kms_key_policy.rendered

  # KMS alias
  enable_kms_alias = true
  kms_alias_name   = "alias/ec2-my-key"

  # KSM grant
  enable_kms_grant            = true
  kms_grant_name              = ""
  kms_grant_grantee_principal = module.iam_role.iam_role_arn
  kms_grant_operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]

  # KMS external key
  enable_kms_external_key      = true
  kms_external_key_name        = ""
  kms_external_key_description = "Some external KMS key"

  # KMS ciphertext
  enable_kms_ciphertext    = true
  kms_ciphertext_plaintext = <<EOF
{
  "client_id": "e587dbae22222f55da22",
  "client_secret": "8289575d00000ace55e1815ec13673955721b8a5"
}
EOF

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
- `tags` - A list of tag blocks. (`default = {}`)
- `enable_kms_key` - Allow to create kms_key (`default = False`)
- `kms_key_name` - Name for KMS (`default = ""`)
- `kms_key_deletion_window_in_days` - Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days. (`default = null`)
- `kms_key_description` - The description of the key as viewed in AWS console. (`default = This key is used to encrypt <___> AWS service`)
- `kms_key_key_usage` - Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and only symmetric encryption and decryption are supported (`default = ENCRYPT_DECRYPT`)
- `kms_key_is_enabled` - Specifies whether the key is enabled. Defaults to true. (`default = True`)
- `kms_key_enable_key_rotation` - Specifies whether key rotation is enabled. Defaults to false. (`default = False`)
- `kms_key_policy` - Set policy (`default = ""`)
- `kms_key_customer_master_key_spec` - (Optional) Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1. Defaults to SYMMETRIC_DEFAULT. For help with choosing a key spec, see the AWS KMS Developer Guide. (`default = null`)
- `enable_kms_alias` - Allow to create kms_alias (`default = False`)
- `kms_alias_name` - (Optional) The display name of the alias. The name must start with the word 'alias' followed by a forward slash (alias/) (`default = null`)
- `kms_alias_name_prefix` - (Optional) Creates an unique alias beginning with the specified prefix. The name must start with the word 'alias' followed by a forward slash (alias/). Conflicts with name. (`default = null`)
- `kms_alias_target_key_id` - (Required) Identifier for the key for which the alias is for, can be either an ARN or key_id. (`default = ""`)
- `enable_kms_grant` - Enable kms grant usage (`default = False`)
- `kms_grant_name` - (Optional, Forces new resources) A friendly name for identifying the grant. (`default = ""`)
- `kms_grant_key_id` - The unique identifier for the customer master key (CMK) that the grant applies to. Specify the key ID or the Amazon Resource Name (ARN) of the CMK. To specify a CMK in a different AWS account, you must use the key ARN. (`default = ""`)
- `kms_grant_grantee_principal` - (Required, Forces new resources) The principal that is given permission to perform the operations that the grant permits in ARN format. Note that due to eventual consistency issues around IAM principals, terraform's state may not always be refreshed to reflect what is true in AWS. (`default = null`)
- `kms_grant_operations` - (Required, Forces new resources) A list of operations that the grant permits. The permitted values are: Decrypt, Encrypt, GenerateDataKey, GenerateDataKeyWithoutPlaintext, ReEncryptFrom, ReEncryptTo, CreateGrant, RetireGrant, DescribeKey (`default = []`)
- `kms_grant_retiring_principal` - (Optional, Forces new resources) The principal that is given permission to retire the grant by using RetireGrant operation in ARN format. Note that due to eventual consistency issues around IAM principals, terraform's state may not always be refreshed to reflect what is true in AWS. (`default = null`)
- `kms_grant_grant_creation_tokens` - (Optional, Forces new resources) A list of grant tokens to be used when creating the grant. See Grant Tokens for more information about grant tokens. (`default = null`)
- `kms_grant_retire_on_delete` - (Defaults to false, Forces new resources) If set to false (the default) the grants will be revoked upon deletion, and if set to true the grants will try to be retired upon deletion. Note that retiring grants requires special permissions, hence why we default to revoking grants. See RetireGrant for more information. (`default = null`)
- `kms_grant_constraints` - (Optional, Forces new resources) A structure that you can use to allow certain operations in the grant only when the desired encryption context is present. For more information about encryption context, see Encryption Context. (`default = []`)
- `enable_kms_external_key` - Enable kms external key usage (`default = False`)
- `kms_external_key_name` - Set name for external key (`default = ""`)
- `kms_external_key_description` - (Optional) Description of the key. (`default = null`)
- `kms_external_key_deletion_window_in_days` - (Optional) Duration in days after which the key is deleted after destruction of the resource. Must be between 7 and 30 days. Defaults to 30. (`default = null`)
- `kms_external_key_enabled` - (Optional) Specifies whether the key is enabled. Keys pending import can only be false. Imported keys default to true unless expired. (`default = null`)
- `kms_external_key_key_material_base64` - (Optional) Base64 encoded 256-bit symmetric encryption key material to import. The CMK is permanently associated with this key material. The same key material can be reimported, but you cannot import different key material. (`default = null`)
- `kms_external_key_policy` - (Optional) A key policy JSON document. If you do not provide a key policy, AWS KMS attaches a default key policy to the CMK. (`default = null`)
- `kms_external_key_valid_to` - (Optional) Time at which the imported key material expires. When the key material expires, AWS KMS deletes the key material and the CMK becomes unusable. If not specified, key material does not expire. Valid values: RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ) (`default = null`)
- `enable_kms_ciphertext` - Enable kms ciphertext usage (`default = False`)
- `kms_ciphertext_key_id` - Globally unique key ID for the customer master key. (`default = ""`)
- `kms_ciphertext_plaintext` - (Required) Data to be encrypted. Note that this may show up in logs, and it will be stored in the state file. (`default = null`)
- `kms_ciphertext_context` - (Optional) An optional mapping that makes up the encryption context. (`default = null`)

## Module Output Variables
----------------------
- `kms_key_arn` - The globally unique identifier for the key.
- `kms_key_id` - The globally unique identifier for the key.
- `kms_alias_id` - ID of KMS alias
- `kms_alias_arn` - The Amazon Resource Name (ARN) of the key alias.
- `kms_alias_target_key_arn` - The Amazon Resource Name (ARN) of the target key identifier.
- `kms_grant_id` - ID of KMS grant
- `kms_grant_grant_id` - The unique identifier for the grant.
- `kms_grant_token` - The grant token for the created grant. For more information, see Grant Tokens.
- `kms_external_key_id` - The unique identifier for the key.
- `kms_external_key_arn` - The Amazon Resource Name (ARN) of the key.
- `kms_external_key_expiration_model` - Whether the key material expires. Empty when pending key material import, otherwise KEY_MATERIAL_EXPIRES or KEY_MATERIAL_DOES_NOT_EXPIRE.
- `kms_external_key_state` - The state of the CMK.
- `kms_external_key_usage` - The cryptographic operations for which you can use the CMK.
- `kms_ciphertext_id` - The unique identifier for the ciphertext.
- `kms_ciphertext_ciphertext_blob` - Base64 encoded ciphertext


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
