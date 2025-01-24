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

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.21.0"
    }
  }
}

provider "oci" {
  # config_file = var.provider_oci_config_file
  # profile     = var.provider_oci_profile

  fingerprint      = var.provider_oci_fingerprint
  private_key_path = var.provider_oci_private_key_path
  region           = var.provider_oci_region
  tenancy_ocid     = var.provider_oci_tenancy_ocid
  user_ocid        = var.provider_oci_user_ocid
}
module "kms" {
  source = "../../modules/kms"

  enable_kms_key         = true
  kms_key_display_name   = "my-kms-1"
  kms_key_compartment_id = "ocid1.compartment.oc1..exampleuniqueID"
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_kms_key` - Enable kms key usages (`default = False`)
- `kms_key_display_name` - (Updatable) A user-friendly name for the key. It does not have to be unique, and it is changeable. Avoid entering confidential information. (`default = ""`)
- `kms_key_compartment_id` - (Required) (Updatable) The OCID of the compartment where you want to create the master encryption key. (`default = null`)
- `kms_key_key_shape` - (Required) The cryptographic properties of a key. (`default = {}`)
- `kms_key_management_endpoint` - (Required) The service endpoint to perform management operations against. Management operations include 'Create,' 'Update,' 'List,' 'Get,' and 'Delete' operations. See Vault Management endpoint. (`default = []`)
- `kms_key_is_auto_rotation_enabled` - (Optional) (Updatable) A parameter specifying whether the auto key rotation is enabled or not. (`default = null`)
- `kms_key_protection_mode` - (Optional) The key's protection mode indicates how the key persists and where cryptographic operations that use the key are performed. A protection mode of HSM means that the key persists on a hardware security module (HSM) and all cryptographic operations are performed inside the HSM. A protection mode of SOFTWARE means that the key persists on the server, protected by the vault's RSA wrapping key which persists on the HSM. All cryptographic operations that use a key with a protection mode of SOFTWARE are performed on the server. By default, a key's protection mode is set to HSM. You can't change a key's protection mode after the key is created or imported. A protection mode of EXTERNAL mean that the key persists on the customer's external key manager which is hosted externally outside of oracle. Oracle only hold a reference to that key. All cryptographic operations that use a key with a protection mode of EXTERNAL are performed by external key manager. (`default = null`)
- `kms_key_auto_key_rotation_details` - (Optional) (Updatable) The details of auto rotation schedule for the Key being create updated or imported. (`default = {}`)
- `kms_key_external_key_reference` - (Optional) A reference to the key on external key manager. (`default = {}`)
- `kms_key_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'} (`default = {}`)
- `kms_key_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Key * update - (Defaults to 20 minutes), when updating the Key * delete - (Defaults to 20 minutes), when destroying the Key (`default = {}`)
- `enable_kms_key_version` - Enable kms key version usages (`default = False`)
- `kms_key_version_key_id` - The OCID of the key. (`default = ""`)
- `kms_key_version_management_endpoint` - (Required) The service endpoint to perform management operations against. Management operations include 'Create,' 'Update,' 'List,' 'Get,' and 'Delete' operations. See Vault Management endpoint. (`default = []`)
- `kms_key_version_external_key_version_id` - (Optional) Key version ID associated with the external key. (`default = null`)
- `kms_key_version_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Key Version * update - (Defaults to 20 minutes), when updating the Key Version * delete - (Defaults to 20 minutes), when destroying the Key Version (`default = {}`)
- `enable_kms_generated_key` - Enable kms generated key usages (`default = False`)
- `kms_generated_key_crypto_endpoint` - (Required) The service endpoint to perform cryptographic operations against. Cryptographic operations include 'Encrypt,' 'Decrypt,' and 'GenerateDataEncryptionKey' operations. see Vault Crypto endpoint. (`default = null`)
- `kms_generated_key_include_plaintext_key` - (Required) If true, the generated key is also returned unencrypted. (`default = null`)
- `kms_generated_key_key_id` - The OCID of the master encryption key to encrypt the generated data encryption key with. (`default = ""`)
- `kms_generated_key_key_shape` - (Required) The cryptographic properties of a key. (`default = {}`)
- `kms_generated_key_associated_data` - (Optional) Information that can be used to provide an encryption context for the encrypted data. The length of the string representation of the associated data must be fewer than 4096 characters. (`default = null`)
- `kms_generated_key_logging_context` - (Optional) Information that provides context for audit logging. You can provide this additional data by formatting it as key-value pairs to include in audit logs when audit logging is enabled. (`default = null`)
- `kms_generated_key_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Generated Key * update - (Defaults to 20 minutes), when updating the Generated Key * delete - (Defaults to 20 minutes), when destroying the Generated Key (`default = {}`)
- `enable_kms_encrypted_data` - Enable kms encrypted data usages (`default = False`)
- `kms_encrypted_data_crypto_endpoint` - (Required) The service endpoint to perform cryptographic operations against. Cryptographic operations include 'Encrypt,' 'Decrypt,' and 'GenerateDataEncryptionKey' operations. see Vault Crypto endpoint. (`default = null`)
- `kms_encrypted_data_key_id` - The OCID of the key to encrypt with. (`default = ""`)
- `kms_encrypted_data_plaintext` - (Required) The plaintext data to encrypt. (`default = null`)
- `kms_encrypted_data_associated_data` - (Optional) Information that can be used to provide an encryption context for the encrypted data. The length of the string representation of the associated data must be fewer than 4096 characters. (`default = null`)
- `kms_encrypted_data_encryption_algorithm` - (Optional) The encryption algorithm to use to encrypt and decrypt data with a customer-managed key. AES_256_GCM indicates that the key is a symmetric key that uses the Advanced Encryption Standard (AES) algorithm and that the mode of encryption is the Galois/Counter Mode (GCM). RSA_OAEP_SHA_1 indicates that the key is an asymmetric key that uses the RSA encryption algorithm and uses Optimal Asymmetric Encryption Padding (OAEP). RSA_OAEP_SHA_256 indicates that the key is an asymmetric key that uses the RSA encryption algorithm with a SHA-256 hash and uses OAEP. (`default = null`)
- `kms_encrypted_data_key_version_id` - (Optional) The OCID of the key version used to encrypt the ciphertext. (`default = null`)
- `kms_encrypted_data_logging_context` - (Optional) Information that provides context for audit logging. You can provide this additional data as key-value pairs to include in the audit logs when audit logging is enabled. (`default = null`)
- `kms_encrypted_data_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Encrypted Data * update - (Defaults to 20 minutes), when updating the Encrypted Data * delete - (Defaults to 20 minutes), when destroying the Encrypted Data (`default = {}`)
- `enable_kms_ekms_private_endpoint` - Enable kms ekms private endpoint usages (`default = False`)
- `kms_ekms_private_endpoint_ca_bundle` - (Required) CABundle to validate TLS certificate of the external key manager system in PEM format (`default = null`)
- `kms_ekms_private_endpoint_compartment_id` - (Required) Compartment identifier. (`default = null`)
- `kms_ekms_private_endpoint_display_name` - (Required) (Updatable) Display name of the EKMS private endpoint resource being created. (`default = ""`)
- `kms_ekms_private_endpoint_external_key_manager_ip` - (Required) External private IP to connect to from this EKMS private endpoint (`default = null`)
- `kms_ekms_private_endpoint_subnet_id` - (Required) The OCID of subnet in which the EKMS private endpoint is to be created (`default = null`)
- `kms_ekms_private_endpoint_freeform_tags` - (Optional) (Updatable) Simple key-value pair that is applied without any predefined name, type, or scope. Exists for cross-compatibility only. Example: {'bar-key': 'value'} (`default = {}`)
- `kms_ekms_private_endpoint_port` - (Optional) The port of the external key manager system (`default = null`)
- `kms_ekms_private_endpoint_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Ekms Private Endpoint * update - (Defaults to 20 minutes), when updating the Ekms Private Endpoint * delete - (Defaults to 20 minutes), when destroying the Ekms Private Endpoint (`default = {}`)
- `enable_kms_sign` - Enable kms sign usages (`default = False`)
- `kms_sign_crypto_endpoint` - (Required) The service endpoint to perform cryptographic operations against. Cryptographic operations include 'Encrypt,' 'Decrypt,', 'GenerateDataEncryptionKey', 'Sign' and 'Verify' operations. see Vault Crypto endpoint. (`default = null`)
- `kms_sign_key_id` - The OCID of the key used to sign the message. (`default = null`)
- `kms_sign_message` - (Required) The base64-encoded binary data object denoting the message or message digest to sign. You can have a message up to 4096 bytes in size. To sign a larger message, provide the message digest. (`default = null`)
- `kms_sign_signing_algorithm` - (Required) The algorithm to use to sign the message or message digest. For RSA keys, supported signature schemes include PKCS #1 and RSASSA-PSS, along with different hashing algorithms. For ECDSA keys, ECDSA is the supported signature scheme with different hashing algorithms. When you pass a message digest for signing, ensure that you specify the same hashing algorithm as used when creating the message digest. (`default = null`)
- `kms_sign_key_version_id` - (Optional) The OCID of the key version used to sign the message. (`default = null`)
- `kms_sign_logging_context` - (Optional) Information that can be used to provide context for audit logging. It is a map that contains any additional data that you provide to include with audit logs, if audit logging is enabled. (`default = null`)
- `kms_sign_message_type` - (Optional) Denotes whether the value of the message parameter is a raw message or a message digest. The default value, RAW, indicates a message. To indicate a message digest, use DIGEST. (`default = null`)
- `kms_sign_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Sign * update - (Defaults to 20 minutes), when updating the Sign * delete - (Defaults to 20 minutes), when destroying the Sign (`default = {}`)
- `enable_kms_verify` - Enable kms verify usages (`default = False`)
- `kms_verify_crypto_endpoint` - (Required) The service endpoint to perform cryptographic operations against. Cryptographic operations include 'Encrypt,' 'Decrypt,', 'GenerateDataEncryptionKey', 'Sign' and 'Verify' operations. see Vault Crypto endpoint. (`default = null`)
- `kms_verify_key_id` - The OCID of the key used to sign the message. (`default = ""`)
- `kms_verify_key_version_id` - (Required) The OCID of the key version used to sign the message. (`default = ""`)
- `kms_verify_message` - (Required) The base64-encoded binary data object denoting the message or message digest to sign. You can have a message up to 4096 bytes in size. To sign a larger message, provide the message digest. (`default = null`)
- `kms_verify_signature` - (Required) The base64-encoded binary data object denoting the cryptographic signature generated for the message. (`default = null`)
- `kms_verify_signing_algorithm` - (Required) The algorithm to use to sign the message or message digest. For RSA keys, supported signature schemes include PKCS #1 and RSASSA-PSS, along with different hashing algorithms. For ECDSA keys, ECDSA is the supported signature scheme with different hashing algorithms. When you pass a message digest for signing, ensure that you specify the same hashing algorithm as used when creating the message digest. (`default = null`)
- `kms_verify_message_type` - (Optional) Denotes whether the value of the message parameter is a raw message or a message digest. The default value, RAW, indicates a message. To indicate a message digest, use DIGEST. (`default = null`)
- `kms_verify_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Verify * update - (Defaults to 20 minutes), when updating the Verify * delete - (Defaults to 20 minutes), when destroying the Verify (`default = {}`)
- `enable_kms_vault` - Enable kms vault usages (`default = False`)
- `kms_vault_compartment_id` - (Required) (Updatable) The OCID of the compartment where you want to create this vault. (`default = null`)
- `kms_vault_display_name` - (Updatable) A user-friendly name for the vault. It does not have to be unique, and it is changeable. Avoid entering confidential information. (`default = ""`)
- `kms_vault_vault_type` - (Required) The type of vault to create. Each type of vault stores the key with different degrees of isolation and has different options and pricing. (`default = null`)
- `kms_verify_external_key_manager_metadata` - (Optional) Metadata required for accessing External Key manager (`default = {}`)
- `kms_vault_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {'Department': 'Finance'} (`default = {}`)
- `kms_vault_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Vault * update - (Defaults to 20 minutes), when updating the Vault * delete - (Defaults to 20 minutes), when destroying the Vault (`default = {}`)
- `enable_kms_vault_replication` - Enable kms vault replication usages (`default = False`)
- `kms_vault_replication_vault_id` - (Required) The OCID of the primary vault to create replica from. (`default = ""`)
- `kms_vault_replication_replica_region` - (Required) (Updatable) The region to be created replica to. When updated, replica will be deleted from old region, and created to updated region. (`default = null`)

## Module Output Variables
----------------------
- `kms_key_id` - The OCID of the key.
- `kms_key_display_name` - A user-friendly name for the key. It does not have to be unique, and it is changeable. Avoid entering confidential information.
- `kms_key_` - AAAAA
- `kms_key_current_key_version` - The OCID of the key version used in cryptographic operations. During key rotation, the service might be in a transitional state where this or a newer key version are used intermittently. The currentKeyVersion property is updated when the service is guaranteed to use the new key version for all subsequent encryption operations.
- `kms_key_compartment_id` - The OCID of the compartment that contains this master encryption key.
- `kms_key_is_primary` - A Boolean value that indicates whether the Key belongs to primary Vault or replica vault.
- `kms_key_vault_id` - The OCID of the vault that contains this key.
- `kms_key_state` - The key's current lifecycle state. Example: ENABLED
- `kms_key_version_id` - The OCID of the key version.
- `kms_key_version_compartment_id` - The OCID of the compartment that contains this key version.
- `kms_key_version_is_auto_rotated` - An optional property indicating whether this keyversion is generated from auto rotatation.
- `kms_key_version_state` - The key version's current lifecycle state. Example: ENABLED
- `kms_key_version_vault_id` - The OCID of the vault that contains this key version.
- `kms_key_version_restored_from_key_version_id` - The OCID of the key version from which this key version was restored.
- `kms_generated_key_id` - ID for KMS generated key
- `kms_generated_key_ciphertext` - The encrypted data encryption key generated from a master encryption key.
- `kms_generated_key_plaintext` - The plaintext data encryption key, a base64-encoded sequence of random bytes, which is included if the GenerateDataEncryptionKey request includes the includePlaintextKey parameter and sets its value to 'true'.
- `kms_generated_key_plaintext_checksum` - The checksum of the plaintext data encryption key, which is included if the GenerateDataEncryptionKey request includes the includePlaintextKey parameter and sets its value to 'true'.
- `kms_encrypted_data_id` - ID of KMS encrypted data
- `kms_encrypted_data_ciphertext` - The encrypted data.
- `kms_encrypted_data_encryption_algorithm` - The encryption algorithm to use to encrypt and decrypt data with a customer-managed key. AES_256_GCM indicates that the key is a symmetric key that uses the Advanced Encryption Standard (AES) algorithm and that the mode of encryption is the Galois/Counter Mode (GCM). RSA_OAEP_SHA_1 indicates that the key is an asymmetric key that uses the RSA encryption algorithm and uses Optimal Asymmetric Encryption Padding (OAEP). RSA_OAEP_SHA_256 indicates that the key is an asymmetric key that uses the RSA encryption algorithm with a SHA-256 hash and uses OAEP.
- `kms_encrypted_data_key_id` - The OCID of the key used to encrypt the ciphertext.
- `kms_encrypted_data_key_version_id` - The OCID of the key version used to encrypt the ciphertext.
- `kms_ekms_private_endpoint_id` - Unique identifier that is immutable
- `kms_ekms_private_endpoint_ca_bundle` - CABundle to validate TLS certificate of the external key manager system in PEM format
- `kms_ekms_private_endpoint_state` - The current state of the EKMS private endpoint resource.
- `kms_ekms_private_endpoint_subnet_id` - Subnet Identifier
- `kms_ekms_private_endpoint_display_name` - Mutable name of the EKMS private endpoint
- `kms_ekms_private_endpoint_external_key_manager_ip` - Private IP of the external key manager system to connect to from the EKMS private endpoint
- `kms_ekms_private_endpoint_port` - The port of the external key manager system
- `kms_ekms_private_endpoint_private_endpoint_ip` - The IP address in the customer's VCN for the EKMS private endpoint. This is taken from subnet
- `kms_ekms_private_endpoint_lifecycle_details` - A message describing the current state in more detail. For example, can be used to provide actionable information for a resource in 'Failed' state.
- `kms_ekms_private_endpoint_compartment_id` - Identifier of the compartment this EKMS private endpoint belongs to
- `kms_sign_id` - ID of kms sign
- `kms_sign_key_id` - The OCID of the key used to sign the message.
- `kms_sign_key_version_id` - The OCID of the key version used to sign the message.
- `kms_sign_signature` - The base64-encoded binary data object denoting the cryptographic signature generated for the message or message digest.
- `kms_sign_signing_algorithm` - The algorithm to use to sign the message or message digest. For RSA keys, supported signature schemes include PKCS #1 and RSASSA-PSS, along with different hashing algorithms. For ECDSA keys, ECDSA is the supported signature scheme with different hashing algorithms. When you pass a message digest for signing, ensure that you specify the same hashing algorithm as used when creating the message digest.
- `kms_verify_id` - ID of KMS verify
- `kms_verify_is_signature_valid` - A Boolean value that indicates whether the signature was verified.
- `kms_vault_id` - The OCID of the vault.
- `kms_vault_compartment_id` - The OCID of the compartment that contains a particular vault.
- `kms_vault_crypto_endpoint` - The service endpoint to perform cryptographic operations against. Cryptographic operations include Encrypt, Decrypt, and GenerateDataEncryptionKey operations.
- `kms_vault_display_name` - A user-friendly name for the vault. It does not have to be unique, and it is changeable. Avoid entering confidential information.
- `kms_vault_external_key_manager_metadata_summary` - Summary about metadata of external key manager to be returned to the customer as a response.
- `kms_vault_external_vault_endpoint_url` - URL of the vault on external key manager.
- `kms_vault_oauth_metadata_summary` - Summary about authorization to be returned to the customer as a response.
- `kms_vault_client_app_id` - ID of the client app created in IDP.
- `kms_vault_idcs_account_name_url` - Base URL of the IDCS account where confidential client app is created.
- `kms_vault_private_endpoint_id` - OCID of the private endpoint.
- `kms_vault_vendor` - Vendor of the external key manager.
- `kms_vault_is_primary` - A Boolean value that indicates whether the Vault is primary Vault or replica Vault.
- `kms_vault_is_vault_replicable` - A Boolean value that indicates whether the Vault has cross region replication capability. Always true for Virtual Private Vaults.
- `kms_vault_management_endpoint` - The service endpoint to perform management operations against. Management operations include 'Create,' 'Update,' 'List,' 'Get,' and 'Delete' operations.
- `kms_vault_replica_details` - Vault replica details
- `kms_vault_replication_id` - ReplicationId associated with a vault operation
- `kms_vault_restored_from_vault_id` - The OCID of the vault from which this vault was restored, if it was restored from a backup file. If you restore a vault to the same region, the vault retains the same OCID that it had when you backed up the vault.
- `kms_vault_state` - The vault's current lifecycle state. Example: DELETED
- `kms_vault_time_created` - The date and time this vault was created, expressed in RFC 3339 timestamp format. Example: 2018-04-03T21:10:29.600Z
- `kms_vault_time_of_deletion` - An optional property to indicate when to delete the vault, expressed in RFC 3339 timestamp format. Example: 2018-04-03T21:10:29.600Z
- `kms_vault_vault_type` - The type of vault. Each type of vault stores the key with different degrees of isolation and has different options and pricing.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
