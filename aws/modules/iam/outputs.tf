#-----------------------------------------------------------
# IAM role
#-----------------------------------------------------------
output "role_arn" {
	description = ""
    value       = "${element(concat(aws_iam_role.iam_role.*.arn, list("")), 0)}"
}		

output "role_name" {
	description = ""
    value       = "${element(concat(aws_iam_role.iam_role.*.name, list("")), 0)}"
}

output "role_id" {
	description = ""
    value       = "${element(concat(aws_iam_role.iam_role.*.id, list("")), 0)}"
}

#-----------------------------------------------------------
# IAM policy
#-----------------------------------------------------------
output "policy_name" {
	description = ""
    value       = "${element(concat(aws_iam_policy.iam_policy.*.name, list("")), 0)}"
}

output "policy_arn" {
    description = ""
    value       = "${element(concat(aws_iam_policy.iam_policy.*.arn, list("")), 0)}"
}

#-----------------------------------------------------------
# IAM instance profile
#-----------------------------------------------------------
output "instance_profile_id" {
	description = ""
    value       = "${element(concat(aws_iam_instance_profile.iam_instance_profile.*.id, list("")), 0)}"
}

output "instance_profile_uid" {
	description = ""
    value       = "${element(concat(aws_iam_instance_profile.iam_instance_profile.*.unique_id, list("")), 0)}"
}

output "instance_profile_arn" {
    description = ""
    value       = "${element(concat(aws_iam_instance_profile.iam_instance_profile.*.unique_id, list("")), 0)}"
}
#-----------------------------------------------------------
# IAM cross acc assume role
#-----------------------------------------------------------
output "cross_account_assume_role_arns" {
	description = ""
    value       = "${element(concat(aws_iam_role.cross_account_assume_role.*.arn, list("")), 0)}"
}

#-----------------------------------------------------------
# IAM user
#-----------------------------------------------------------
output "aws_iam_user_arn" {
	description = "The ARN assigned by AWS for this user."
    value       = "${element(concat(aws_iam_user.iam_user.*.arn, list("")), 0)}"
}

output "aws_iam_user_name" {
	description = "The user's name."
    value       = "${element(concat(aws_iam_user.iam_user.*.name, list("")), 0)}"
}

output "aws_iam_user_unique_id" {
	description = "The unique ID assigned by AWS."
    value       = "${element(concat(aws_iam_user.iam_user.*.unique_id, list("")), 0)}"
}

#-----------------------------------------------------------
# IAM user policy
#-----------------------------------------------------------
output "iam_user_policy_name" {
	description = "The name of the policy (always set)."
    value       = "${element(concat(aws_iam_user_policy.iam_user_policy.*.name, list("")), 0)}"
}

output "iam_user_policy_id" {
	description = "The user policy ID, in the form of user_name:user_policy_name."
    value       = "${element(concat(aws_iam_user_policy.iam_user_policy.*.id, list("")), 0)}"
}

#-----------------------------------------------------------
# IAM user ssh key
#-----------------------------------------------------------
output "iam_user_ssh_key_ssh_public_key_id" {
    description = "The unique identifier for the SSH public key."
    value       = "${element(concat(aws_iam_user_ssh_key.iam_user_ssh_key.*.ssh_public_key_id, list("")), 0)}"
}

output "iam_user_ssh_key_fingerprint" {
    description = "The MD5 message digest of the SSH public key."
    value       = "${element(concat(aws_iam_user_ssh_key.iam_user_ssh_key.*.fingerprint, list("")), 0)}"
}

#-----------------------------------------------------------
# IAM access key
#-----------------------------------------------------------
output "iam_access_key_id" {
    description = "The access key ID"
    value       = "${element(concat(
      aws_iam_access_key.iam_access_key.*.id,
      aws_iam_access_key.iam_access_key_no_pgp.*.id,
      list(""),), 0,)}"
}

output "iam_access_key_user" {
    description = "The IAM user associated with this access key."
    value       = "${element(concat(aws_iam_access_key.iam_access_key.*.user, list("")), 0)}"
}

