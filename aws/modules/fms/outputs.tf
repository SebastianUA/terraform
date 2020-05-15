#---------------------------------------------------
# AWS fms admin account
#---------------------------------------------------
output "fms_admin_account_id" {
  description = "The AWS account ID of the AWS Firewall Manager administrator account."
  value       = element(concat(aws_fms_admin_account.fms_admin_account.*.id, [""]), 0)
}
