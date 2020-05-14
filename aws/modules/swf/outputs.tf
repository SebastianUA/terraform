#---------------------------------------------------
# AWS swf domain
#---------------------------------------------------
output "swf_domain_id" {
    description = "The name of the domain."
    value       = element(concat(aws_swf_domain.swf_domain.*.id, [""]), 0)
}

output "swf_domain_arn" {
    description = "Amazon Resource Name (ARN)"
    value       = element(concat(aws_swf_domain.swf_domain.*.arn, [""]), 0)
}
