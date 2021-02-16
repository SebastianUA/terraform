#---------------------------------------------------
# aws_msk_cluster
#---------------------------------------------------
output "msk_cluster_id" {
  description = "Amazon Resource Name (ID) of the MSK cluster."
  value       = element(concat(aws_msk_cluster.msk_cluster.*.id, [""]), 0)
}

output "msk_cluster_arn" {
  description = "Amazon Resource Name (ARN) of the MSK cluster."
  value       = element(concat(aws_msk_cluster.msk_cluster.*.arn, [""]), 0)
}

output "msk_cluster_zookeeper_connect_string" {
  description = ""
  value       = concat(aws_msk_cluster.msk_cluster.*.zookeeper_connect_string, [""])
}

output "msk_cluster_bootstrap_brokers" {
  description = "Plaintext connection host:port pairs"
  value       = concat(aws_msk_cluster.msk_cluster.*.bootstrap_brokers, [""])
}

output "msk_cluster_bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = concat(aws_msk_cluster.msk_cluster.*.bootstrap_brokers_tls, [""])
}

output "msk_cluster_encryption_info" {
  description = "Outputs list with encryption info"
  value       = concat(aws_msk_cluster.msk_cluster.*.encryption_info, [""])
}

output "msk_cluster_current_version" {
  description = "Current version of the MSK Cluster used for updates, e.g. K13V1IB3VIYZZH"
  value       = concat(aws_msk_cluster.msk_cluster.*.current_version, [""])
}

#---------------------------------------------------
# AWS msk configuration
#---------------------------------------------------
output "msk_configuration_id" {
  description = "Amazon Resource Name (ID) of the configuration."
  value       = element(concat(aws_msk_configuration.msk_configuration.*.id, [""]), 0)
}

output "msk_configuration_arn" {
  description = "Amazon Resource Name (ARN) of the configuration."
  value       = element(concat(aws_msk_configuration.msk_configuration.*.arn, [""]), 0)
}

output "msk_configuration_latest_revision" {
  description = "Latest revision of the configuration."
  value       = element(concat(aws_msk_configuration.msk_configuration.*.latest_revision, [""]), 0)
}

#---------------------------------------------------
# Create aws msk scram secret association
#---------------------------------------------------
output "msk_scram_secret_association_id" {
  description = "Amazon Resource Name (ARN) of the MSK cluster."
  value       = element(concat(aws_msk_scram_secret_association.msk_scram_secret_association.*.id, [""]), 0)
}
