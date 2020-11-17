#-----------------------------------------------------------
# IAM access key
#-----------------------------------------------------------
output "iam_access_key_id" {
  description = "The access key ID"
  value       = element(concat(aws_iam_access_key.iam_access_key.*.id, [""], ), 0)
}

output "iam_access_key_user" {
  description = "The IAM user associated with this access key."
  value       = element(concat(aws_iam_access_key.iam_access_key.*.user, [""]), 0)
}

output "iam_access_key_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the secret"
  value       = element(concat(aws_iam_access_key.iam_access_key.*.key_fingerprint, [""]), 0)
}

output "iam_access_key_secret" {
  description = "The secret access key. Note that this will be written to the state file. Please supply a pgp_key instead, which will prevent the secret from being stored in plain text"
  value       = element(concat(aws_iam_access_key.iam_access_key.*.pgp_key, [""], ), 0)
}

output "iam_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded. ~> NOTE: The encrypted secret may be decrypted using the command line, for example: terraform output encrypted_secret | base64 --decode | keybase pgp decrypt."
  value       = element(concat(aws_iam_access_key.iam_access_key.*.encrypted_secret, [""], ), 0)
}

output "keybase_password_decrypt_command" {
  description = ""
  value       = <<EOF
echo element(concat(aws_iam_user_login_profile.iam_user_login_profile.*.encrypted_password, [""],), 0) | base64 --decode | keybase pgp decrypt
EOF

}

output "keybase_password_pgp_message" {
  description = ""
  value       = <<EOF
-----BEGIN PGP MESSAGE-----
Version: Keybase OpenPGP v2.0.76
Comment: https://keybase.io/crypto
element(concat(aws_iam_user_login_profile.iam_user_login_profile.*.encrypted_password, [""],), 0)
-----END PGP MESSAGE-----
EOF

}

output "keybase_secret_key_decrypt_command" {
  description = ""
  value       = <<EOF
echo element(concat(aws_iam_access_key.iam_access_key.*.encrypted_secret, [""],), 0) | base64 --decode | keybase pgp decrypt
EOF

}

output "keybase_secret_key_pgp_message" {
  description = ""
  value       = <<EOF
-----BEGIN PGP MESSAGE-----
Version: Keybase OpenPGP v2.0.76
Comment: https://keybase.io/crypto
element(concat(aws_iam_access_key.iam_access_key.*.encrypted_secret, [""],), 0)
-----END PGP MESSAGE-----
EOF

}

// output "iam_access_key_ses_smtp_password" {
//     description = "The secret access key converted into an SES SMTP password by applying AWS's documented conversion algorithm."
//     value       = element(concat(
//         aws_iam_access_key.iam_access_key.*.ses_smtp_password,
//         [""],), 0,)
// }

#-----------------------------------------------------------
# IAM account alias
#-----------------------------------------------------------
output "iam_account_alias_id" {
  description = "ID"
  value       = element(concat(aws_iam_account_alias.iam_account_alias.*.id, [""]), 0)
}

#-----------------------------------------------------------
# IAM account password policy
#-----------------------------------------------------------
output "iam_account_password_policy_id" {
  description = "ID"
  value       = element(concat(aws_iam_account_password_policy.iam_account_password_policy.*.id, [""]), 0)
}
