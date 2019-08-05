#output "iam_user_login_profile_key_PW" {
#    description = ""
#    value       = "${module.iam_user_login_profile.iam_user_login_profile_encrypted_password}"
#}

output "KB_password_decrypt_command" {
    description = ""
    value       = "${module.iam_user_login_profile.keybase_password_decrypt_command}"
}

output "iam_access_key_ID" {
    description = ""
    value       = "${module.iam_access_key.iam_access_key_id}"
}

output "KB_secret_key_decrypt_command" {
    description = ""
    value       = "${module.iam_access_key.keybase_secret_key_decrypt_command}"
}
 
#output "iam_access_key_SECRET" {
#    description = ""
#    value       = "${module.iam_access_key.iam_access_key_secret}"
#}

#output "iam_access_key_ENC_SECRET" {
#    description = ""
#    value       = "${module.iam_access_key.iam_access_key_encrypted_secret}"
#}
