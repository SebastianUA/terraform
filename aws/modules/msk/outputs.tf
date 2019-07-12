#---------------------------------------------------
# aws_msk_cluster
#---------------------------------------------------
output "zookeeper_connect_string" {
  value = "${aws_msk_cluster.msk_cluster.0.zookeeper_connect_string}"
}

output "bootstrap_brokers" {
  description = "Plaintext connection host:port pairs"
  value       = "${aws_msk_cluster.msk_cluster.0.bootstrap_brokers}"
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = "${aws_msk_cluster.msk_cluster.0.bootstrap_brokers_tls}"
}
