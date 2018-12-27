output "iam_role_name" {
    description = "IAM role"
    value       = "${module.iam.role_name}"
}

output "vpc-id" {
    description = "VPC ID"
    value       = "${module.vpc.vpc_id}"
}

output "vpc_cidr" {
    description = "VPC CIDR"
    value       = "${module.vpc.vpc_cidr_block}"
}

output "vpc_privatesubnets" {
    description = "Private CIDRs"
    value       = "${module.vpc.vpc-privatesubnets}"
}

output "vpc_publicsubnets" {
    description = "Public CIDRs"
    value       = "${module.vpc.vpc-publicsubnets}"
}

output "vpc-internet-gateway" {
    description = "Igt"
    value       = "${module.vpc.gateway_id}"
}

output "nat_eip_public_ip" {
    description = ""
    value       = "${module.vpc.nat_eip_public_ips}"
}

