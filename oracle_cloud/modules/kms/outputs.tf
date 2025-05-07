#-----------------------------------------------------------
# kms key
#-----------------------------------------------------------
output "kms_key_id" {
  description = "The OCID of the key."
  value       = element(concat(oci_kms_key.kms_key.*.id, [""]), 0)
}

output "kms_key_display_name" {
  description = "A user-friendly name for the key. It does not have to be unique, and it is changeable. Avoid entering confidential information."
  value       = element(concat(oci_kms_key.kms_key.*.display_name, [""]), 0)
}

output "kms_key_" {
  description = "AAAAA"
  value       = element(concat(oci_kms_key.kms_key.*.bucket_id, [""]), 0)
}

output "kms_key_current_key_version" {
  description = "The OCID of the key version used in cryptographic operations. During key rotation, the service might be in a transitional state where this or a newer key version are used intermittently. The currentKeyVersion property is updated when the service is guaranteed to use the new key version for all subsequent encryption operations."
  value       = element(concat(oci_kms_key.kms_key.*.current_key_version, [""]), 0)
}

output "kms_key_compartment_id" {
  description = "The OCID of the compartment that contains this master encryption key."
  value       = element(concat(oci_kms_key.kms_key.*.compartment_id, [""]), 0)
}

output "kms_key_is_primary" {
  description = "A Boolean value that indicates whether the Key belongs to primary Vault or replica vault."
  value       = element(concat(oci_kms_key.kms_key.*.is_primary, [""]), 0)
}

output "kms_key_vault_id" {
  description = "The OCID of the vault that contains this key."
  value       = element(concat(oci_kms_key.kms_key.*.vault_id, [""]), 0)
}

output "kms_key_state" {
  description = "The key's current lifecycle state. Example: ENABLED"
  value       = element(concat(oci_kms_key.kms_key.*.state, [""]), 0)
}

#-----------------------------------------------------------
# kms key version
#-----------------------------------------------------------
output "kms_key_version_id" {
  description = "The OCID of the key version."
  value       = element(concat(oci_kms_key_version.kms_key_version.*.id, [""]), 0)
}

output "kms_key_version_compartment_id" {
  description = "The OCID of the compartment that contains this key version."
  value       = element(concat(oci_kms_key_version.kms_key_version.*.compartment_id, [""]), 0)
}

output "kms_key_version_is_auto_rotated" {
  description = "An optional property indicating whether this keyversion is generated from auto rotatation."
  value       = element(concat(oci_kms_key_version.kms_key_version.*.is_auto_rotated, [""]), 0)
}

output "kms_key_version_state" {
  description = "The key version's current lifecycle state. Example: ENABLED"
  value       = element(concat(oci_kms_key_version.kms_key_version.*.state, [""]), 0)
}

output "kms_key_version_vault_id" {
  description = "The OCID of the vault that contains this key version."
  value       = element(concat(oci_kms_key_version.kms_key_version.*.vault_id, [""]), 0)
}

output "kms_key_version_restored_from_key_version_id" {
  description = "The OCID of the key version from which this key version was restored."
  value       = element(concat(oci_kms_key_version.kms_key_version.*.restored_from_key_version_id, [""]), 0)
}

#-----------------------------------------------------------
# kms generated key
#-----------------------------------------------------------
output "kms_generated_key_id" {
  description = "ID for KMS generated key"
  value       = element(concat(oci_kms_generated_key.kms_generated_key.*.id, [""]), 0)
}

output "kms_generated_key_ciphertext" {
  description = "The encrypted data encryption key generated from a master encryption key."
  value       = element(concat(oci_kms_generated_key.kms_generated_key.*.ciphertext, [""]), 0)
}

output "kms_generated_key_plaintext" {
  description = "The plaintext data encryption key, a base64-encoded sequence of random bytes, which is included if the GenerateDataEncryptionKey request includes the includePlaintextKey parameter and sets its value to 'true'."
  value       = element(concat(oci_kms_generated_key.kms_generated_key.*.plaintext, [""]), 0)
}

