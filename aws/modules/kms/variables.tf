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
  description = "A list of tag blocks."
  type        = map(string)
  default     = {}
}

#-----------------------------------------------------------
# KMS key
#-----------------------------------------------------------
variable "enable_kms_key" {
  description = "Allow to create kms_key"
  default     = false
}

variable "kms_key_name" {
  description = "Name for KMS"
  default     = ""
}

variable "kms_key_deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days."
  default     = null
}

variable "kms_key_description" {
  description = "The description of the key as viewed in AWS console."
  default     = "This key is used to encrypt <___> AWS service"
}

variable "kms_key_key_usage" {
  description = "Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and only symmetric encryption and decryption are supported"
  default     = "ENCRYPT_DECRYPT"
}

variable "kms_key_is_enabled" {
  description = "Specifies whether the key is enabled. Defaults to true."
  default     = true
}

variable "kms_key_enable_key_rotation" {
  description = "Specifies whether key rotation is enabled. Defaults to false."
  default     = false
}

variable "kms_key_policy" {
  description = "Set policy"
  default     = ""
}

variable "kms_key_customer_master_key_spec" {
  description = "(Optional) Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1. Defaults to SYMMETRIC_DEFAULT. For help with choosing a key spec, see the AWS KMS Developer Guide."
  default     = null
}

#-----------------------------------------------------------
# KMS alias
#-----------------------------------------------------------
variable "enable_kms_alias" {
  description = "Allow to create kms_alias"
  default     = false
}

variable "kms_alias_name" {
  description = "(Optional) The display name of the alias. The name must start with the word 'alias' followed by a forward slash (alias/)"
  default     = null
}

variable "kms_alias_name_prefix" {
  description = "(Optional) Creates an unique alias beginning with the specified prefix. The name must start with the word 'alias' followed by a forward slash (alias/). Conflicts with name."
  default     = null
}

variable "kms_alias_target_key_id" {
  description = "(Required) Identifier for the key for which the alias is for, can be either an ARN or key_id."
  default     = ""
}

#---------------------------------------------------
# KSM grant
#---------------------------------------------------
variable "enable_kms_grant" {
  description = "Enable kms grant usage"
  default     = false
}

variable "kms_grant_name" {
  description = "(Optional, Forces new resources) A friendly name for identifying the grant."
  default     = ""
}

variable "kms_grant_key_id" {
  description = "The unique identifier for the customer master key (CMK) that the grant applies to. Specify the key ID or the Amazon Resource Name (ARN) of the CMK. To specify a CMK in a different AWS account, you must use the key ARN."
  default     = ""
}

variable "kms_grant_grantee_principal" {
  description = "(Required, Forces new resources) The principal that is given permission to perform the operations that the grant permits in ARN format. Note that due to eventual consistency issues around IAM principals, terraform's state may not always be refreshed to reflect what is true in AWS."
  default     = null
}

variable "kms_grant_operations" {
  description = "(Required, Forces new resources) A list of operations that the grant permits. The permitted values are: Decrypt, Encrypt, GenerateDataKey, GenerateDataKeyWithoutPlaintext, ReEncryptFrom, ReEncryptTo, CreateGrant, RetireGrant, DescribeKey"
  default     = []
}

variable "kms_grant_retiring_principal" {
  description = "(Optional, Forces new resources) The principal that is given permission to retire the grant by using RetireGrant operation in ARN format. Note that due to eventual consistency issues around IAM principals, terraform's state may not always be refreshed to reflect what is true in AWS."
  default     = null
}

variable "kms_grant_grant_creation_tokens" {
  description = "(Optional, Forces new resources) A list of grant tokens to be used when creating the grant. See Grant Tokens for more information about grant tokens."
  default     = null
}

variable "kms_grant_retire_on_delete" {
  description = "(Defaults to false, Forces new resources) If set to false (the default) the grants will be revoked upon deletion, and if set to true the grants will try to be retired upon deletion. Note that retiring grants requires special permissions, hence why we default to revoking grants. See RetireGrant for more information."
  default     = null
}

variable "kms_grant_constraints" {
  description = "(Optional, Forces new resources) A structure that you can use to allow certain operations in the grant only when the desired encryption context is present. For more information about encryption context, see Encryption Context."
  default     = []
}

#---------------------------------------------------
# KSM external key
#---------------------------------------------------
variable "enable_kms_external_key" {
  description = "Enable kms external key usage"
  default     = false
}

variable "kms_external_key_name" {
  description = "Set name for external key"
  default     = ""
}

variable "kms_external_key_description" {
  description = "(Optional) Description of the key."
  default     = null
}

variable "kms_external_key_deletion_window_in_days" {
  description = "(Optional) Duration in days after which the key is deleted after destruction of the resource. Must be between 7 and 30 days. Defaults to 30."
  default     = null
}

variable "kms_external_key_enabled" {
  description = "(Optional) Specifies whether the key is enabled. Keys pending import can only be false. Imported keys default to true unless expired."
  default     = null
}

variable "kms_external_key_key_material_base64" {
  description = "(Optional) Base64 encoded 256-bit symmetric encryption key material to import. The CMK is permanently associated with this key material. The same key material can be reimported, but you cannot import different key material."
  default     = null
}

variable "kms_external_key_policy" {
  description = "(Optional) A key policy JSON document. If you do not provide a key policy, AWS KMS attaches a default key policy to the CMK."
  default     = null
}

variable "kms_external_key_valid_to" {
  description = "(Optional) Time at which the imported key material expires. When the key material expires, AWS KMS deletes the key material and the CMK becomes unusable. If not specified, key material does not expire. Valid values: RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ)"
  default     = null
}

#---------------------------------------------------
# KSM ciphertext
#---------------------------------------------------
variable "enable_kms_ciphertext" {
  description = "Enable kms ciphertext usage"
  default     = false
}

variable "kms_ciphertext_key_id" {
  description = "Globally unique key ID for the customer master key."
  default     = ""
}

variable "kms_ciphertext_plaintext" {
  description = "(Required) Data to be encrypted. Note that this may show up in logs, and it will be stored in the state file."
  default     = null
}

variable "kms_ciphertext_context" {
  description = "(Optional) An optional mapping that makes up the encryption context."
  default     = null
}