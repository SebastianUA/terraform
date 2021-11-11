#-----------------------------------------------------------
# AWS key_pair
#-----------------------------------------------------------
output "aws_key_name" {
  description = "The key pair name."
  value       = element(concat(aws_key_pair.key_pair.*.key_name, [""]), 0)
}

output "aws_key_id" {
  description = "The key pair id."
  value       = element(concat(aws_key_pair.key_pair.*.id, [""]), 0)
}

output "aws_key_fingerprint" {
  description = "The MD5 public key fingerprint as specified in section 4 of RFC 4716."
  value       = element(concat(aws_key_pair.key_pair.*.fingerprint, [""]), 0)
}