output "kms_generated_key_plaintext_checksum" {
  description = "The checksum of the plaintext data encryption key, which is included if the GenerateDataEncryptionKey request includes the includePlaintextKey parameter and sets its value to 'true'."
  value       = element(concat(oci_kms_generated_key.kms_generated_key.*.plaintext_checksum, [""]), 0)
}

#-----------------------------------------------------------
# kms encrypted data
#-----------------------------------------------------------
output "kms_encrypted_data_id" {
  description = "ID of KMS encrypted data"
  value       = element(concat(oci_kms_encrypted_data.kms_encrypted_data.*.id, [""]), 0)
}

output "kms_encrypted_data_ciphertext" {
  description = "The encrypted data."
  value       = element(concat(oci_kms_encrypted_data.kms_encrypted_data.*.ciphertext, [""]), 0)
}

output "kms_encrypted_data_encryption_algorithm" {
  description = "The encryption algorithm to use to encrypt and decrypt data with a customer-managed key. AES_256_GCM indicates that the key is a symmetric key that uses the Advanced Encryption Standard (AES) algorithm and that the mode of encryption is the Galois/Counter Mode (GCM). RSA_OAEP_SHA_1 indicates that the key is an asymmetric key that uses the RSA encryption algorithm and uses Optimal Asymmetric Encryption Padding (OAEP). RSA_OAEP_SHA_256 indicates that the key is an asymmetric key that uses the RSA encryption algorithm with a SHA-256 hash and uses OAEP."
  value       = element(concat(oci_kms_encrypted_data.kms_encrypted_data.*.encryption_algorithm, [""]), 0)
}

output "kms_encrypted_data_key_id" {
  description = "The OCID of the key used to encrypt the ciphertext."
  value       = element(concat(oci_kms_encrypted_data.kms_encrypted_data.*.key_id, [""]), 0)
}

output "kms_encrypted_data_key_version_id" {
  description = "The OCID of the key version used to encrypt the ciphertext."
  value       = element(concat(oci_kms_encrypted_data.kms_encrypted_data.*.key_version_id, [""]), 0)
}

#-----------------------------------------------------------
# kms ekms private endpoint
#-----------------------------------------------------------
output "kms_ekms_private_endpoint_id" {
  description = "Unique identifier that is immutable"
  value       = element(concat(oci_kms_ekms_private_endpoint.kms_ekms_private_endpoint.*.id, [""]), 0)
}

output "kms_ekms_private_endpoint_ca_bundle" {
  description = "CABundle to validate TLS certificate of the external key manager system in PEM format"
  value       = element(concat(oci_kms_ekms_private_endpoint.kms_ekms_private_endpoint.*.ca_bundle, [""]), 0)
}

output "kms_ekms_private_endpoint_state" {
  description = "The current state of the EKMS private endpoint resource."
  value       = element(concat(oci_kms_ekms_private_endpoint.kms_ekms_private_endpoint.*.state, [""]), 0)
}

output "kms_ekms_private_endpoint_subnet_id" {
  description = "Subnet Identifier"
  value       = element(concat(oci_kms_ekms_private_endpoint.kms_ekms_private_endpoint.*.subnet_id, [""]), 0)
}

output "kms_ekms_private_endpoint_display_name" {
  description = "Mutable name of the EKMS private endpoint"
  value       = element(concat(oci_kms_ekms_private_endpoint.kms_ekms_private_endpoint.*.display_name, [""]), 0)
}

output "kms_ekms_private_endpoint_external_key_manager_ip" {
  description = "Private IP of the external key manager system to connect to from the EKMS private endpoint"
  value       = element(concat(oci_kms_ekms_private_endpoint.kms_ekms_private_endpoint.*.external_key_manager_ip, [""]), 0)
}

