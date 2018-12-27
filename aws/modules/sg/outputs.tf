#---------------------------------------------------------------
# VPC
#---------------------------------------------------------------
output "vpc_id" {
    description = "VPC ID"
    #value       = "${aws_security_group.sg.vpc_id}"
    value       = "${element(concat(aws_security_group.sg.*.vpc_id, list("")), 0)}"
}
#---------------------------------------------------------------
# Security group
#---------------------------------------------------------------

output "security_group_id" {
    description = ""
    value       = "${element(concat(aws_security_group.sg.*.id, list("")), 0)}"
    
}       