output "iam_access_key_key_fingerprint" {
    description = "The fingerprint of the PGP key used to encrypt the secret"
    value       = "${element(concat(aws_iam_access_key.iam_access_key.*.key_fingerprint, list("")), 0)}"
}

output "iam_access_key_secret" {
    description = "The secret access key. Note that this will be written to the state file. Please supply a pgp_key instead, which will prevent the secret from being stored in plain text"
    value       = "${element(concat(
        aws_iam_access_key.iam_access_key.*.pgp_key, 
        aws_iam_access_key.iam_access_key_no_pgp.*.pgp_key,
        list(""),), 0,)}"
}

output "iam_access_key_encrypted_secret" {
    description = "The encrypted secret, base64 encoded. ~> NOTE: The encrypted secret may be decrypted using the command line, for example: terraform output encrypted_secret | base64 --decode | keybase pgp decrypt."
    value       = "${element(concat(
        aws_iam_access_key.iam_access_key.*.encrypted_secret, 
        aws_iam_access_key.iam_access_key_no_pgp.*.encrypted_secret,
        list(""),), 0,)}"
}

output "keybase_password_decrypt_command" {
    description = ""
    value = <<EOF
echo "${element(concat(aws_iam_user_login_profile.iam_user_login_profile.*.encrypted_password, list(""),), 0,)}" | base64 --decode | keybase pgp decrypt
EOF

}

output "keybase_password_pgp_message" {
    value = <<EOF
-----BEGIN PGP MESSAGE-----
Version: Keybase OpenPGP v2.0.76
Comment: https://keybase.io/crypto
"${element(concat(aws_iam_user_login_profile.iam_user_login_profile.*.encrypted_password, list(""),), 0,)}"
-----END PGP MESSAGE-----
EOF

}

output "keybase_secret_key_decrypt_command" {
    value = <<EOF
echo "${element(concat(aws_iam_access_key.iam_access_key.*.encrypted_secret, aws_iam_access_key.iam_access_key_no_pgp.*.encrypted_secret, list(""),), 0,)}" | base64 --decode | keybase pgp decrypt
EOF

}

output "keybase_secret_key_pgp_message" {
    value = <<EOF
-----BEGIN PGP MESSAGE-----
Version: Keybase OpenPGP v2.0.76
Comment: https://keybase.io/crypto
"${element(concat(aws_iam_access_key.iam_access_key.*.encrypted_secret, aws_iam_access_key.iam_access_key_no_pgp.*.encrypted_secret, list(""),), 0,)}"
-----END PGP MESSAGE-----
EOF

}

output "iam_access_key_ses_smtp_password" {
    description = "The secret access key converted into an SES SMTP password by applying AWS's documented conversion algorithm."
    value       = "${element(concat(
        aws_iam_access_key.iam_access_key.*.ses_smtp_password, 
        aws_iam_access_key.iam_access_key_no_pgp.*.ses_smtp_password,
        list(""),), 0,)}"
}

#-----------------------------------------------------------
# IAM user login profile
#-----------------------------------------------------------
output "iam_user_login_profile_key_fingerprint" {
    description = "The fingerprint of the PGP key used to encrypt the password. Only available if password was handled on Terraform resource creation, not import."
    value       = "${element(concat(aws_iam_user_login_profile.iam_user_login_profile.*.key_fingerprint, list("")), 0)}"
}

output "iam_user_login_profile_encrypted_password" {
    description = "The encrypted password, base64 encoded. Only available if password was handled on Terraform resource creation, not import. NOTE: The encrypted password may be decrypted using the command line, for example: terraform output password | base64 --decode | keybase pgp decrypt."
    value       = "${element(concat(aws_iam_user_login_profile.iam_user_login_profile.*.encrypted_password, list("")), 0)}"
}

#-----------------------------------------------------------
# AIM user group membership
#-----------------------------------------------------------
output "iam_user_group_membership_user" {
    description = "The name of the IAM User"
    value       = "${element(concat(aws_iam_user_group_membership.iam_user_group_membership.*.user, list("")), 0)}"
}

output "iam_user_group_membership_groups" {
    description = "The list of IAM Groups"
    value       = ["${aws_iam_user_group_membership.iam_user_group_membership.*.groups}"]
}
 
