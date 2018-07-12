output "kms_key_ring_name" {
    description = "Name of kms key ring"
    value       = "${google_kms_key_ring.kms_key_ring.*.name}"
}

output "kms_key_ring_id" {
    description = "ID"
    value       = "${google_kms_key_ring.kms_key_ring.*.id}"
}

output "kms_crypto_key_iam_binding_etag" {
    description = "(Computed) The etag of the crypto key's IAM policy."
    value       = "${google_kms_crypto_key_iam_binding.kms_crypto_key_iam_binding.*.etag}"
}

output "my_crypto_key_name" {
    description = "The ID of the created CryptoKey. Its format is {projectId}/{location}/{keyRingName}/{cryptoKeyName}."
    value       = "${google_kms_crypto_key.kms_crypto_key.*.name}"
}

output "kms_crypto_key_iam_member_id" {
    description = "ID"
    value       = "${google_kms_crypto_key_iam_member.kms_crypto_key_iam_member.*.id}"
}

output "kms_crypto_key_iam_member_etag" {
    description = "etag"
    value       = "${google_kms_crypto_key_iam_member.kms_crypto_key_iam_member.*.etag}"
}

