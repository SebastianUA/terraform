#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for resources"
  default     = "test"
}

variable "environment" {
  description = "The environment for resources"
  default     = "dev"
}

variable "compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to"
  default     = null
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# kms key
#-----------------------------------------------------------
variable "enable_kms_key" {
  description = "Enable kms key usages"
  default     = false
}

variable "kms_key_display_name" {
  description = "(Updatable) A user-friendly name for the key. It does not have to be unique, and it is changeable. Avoid entering confidential information."
  default     = ""
}

variable "kms_key_key_shape" {
  description = "(Required) The cryptographic properties of a key."
  default     = {}
}

variable "kms_key_management_endpoint" {
  description = "(Required) The service endpoint to perform management operations against. Management operations include 'Create,' 'Update,' 'List,' 'Get,' and 'Delete' operations. See Vault Management endpoint."
  default     = []
}

variable "kms_key_is_auto_rotation_enabled" {
  description = "(Optional) (Updatable) A parameter specifying whether the auto key rotation is enabled or not."
  default     = null
}

variable "kms_key_protection_mode" {
  description = "(Optional) The key's protection mode indicates how the key persists and where cryptographic operations that use the key are performed. A protection mode of HSM means that the key persists on a hardware security module (HSM) and all cryptographic operations are performed inside the HSM. A protection mode of SOFTWARE means that the key persists on the server, protected by the vault's RSA wrapping key which persists on the HSM. All cryptographic operations that use a key with a protection mode of SOFTWARE are performed on the server. By default, a key's protection mode is set to HSM. You can't change a key's protection mode after the key is created or imported. A protection mode of EXTERNAL mean that the key persists on the customer's external key manager which is hosted externally outside of oracle. Oracle only hold a reference to that key. All cryptographic operations that use a key with a protection mode of EXTERNAL are performed by external key manager."
  default     = null
}

variable "kms_key_auto_key_rotation_details" {
  description = "(Optional) (Updatable) The details of auto rotation schedule for the Key being create updated or imported."
  default     = {}
}

variable "kms_key_external_key_reference" {
  description = "(Optional) A reference to the key on external key manager."
  default     = {}
}

variable "kms_key_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'}"
  default     = {}
}

variable "kms_key_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Key * update - (Defaults to 20 minutes), when updating the Key * delete - (Defaults to 20 minutes), when destroying the Key"
  default     = {}
}

#-----------------------------------------------------------
# kms key version
#-----------------------------------------------------------
variable "enable_kms_key_version" {
  description = "Enable kms key version usages"
  default     = false
}

variable "kms_key_version_key_id" {
  description = "The OCID of the key."
  default     = ""
}

variable "kms_key_version_management_endpoint" {
  description = "(Required) The service endpoint to perform management operations against. Management operations include 'Create,' 'Update,' 'List,' 'Get,' and 'Delete' operations. See Vault Management endpoint."
  default     = []
}

variable "kms_key_version_external_key_version_id" {
  description = "(Optional) Key version ID associated with the external key."
  default     = null
}

variable "kms_key_version_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Key Version * update - (Defaults to 20 minutes), when updating the Key Version * delete - (Defaults to 20 minutes), when destroying the Key Version"
  default     = {}
}

#-----------------------------------------------------------
# kms generated key
#-----------------------------------------------------------
variable "enable_kms_generated_key" {
  description = "Enable kms generated key usages"
  default     = false
}

variable "kms_generated_key_crypto_endpoint" {
  description = "(Required) The service endpoint to perform cryptographic operations against. Cryptographic operations include 'Encrypt,' 'Decrypt,' and 'GenerateDataEncryptionKey' operations. see Vault Crypto endpoint."
  default     = null
}

variable "kms_generated_key_include_plaintext_key" {
  description = "(Required) If true, the generated key is also returned unencrypted."
  default     = null
}

variable "kms_generated_key_key_id" {
  description = "The OCID of the master encryption key to encrypt the generated data encryption key with."
  default     = ""
}

variable "kms_generated_key_key_shape" {
  description = "(Required) The cryptographic properties of a key."
  default     = {}
}

variable "kms_generated_key_associated_data" {
  description = "(Optional) Information that can be used to provide an encryption context for the encrypted data. The length of the string representation of the associated data must be fewer than 4096 characters."
  default     = null
}

variable "kms_generated_key_logging_context" {
  description = "(Optional) Information that provides context for audit logging. You can provide this additional data by formatting it as key-value pairs to include in audit logs when audit logging is enabled."
  default     = null
}

