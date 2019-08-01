#---------------------------------------------------
# aws_msk_cluster
#---------------------------------------------------
output "zookeeper_connect_string" {
	description = ""
  	value 		= "${aws_msk_cluster.msk_cluster_default.*.zookeeper_connect_string}"
}

output "bootstrap_brokers" {
  description = "Plaintext connection host:port pairs"
  value       = "${aws_msk_cluster.msk_cluster_default.*.bootstrap_brokers}"
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = "${aws_msk_cluster.msk_cluster_default.*.bootstrap_brokers_tls}"
}

output "msk_cluster_encryption_and_authentication_zookeeper_connect_string" {
  description = ""
    value     = "${aws_msk_cluster.msk_cluster_encryption_and_authentication.*.zookeeper_connect_string}"
}

output "msk_cluster_encryption_and_authentication_bootstrap_brokers" {
  description = "Plaintext connection host:port pairs"
  value       = "${aws_msk_cluster.msk_cluster_encryption_and_authentication.*.bootstrap_brokers}"
}

output "msk_cluster_encryption_and_authentication_bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = "${aws_msk_cluster.msk_cluster_encryption_and_authentication.*.bootstrap_brokers_tls}"
}

#---------------------------------------------------
# AWS msk configuration
#---------------------------------------------------
output "msk_configuration_arn" {
    description = "Amazon Resource Name (ARN) of the configuration."
    value       = "${aws_msk_configuration.msk_configuration.*.arn}"
}

output "msk_configuration_latest_revision" {
    description = "Latest revision of the configuration."
    value       = "${aws_msk_configuration.msk_configuration.*.latest_revision}"
}
