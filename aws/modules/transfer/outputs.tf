#---------------------------------------------------
# AWS Transfer server
#---------------------------------------------------
output "transfer_server_id" {
    description = "The Server ID of the Transfer Server (e.g. s-12345678)"
    value       = element(concat(aws_transfer_server.transfer_server.*.id, [""]), 0)
}

output "transfer_server_arn" {
    description = "Amazon Resource Name (ARN) of Transfer Server"
    value       = element(concat(aws_transfer_server.transfer_server.*.arn, [""]), 0)
}

output "transfer_server_endpoint" {
    description = "The endpoint of the Transfer Server (e.g. s-12345678.server.transfer.REGION.amazonaws.com)"
    value       = element(concat(aws_transfer_server.transfer_server.*.endpoint, [""]), 0)
}

output "transfer_server_host_key_fingerprint" {
    description = "This value contains the message-digest algorithm (MD5) hash of the server's host key. This value is equivalent to the output of the ssh-keygen -l -E md5 -f my-new-server-key command."
    value       = element(concat(aws_transfer_server.transfer_server.*.host_key_fingerprint, [""]), 0)
}

#---------------------------------------------------
# AWS Transfer user
#---------------------------------------------------
output "transfer_user_id" {
    description = "The Server ID of the Transfer user"
    value       = element(concat(aws_transfer_user.transfer_user.*.id, [""]), 0)
}

output "transfer_user_arn" {
    description = "Amazon Resource Name (ARN) of Transfer User"
    value       = element(concat(aws_transfer_user.transfer_user.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS Transfer ssh key
#---------------------------------------------------
output "transfer_ssh_key_id" {
    description = "The Server ID of the Transfer ssh key"
    value       = element(concat(aws_transfer_ssh_key.transfer_ssh_key.*.id, [""]), 0)
}