output "kms_ekms_private_endpoint_port" {
  description = "The port of the external key manager system"
  value       = element(concat(oci_kms_ekms_private_endpoint.kms_ekms_private_endpoint.*.port, [""]), 0)
}

output "kms_ekms_private_endpoint_private_endpoint_ip" {
  description = "The IP address in the customer's VCN for the EKMS private endpoint. This is taken from subnet"
  value       = element(concat(oci_kms_ekms_private_endpoint.kms_ekms_private_endpoint.*.private_endpoint_ip, [""]), 0)
}

output "kms_ekms_private_endpoint_lifecycle_details" {
  description = "A message describing the current state in more detail. For example, can be used to provide actionable information for a resource in 'Failed' state."
  value       = element(concat(oci_kms_ekms_private_endpoint.kms_ekms_private_endpoint.*.lifecycle_details, [""]), 0)
}

output "kms_ekms_private_endpoint_compartment_id" {
  description = "Identifier of the compartment this EKMS private endpoint belongs to"
  value       = element(concat(oci_kms_ekms_private_endpoint.kms_ekms_private_endpoint.*.compartment_id, [""]), 0)
}

#-----------------------------------------------------------
# kms sign
#-----------------------------------------------------------
output "kms_sign_id" {
  description = "ID of kms sign"
  value       = element(concat(oci_kms_sign.kms_sign.*.id, [""]), 0)
}

output "kms_sign_key_id" {
  description = "The OCID of the key used to sign the message."
  value       = element(concat(oci_kms_sign.kms_sign.*.key_id, [""]), 0)
}

output "kms_sign_key_version_id" {
  description = "The OCID of the key version used to sign the message."
  value       = element(concat(oci_kms_sign.kms_sign.*.key_version_id, [""]), 0)
}

output "kms_sign_signature" {
  description = "The base64-encoded binary data object denoting the cryptographic signature generated for the message or message digest."
  value       = element(concat(oci_kms_sign.kms_sign.*.signature, [""]), 0)
}

output "kms_sign_signing_algorithm" {
  description = "The algorithm to use to sign the message or message digest. For RSA keys, supported signature schemes include PKCS #1 and RSASSA-PSS, along with different hashing algorithms. For ECDSA keys, ECDSA is the supported signature scheme with different hashing algorithms. When you pass a message digest for signing, ensure that you specify the same hashing algorithm as used when creating the message digest."
  value       = element(concat(oci_kms_sign.kms_sign.*.signing_algorithm, [""]), 0)
}

#-----------------------------------------------------------
# kms verify
#-----------------------------------------------------------
output "kms_verify_id" {
  description = "ID of KMS verify"
  value       = element(concat(oci_kms_verify.kms_verify.*.id, [""]), 0)
}

output "kms_verify_is_signature_valid" {
  description = "A Boolean value that indicates whether the signature was verified."
  value       = element(concat(oci_kms_verify.kms_verify.*.is_signature_valid, [""]), 0)
}

#-----------------------------------------------------------
# kms vault
#-----------------------------------------------------------
output "kms_vault_id" {
  description = "The OCID of the vault."
  value       = element(concat(oci_kms_vault.kms_vault.*.id, [""]), 0)
}

output "kms_vault_compartment_id" {
  description = "The OCID of the compartment that contains a particular vault."
  value       = element(concat(oci_kms_vault.kms_vault.*.compartment_id, [""]), 0)
}

output "kms_vault_crypto_endpoint" {
  description = "The service endpoint to perform cryptographic operations against. Cryptographic operations include Encrypt, Decrypt, and GenerateDataEncryptionKey operations."
  value       = element(concat(oci_kms_vault.kms_vault.*.crypto_endpoint, [""]), 0)
}

output "kms_vault_display_name" {
  description = "A user-friendly name for the vault. It does not have to be unique, and it is changeable. Avoid entering confidential information."
  value       = element(concat(oci_kms_vault.kms_vault.*.display_name, [""]), 0)
}