variable "kms_generated_key_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Generated Key * update - (Defaults to 20 minutes), when updating the Generated Key * delete - (Defaults to 20 minutes), when destroying the Generated Key"
  default     = {}
}

#-----------------------------------------------------------
# kms encrypted data
#-----------------------------------------------------------
variable "enable_kms_encrypted_data" {
  description = "Enable kms encrypted data usages"
  default     = false
}

variable "kms_encrypted_data_crypto_endpoint" {
  description = "(Required) The service endpoint to perform cryptographic operations against. Cryptographic operations include 'Encrypt,' 'Decrypt,' and 'GenerateDataEncryptionKey' operations. see Vault Crypto endpoint."
  default     = null
}

variable "kms_encrypted_data_key_id" {
  description = "The OCID of the key to encrypt with."
  default     = ""
}

variable "kms_encrypted_data_plaintext" {
  description = "(Required) The plaintext data to encrypt."
  default     = null
}

variable "kms_encrypted_data_associated_data" {
  description = "(Optional) Information that can be used to provide an encryption context for the encrypted data. The length of the string representation of the associated data must be fewer than 4096 characters."
  default     = null
}

variable "kms_encrypted_data_encryption_algorithm" {
  description = "(Optional) The encryption algorithm to use to encrypt and decrypt data with a customer-managed key. AES_256_GCM indicates that the key is a symmetric key that uses the Advanced Encryption Standard (AES) algorithm and that the mode of encryption is the Galois/Counter Mode (GCM). RSA_OAEP_SHA_1 indicates that the key is an asymmetric key that uses the RSA encryption algorithm and uses Optimal Asymmetric Encryption Padding (OAEP). RSA_OAEP_SHA_256 indicates that the key is an asymmetric key that uses the RSA encryption algorithm with a SHA-256 hash and uses OAEP."
  default     = null
}

variable "kms_encrypted_data_key_version_id" {
  description = "(Optional) The OCID of the key version used to encrypt the ciphertext."
  default     = null
}

variable "kms_encrypted_data_logging_context" {
  description = "(Optional) Information that provides context for audit logging. You can provide this additional data as key-value pairs to include in the audit logs when audit logging is enabled."
  default     = null
}

variable "kms_encrypted_data_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Encrypted Data * update - (Defaults to 20 minutes), when updating the Encrypted Data * delete - (Defaults to 20 minutes), when destroying the Encrypted Data"
  default     = {}
}

#-----------------------------------------------------------
# kms ekms private endpoint
#-----------------------------------------------------------
variable "enable_kms_ekms_private_endpoint" {
  description = "Enable kms ekms private endpoint usages"
  default     = false
}

variable "kms_ekms_private_endpoint_ca_bundle" {
  description = "(Required) CABundle to validate TLS certificate of the external key manager system in PEM format"
  default     = null
}

variable "kms_ekms_private_endpoint_display_name" {
  description = "(Required) (Updatable) Display name of the EKMS private endpoint resource being created."
  default     = ""
}

variable "kms_ekms_private_endpoint_external_key_manager_ip" {
  description = "(Required) External private IP to connect to from this EKMS private endpoint"
  default     = null
}

variable "kms_ekms_private_endpoint_subnet_id" {
  description = "(Required) The OCID of subnet in which the EKMS private endpoint is to be created"
  default     = null
}

variable "kms_ekms_private_endpoint_defined_tags" {
  description = "(Optional) (Updatable) Simple key-value pair that is applied without any predefined name, type, or scope. Exists for cross-compatibility only. Example: {'bar-key': 'value'}"
  default     = {}
}

variable "kms_ekms_private_endpoint_port" {
  description = "(Optional) The port of the external key manager system"
  default     = null
}

variable "kms_ekms_private_endpoint_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Ekms Private Endpoint * update - (Defaults to 20 minutes), when updating the Ekms Private Endpoint * delete - (Defaults to 20 minutes), when destroying the Ekms Private Endpoint"
  default     = {}
}

#-----------------------------------------------------------
# kms sign
#-----------------------------------------------------------
variable "enable_kms_sign" {
  description = "Enable kms sign usages"
  default     = false
}

variable "kms_sign_crypto_endpoint" {
  description = "(Required) The service endpoint to perform cryptographic operations against. Cryptographic operations include 'Encrypt,' 'Decrypt,', 'GenerateDataEncryptionKey', 'Sign' and 'Verify' operations. see Vault Crypto endpoint."
  default     = null
}

variable "kms_sign_key_id" {
  description = "The OCID of the key used to sign the message."
  default     = null
}

variable "kms_sign_message" {
  description = "(Required) The base64-encoded binary data object denoting the message or message digest to sign. You can have a message up to 4096 bytes in size. To sign a larger message, provide the message digest."
  default     = null
}

