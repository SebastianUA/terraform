#---------------------------------------------------
# AWS EMR cluster
#---------------------------------------------------
output "emr_cluster_arn" {
  description = "The ARN of the cluster."
  value       = element(concat(aws_emr_cluster.emr_cluster.*.arn, [""]), 0)
}

output "emr_cluster_name" {
  description = "The name of the cluster."
  value       = element(concat(aws_emr_cluster.emr_cluster.*.name, [""]), 0)
}

output "emr_cluster_id" {
  description = "The ID of the EMR Cluster"
  value       = element(concat(aws_emr_cluster.emr_cluster.*.id, [""]), 0)
}

output "emr_cluster_release_label" {
  description = "The release label for the Amazon EMR release."
  value       = element(concat(aws_emr_cluster.emr_cluster.*.release_label, [""]), 0)
}

output "emr_cluster_master_public_dns" {
  description = "The public DNS name of the master EC2 instance."
  value       = element(concat(aws_emr_cluster.emr_cluster.*.master_public_dns, [""]), 0)
}

output "emr_cluster_log_uri" {
  description = "The path to the Amazon S3 location where logs for this cluster are stored."
  value       = element(concat(aws_emr_cluster.emr_cluster.*.log_uri, [""]), 0)
}

output "emr_cluster_applications" {
  description = "The applications installed on this cluster."
  value       = element(concat(aws_emr_cluster.emr_cluster.*.applications, [""]), 0)
}

output "emr_cluster_ec2_attributes" {
  description = "Provides information about the EC2 instances in a cluster grouped by category: key name, subnet ID, IAM instance profile, and so on."
  value       = concat(aws_emr_cluster.emr_cluster.*.ec2_attributes, [""])
}

output "emr_cluster_bootstrap_action" {
  description = "A list of bootstrap actions that will be run before Hadoop is started on the cluster nodes."
  value       = concat(aws_emr_cluster.emr_cluster.*.bootstrap_action, [""])
}

output "emr_cluster_configurations" {
  description = "The list of Configurations supplied to the EMR cluster."
  value       = concat(aws_emr_cluster.emr_cluster.*.configurations, [""])
}

output "emr_cluster_service_role" {
  description = "The IAM role that will be assumed by the Amazon EMR service to access AWS resources on your behalf."
  value       = element(concat(aws_emr_cluster.emr_cluster.*.service_role, [""]), 0)
}

output "emr_cluster_visible_to_all_users" {
  description = "Indicates whether the job flow is visible to all IAM users of the AWS account associated with the job flow."
  value       = concat(aws_emr_cluster.emr_cluster.*.visible_to_all_users, [""])
}

output "emr_cluster_tags" {
  description = "The list of tags associated with a cluster."
  value       = concat(aws_emr_cluster.emr_cluster.*.tags, [""])
}

#---------------------------------------------------
# AWS EMR instance group
#---------------------------------------------------
output "emr_instance_group_id" {
  description = "The EMR Instance ID"
  value       = element(concat(aws_emr_instance_group.emr_instance_group.*.id, [""]), 0)
}

output "emr_instance_group_running_instance_count" {
  description = "The number of instances currently running in this instance group."
  value       = element(concat(aws_emr_instance_group.emr_instance_group.*.running_instance_count, [""]), 0)
}

output "emr_instance_group_status" {
  description = "The current status of the instance group."
  value       = element(concat(aws_emr_instance_group.emr_instance_group.*.status, [""]), 0)
}

#---------------------------------------------------
# AWS EMR security configuration
#---------------------------------------------------
output "emr_security_configuration_id" {
  description = "The ID of the EMR Security Configuration (Same as the name)"
  value       = element(concat(aws_emr_security_configuration.emr_security_configuration.*.id, [""]), 0)
}

output "emr_security_configuration_name" {
  description = "The Name of the EMR Security Configuration"
  value       = element(concat(aws_emr_security_configuration.emr_security_configuration.*.name, [""]), 0)
}

output "emr_security_configuration_configuration" {
  description = "The JSON formatted Security Configuration"
  value       = concat(aws_emr_security_configuration.emr_security_configuration.*.configuration, [""])
}

output "emr_security_configuration_creation_date" {
  description = "Date the Security Configuration was created"
  value       = element(concat(aws_emr_security_configuration.emr_security_configuration.*.creation_date, [""]), 0)
}