output "kms_vault_external_key_manager_metadata_summary" {
  description = "Summary about metadata of external key manager to be returned to the customer as a response."
  value       = element(concat(oci_kms_vault.kms_vault.*.external_key_manager_metadata_summary, [""]), 0)
}

output "kms_vault_external_vault_endpoint_url" {
  description = "URL of the vault on external key manager."
  value       = element(concat(oci_kms_vault.kms_vault.*.external_vault_endpoint_url, [""]), 0)
}

output "kms_vault_oauth_metadata_summary" {
  description = "Summary about authorization to be returned to the customer as a response."
  value       = element(concat(oci_kms_vault.kms_vault.*.oauth_metadata_summary, [""]), 0)
}

output "kms_vault_client_app_id" {
  description = "ID of the client app created in IDP."
  value       = element(concat(oci_kms_vault.kms_vault.*.client_app_id, [""]), 0)
}

output "kms_vault_idcs_account_name_url" {
  description = "Base URL of the IDCS account where confidential client app is created."
  value       = element(concat(oci_kms_vault.kms_vault.*.idcs_account_name_url, [""]), 0)
}

output "kms_vault_private_endpoint_id" {
  description = "OCID of the private endpoint."
  value       = element(concat(oci_kms_vault.kms_vault.*.private_endpoint_id, [""]), 0)
}

output "kms_vault_vendor" {
  description = "Vendor of the external key manager."
  value       = element(concat(oci_kms_vault.kms_vault.*.vendor, [""]), 0)
}

output "kms_vault_is_primary" {
  description = "A Boolean value that indicates whether the Vault is primary Vault or replica Vault."
  value       = element(concat(oci_kms_vault.kms_vault.*.is_primary, [""]), 0)
}

output "kms_vault_is_vault_replicable" {
  description = "A Boolean value that indicates whether the Vault has cross region replication capability. Always true for Virtual Private Vaults."
  value       = element(concat(oci_kms_vault.kms_vault.*.is_vault_replicable, [""]), 0)
}

output "kms_vault_management_endpoint" {
  description = "The service endpoint to perform management operations against. Management operations include 'Create,' 'Update,' 'List,' 'Get,' and 'Delete' operations."
  value       = element(concat(oci_kms_vault.kms_vault.*.management_endpoint, [""]), 0)
}

output "kms_vault_replica_details" {
  description = "Vault replica details"
  value       = element(concat(oci_kms_vault.kms_vault.*.replica_details, [""]), 0)
}

output "kms_vault_replication_id" {
  description = "ReplicationId associated with a vault operation"
  value       = element(concat(oci_kms_vault.kms_vault.*.replication_id, [""]), 0)
}

output "kms_vault_restored_from_vault_id" {
  description = "The OCID of the vault from which this vault was restored, if it was restored from a backup file. If you restore a vault to the same region, the vault retains the same OCID that it had when you backed up the vault."
  value       = element(concat(oci_kms_vault.kms_vault.*.restored_from_vault_id, [""]), 0)
}

output "kms_vault_state" {
  description = "The vault's current lifecycle state. Example: DELETED"
  value       = element(concat(oci_kms_vault.kms_vault.*.state, [""]), 0)
}

output "kms_vault_time_created" {
  description = "The date and time this vault was created, expressed in RFC 3339 timestamp format. Example: 2018-04-03T21:10:29.600Z"
  value       = element(concat(oci_kms_vault.kms_vault.*.time_created, [""]), 0)
}

output "kms_vault_time_of_deletion" {
  description = "An optional property to indicate when to delete the vault, expressed in RFC 3339 timestamp format. Example: 2018-04-03T21:10:29.600Z"
  value       = element(concat(oci_kms_vault.kms_vault.*.time_of_deletion, [""]), 0)
}

output "kms_vault_vault_type" {
  description = "The type of vault. Each type of vault stores the key with different degrees of isolation and has different options and pricing."
  value       = element(concat(oci_kms_vault.kms_vault.*.vault_type, [""]), 0)
}
