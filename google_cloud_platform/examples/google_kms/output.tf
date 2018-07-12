output "kms_key_ring_name" {
    description = "Name of kms key ring"
    value       = "${module.google_kms.kms_key_ring_name}"
}

output "kms_key_ring_id" {
    description = "ID"
    value       = "${module.google_kms.kms_key_ring_id}"
}

output "kms_crypto_key_iam_binding_etag" {
    description = "(Computed) The etag of the crypto key's IAM policy."
    value       = "${module.google_kms.kms_crypto_key_iam_binding_etag}"
}

output "my_crypto_key_name" {
    description = "The ID of the created CryptoKey. Its format is {projectId}/{location}/{keyRingName}/{cryptoKeyName}."
    value       = "${module.google_kms.my_crypto_key_name}"
}

output "kms_crypto_key_iam_member_id" {
    description = "ID"
    value       = "${module.google_kms.kms_crypto_key_iam_member_id}"
}

output "kms_crypto_key_iam_member_etag" {
    description = "etag"
    value       = "${module.google_kms.kms_crypto_key_iam_member_etag}"
}

