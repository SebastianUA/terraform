#---------------------------------------------------
# AWS ram resource share
#---------------------------------------------------
output "ram_resource_share_id" {
  description = "The Amazon Resource Name (ARN) of the resource share."
  value       = element(concat(aws_ram_resource_share.ram_resource_share.*.id, [""]), 0)
}

output "ram_resource_share_arn" {
  description = "The Amazon Resource Name (ARN) of the resource share."
  value       = element(concat(aws_ram_resource_share.ram_resource_share.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS ram resource share accepter
#---------------------------------------------------
output "ram_resource_association_id" {
  description = "The Amazon Resource Name (ARN) of the resource share."
  value       = element(concat(aws_ram_resource_association.ram_resource_association.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS ram principal association
#---------------------------------------------------
output "ram_principal_association_id" {
  description = "The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma."
  value       = element(concat(aws_ram_principal_association.ram_principal_association.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS ram resource share accepter
#---------------------------------------------------
output "ram_resource_share_accepter_id" {
  description = "The ID of RAM resource share accepter"
  value       = aws_ram_resource_share_accepter.ram_resource_share_accepter.*.id
}

output "ram_resource_share_accepter_invitation_arn" {
  description = "The ARN of the resource share invitation."
  value       = element(concat(aws_ram_resource_share_accepter.ram_resource_share_accepter.*.invitation_arn, [""]), 0)
}

output "ram_resource_share_accepter_share_id" {
  description = "The ID of the resource share as displayed in the console."
  value       = element(concat(aws_ram_resource_share_accepter.ram_resource_share_accepter.*.share_id, [""]), 0)
}

output "ram_resource_share_accepter_status" {
  description = "The status of the resource share (ACTIVE, PENDING, FAILED, DELETING, DELETED)."
  value       = element(concat(aws_ram_resource_share_accepter.ram_resource_share_accepter.*.status, [""]), 0)
}

output "ram_resource_share_accepter_receiver_account_id" {
  description = "The account ID of the receiver account which accepts the invitation."
  value       = element(concat(aws_ram_resource_share_accepter.ram_resource_share_accepter.*.receiver_account_id, [""]), 0)
}

output "ram_resource_share_accepter_sender_account_id" {
  description = "The account ID of the sender account which submits the invitation."
  value       = element(concat(aws_ram_resource_share_accepter.ram_resource_share_accepter.*.sender_account_id, [""]), 0)
}

output "ram_resource_share_accepter_share_name" {
  description = "The name of the resource share."
  value       = element(concat(aws_ram_resource_share_accepter.ram_resource_share_accepter.*.share_name, [""]), 0)
}

output "ram_resource_share_accepter_resources" {
  description = "A list of the resource ARNs shared via the resource share."
  value       = aws_ram_resource_share_accepter.ram_resource_share_accepter.*.resources
}