#---------------------------------------------------
# AWS opsworks stack
#---------------------------------------------------
output "opsworks_stack_id" {
    description = "The id of the stack."
    value       = element(concat(aws_opsworks_stack.opsworks_stack.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks static web layer
#---------------------------------------------------
output "opsworks_static_web_layer_id" {
    description = "The id of the layer."
    value       = element(concat(aws_opsworks_static_web_layer.opsworks_static_web_layer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks custom layer
#---------------------------------------------------
output "opsworks_custom_layer_id" {
    description = "The id of the custom layer."
    value       = element(concat(aws_opsworks_custom_layer.opsworks_custom_layer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks ganglia layer
#---------------------------------------------------
output "opsworks_ganglia_layer_id" {
    description = "The id of the ganglia layer."
    value       = element(concat(aws_opsworks_ganglia_layer.opsworks_ganglia_layer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks haproxy layer
#---------------------------------------------------
output "opsworks_haproxy_layer_id" {
    description = "The id of the haproxy layer."
    value       = element(concat(aws_opsworks_haproxy_layer.opsworks_haproxy_layer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks memcached layer
#---------------------------------------------------
output "opsworks_memcached_layer_id" {
    description = "The id of the memcached layer."
    value       = element(concat(aws_opsworks_memcached_layer.opsworks_memcached_layer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks mysql layer
#---------------------------------------------------
output "opsworks_mysql_layer_id" {
    description = "The id of the mysql layer."
    value       = element(concat(aws_opsworks_mysql_layer.opsworks_mysql_layer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks java app layer
#---------------------------------------------------
output "opsworks_java_app_layer_id" {
    description = "The id of the java app layer."
    value       = element(concat(aws_opsworks_java_app_layer.opsworks_java_app_layer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks nodejs app layer
#---------------------------------------------------
output "opsworks_nodejs_app_layer_id" {
    description = "The id of the nodejs app layer."
    value       = element(concat(aws_opsworks_nodejs_app_layer.opsworks_nodejs_app_layer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks php app layer
#---------------------------------------------------
output "opsworks_php_app_layer_id" {
    description = "The id of the php app layer."
    value       = element(concat(aws_opsworks_php_app_layer.opsworks_php_app_layer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks rails app layer
#---------------------------------------------------
output "opsworks_rails_app_layer_id" {
    description = "The id of the rails app layer."
    value       = element(concat(aws_opsworks_rails_app_layer.opsworks_rails_app_layer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks user profile
#---------------------------------------------------
output "opsworks_user_profile_id" {
    description = "Same value as user_arn"
    value       = element(concat(aws_opsworks_user_profile.opsworks_user_profile.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks application
#---------------------------------------------------
output "opsworks_application_id" {
    description = "The id of the application."
    value       = element(concat(aws_opsworks_application.opsworks_application.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks instance
#---------------------------------------------------
output "opsworks_instance_id" {
    description = "The id of the OpsWorks instance."
    value       = element(concat(aws_opsworks_instance.opsworks_instance.*.id, [""]), 0)
}

output "opsworks_instance_agent_version" {
    description = "The AWS OpsWorks agent version."
    value       = element(concat(aws_opsworks_instance.opsworks_instance.*.agent_version, [""]), 0)
}

output "opsworks_instance_availability_zone" {
    description = "The availability zone of the instance."
    value       = element(concat(aws_opsworks_instance.opsworks_instance.*.availability_zone, [""]), 0)
}

output "opsworks_instance_ec2_instance_id" {
    description = "EC2 instance ID"
    value       = element(concat(aws_opsworks_instance.opsworks_instance.*.ec2_instance_id, [""]), 0)
}

output "opsworks_instance_ssh_key_name" {
    description = "The key name of the instance"
    value       = element(concat(aws_opsworks_instance.opsworks_instance.*.ssh_key_name, [""]), 0)
}

output "opsworks_instance_public_dns" {
    description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC."
    value       = element(concat(aws_opsworks_instance.opsworks_instance.*.public_dns, [""]), 0)
}

output "opsworks_instance_public_ip" {
    description = "The public IP address assigned to the instance, if applicable."
    value       = element(concat(aws_opsworks_instance.opsworks_instance.*.public_ip, [""]), 0)
}

output "opsworks_instance_private_dns" {
    description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
    value       = element(concat(aws_opsworks_instance.opsworks_instance.*.private_dns, [""]), 0)
}

output "opsworks_instance_private_ip" {
    description = "The private IP address assigned to the instance"
    value       = element(concat(aws_opsworks_instance.opsworks_instance.*.private_ip, [""]), 0)
}

output "opsworks_instance_subnet_id" {
    description = "The VPC subnet ID."
    value       = element(concat(aws_opsworks_instance.opsworks_instance.*.subnet_id, [""]), 0)
}

output "opsworks_instance_tenancy" {
    description = "The Instance tenancy"
    value       = element(concat(aws_opsworks_instance.opsworks_instance.*.tenancy, [""]), 0)
}

output "opsworks_instance_security_group_ids" {
    description = "The associated security groups."
    value       = element(concat(aws_opsworks_instance.opsworks_instance.*.security_group_ids, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks RDS db instance
#---------------------------------------------------
output "opsworks_rds_db_instance_id" {
    description = "The computed id. Please note that this is only used internally to identify the stack <-> instance relation. This value is not used in aws."
    value       = element(concat(aws_opsworks_rds_db_instance.opsworks_rds_db_instance.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS opsworks permission
#---------------------------------------------------
output "opsworks_permission_id" {
    description = "The computed id of the permission. Please note that this is only used internally to identify the permission. This value is not used in aws."
    value       = element(concat(aws_opsworks_permission.opsworks_permission.*.id, [""]), 0)
}