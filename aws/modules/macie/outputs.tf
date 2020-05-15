#---------------------------------------------------
# AWS macie member account association
#---------------------------------------------------
output "macie_member_account_association_id" {
  description = "The ID of the association."
  value       = element(concat(aws_macie_member_account_association.macie_member_account_association.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS macie s3 bucket association
#---------------------------------------------------
output "macie_s3_bucket_association_id" {
  description = "The ID of the association."
  value       = element(concat(aws_macie_s3_bucket_association.macie_s3_bucket_association.*.id, [""]), 0)
}
