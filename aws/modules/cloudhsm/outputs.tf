#---------------------------------------------------
# AWS cloudhsm v2 cluster
#---------------------------------------------------
output "cloudhsm_v2_cluster_id" {
  description = "The id of the CloudHSM cluster."
  value       = element(concat(aws_cloudhsm_v2_cluster.cloudhsm_v2_cluster.*.cluster_id, [""], ), 0)
}

output "cloudhsm_v2_cluster_state" {
  description = "The state of the cluster."
  value       = element(concat(aws_cloudhsm_v2_cluster.cloudhsm_v2_cluster.*.cluster_state, [""], ), 0)
}

output "cloudhsm_v2_cluster_vpc_id" {
  description = "The id of the VPC that the CloudHSM cluster resides in."
  value       = element(concat(aws_cloudhsm_v2_cluster.cloudhsm_v2_cluster.*.vpc_id, [""], ), 0)
}

output "cloudhsm_v2_cluster_security_group_id" {
  description = "The ID of the security group associated with the CloudHSM cluster."
  value       = element(concat(aws_cloudhsm_v2_cluster.cloudhsm_v2_cluster.*.security_group_id, [""], ), 0)
}

#---------------------------------------------------
# AWS cloudhsm v2 hsm
#---------------------------------------------------
output "cloudhsm_v2_hsm_id" {
  description = "The id of the HSM module."
  value       = element(concat(aws_cloudhsm_v2_hsm.cloudhsm_v2_hsm.*.hsm_id, [""], ), 0)
}

output "cloudhsm_v2_hsm_state" {
  description = "The state of the HSM module."
  value       = element(concat(aws_cloudhsm_v2_hsm.cloudhsm_v2_hsm.*.hsm_state, [""], ), 0)
}

output "cloudhsm_v2_hsm_eni_id" {
  description = "The id of the ENI interface allocated for HSM module."
  value       = element(concat(aws_cloudhsm_v2_hsm.cloudhsm_v2_hsm.*.hsm_eni_id, [""], ), 0)
}
