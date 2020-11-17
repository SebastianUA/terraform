output "aws_key_name" {
  description = "The key pair name."
  value       = aws_key_pair.key_pair_key_name.*.key_name
}

output "aws_key_id" {
  description = "The key pair id."
  value       = aws_key_pair.key_pair_key_name.*.id
}

output "aws_key_fingerprint" {
  description = "The MD5 public key fingerprint as specified in section 4 of RFC 4716."
  value       = aws_key_pair.key_pair_key_name.*.fingerprint
}