variable "kms_sign_signing_algorithm" {
  description = "(Required) The algorithm to use to sign the message or message digest. For RSA keys, supported signature schemes include PKCS #1 and RSASSA-PSS, along with different hashing algorithms. For ECDSA keys, ECDSA is the supported signature scheme with different hashing algorithms. When you pass a message digest for signing, ensure that you specify the same hashing algorithm as used when creating the message digest."
  default     = null
}

variable "kms_sign_key_version_id" {
  description = "(Optional) The OCID of the key version used to sign the message."
  default     = null
}

variable "kms_sign_logging_context" {
  description = "(Optional) Information that can be used to provide context for audit logging. It is a map that contains any additional data that you provide to include with audit logs, if audit logging is enabled."
  default     = null
}

variable "kms_sign_message_type" {
  description = "(Optional) Denotes whether the value of the message parameter is a raw message or a message digest. The default value, RAW, indicates a message. To indicate a message digest, use DIGEST."
  default     = null
}

variable "kms_sign_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Sign * update - (Defaults to 20 minutes), when updating the Sign * delete - (Defaults to 20 minutes), when destroying the Sign"
  default     = {}
}

#-----------------------------------------------------------
# kms verify
#-----------------------------------------------------------
variable "enable_kms_verify" {
  description = "Enable kms verify usages"
  default     = false
}

variable "kms_verify_crypto_endpoint" {
  description = "(Required) The service endpoint to perform cryptographic operations against. Cryptographic operations include 'Encrypt,' 'Decrypt,', 'GenerateDataEncryptionKey', 'Sign' and 'Verify' operations. see Vault Crypto endpoint."
  default     = null
}

variable "kms_verify_key_id" {
  description = "The OCID of the key used to sign the message."
  default     = ""
}

variable "kms_verify_key_version_id" {
  description = "(Required) The OCID of the key version used to sign the message."
  default     = ""
}

variable "kms_verify_message" {
  description = "(Required) The base64-encoded binary data object denoting the message or message digest to sign. You can have a message up to 4096 bytes in size. To sign a larger message, provide the message digest."
  default     = null
}

variable "kms_verify_signature" {
  description = "(Required) The base64-encoded binary data object denoting the cryptographic signature generated for the message."
  default     = null
}

variable "kms_verify_signing_algorithm" {
  description = "(Required) The algorithm to use to sign the message or message digest. For RSA keys, supported signature schemes include PKCS #1 and RSASSA-PSS, along with different hashing algorithms. For ECDSA keys, ECDSA is the supported signature scheme with different hashing algorithms. When you pass a message digest for signing, ensure that you specify the same hashing algorithm as used when creating the message digest."
  default     = null
}

variable "kms_verify_message_type" {
  description = "(Optional) Denotes whether the value of the message parameter is a raw message or a message digest. The default value, RAW, indicates a message. To indicate a message digest, use DIGEST."
  default     = null
}

variable "kms_verify_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Verify * update - (Defaults to 20 minutes), when updating the Verify * delete - (Defaults to 20 minutes), when destroying the Verify"
  default     = {}
}

#-----------------------------------------------------------
# kms vault
#-----------------------------------------------------------
variable "enable_kms_vault" {
  description = "Enable kms vault usages"
  default     = false
}

variable "kms_vault_display_name" {
  description = "(Updatable) A user-friendly name for the vault. It does not have to be unique, and it is changeable. Avoid entering confidential information."
  default     = ""
}

variable "kms_vault_vault_type" {
  description = "(Required) The type of vault to create. Each type of vault stores the key with different degrees of isolation and has different options and pricing."
  default     = null
}

variable "kms_verify_external_key_manager_metadata" {
  description = "(Optional) Metadata required for accessing External Key manager"
  default     = {}
}

variable "kms_vault_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'}"
  default     = {}
}

variable "kms_vault_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Vault * update - (Defaults to 20 minutes), when updating the Vault * delete - (Defaults to 20 minutes), when destroying the Vault"
  default     = {}
}

#-----------------------------------------------------------
# kms vault replication
#-----------------------------------------------------------
variable "enable_kms_vault_replication" {
  description = "Enable kms vault replication usages"
  default     = false
}

variable "kms_vault_replication_vault_id" {
  description = "(Required) The OCID of the primary vault to create replica from."
  default     = ""
}

variable "kms_vault_replication_replica_region" {
  description = "(Required) (Updatable) The region to be created replica to. When updated, replica will be deleted from old region, and created to updated region."
  default     = null
}
