#-----------------------------------------------------------
# IAM user
#-----------------------------------------------------------
output "iam_user_arn" {
	description = "The ARN assigned by AWS for this user."
    value       = element(concat(aws_iam_user.iam_user.*.arn, [""]), 0)
}

output "iam_user_name" {
	description = "The user's name."
    value       = element(concat(aws_iam_user.iam_user.*.name, [""]), 0)
}

output "iam_user_unique_id" {
	description = "The unique ID assigned by AWS."
    value       = element(concat(aws_iam_user.iam_user.*.unique_id, [""]), 0)
}

#-----------------------------------------------------------
# IAM user policy
#-----------------------------------------------------------
output "iam_user_policy_name" {
	description = "The name of the policy (always set)."
    value       = element(concat(aws_iam_user_policy.iam_user_policy.*.name, [""]), 0)
}

output "iam_user_policy_id" {
	description = "The user policy ID, in the form of user_name:user_policy_name."
    value       = element(concat(aws_iam_user_policy.iam_user_policy.*.id, [""]), 0)
}

#-----------------------------------------------------------
# IAM user policy attachment
#-----------------------------------------------------------
output "iam_user_policy_attachment_id" {
	description = "ID"
    value       = element(concat(aws_iam_user_policy_attachment.iam_user_policy_attachment.*.id, [""]), 0)
}

#-----------------------------------------------------------
# IAM user ssh key
#-----------------------------------------------------------
output "iam_user_ssh_key_ssh_public_key_id" {
    description = "The unique identifier for the SSH public key."
    value       = element(concat(aws_iam_user_ssh_key.iam_user_ssh_key.*.ssh_public_key_id, [""]), 0)
}

output "iam_user_ssh_key_fingerprint" {
    description = "The MD5 message digest of the SSH public key."
    value       = element(concat(aws_iam_user_ssh_key.iam_user_ssh_key.*.fingerprint, [""]), 0)
}

#-----------------------------------------------------------
# IAM user login profile
#-----------------------------------------------------------
output "iam_user_login_profile_key_fingerprint" {
    description = "The fingerprint of the PGP key used to encrypt the password. Only available if password was handled on Terraform resource creation, not import."
    value       = element(concat(aws_iam_user_login_profile.iam_user_login_profile.*.key_fingerprint, [""]), 0)
}

output "iam_user_login_profile_encrypted_password" {
    description = "The encrypted password, base64 encoded. Only available if password was handled on Terraform resource creation, not import. NOTE: The encrypted password may be decrypted using the command line, for example: terraform output password | base64 --decode | keybase pgp decrypt."
    value       = element(concat(aws_iam_user_login_profile.iam_user_login_profile.*.encrypted_password, [""]), 0)
}

#-----------------------------------------------------------
# AIM user group membership
#-----------------------------------------------------------
output "iam_user_group_membership_user" {
    description = "The name of the IAM User"
    value       = element(concat(aws_iam_user_group_membership.iam_user_group_membership.*.user, [""]), 0)
}

output "iam_user_group_membership_groups" {
    description = "The list of IAM Groups"
    value       = aws_iam_user_group_membership.iam_user_group_membership.*.groups
}
