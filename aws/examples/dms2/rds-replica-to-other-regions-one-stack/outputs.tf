# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# AWS DMS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Source
# output "dms_replication_dms_certificate_id" {
#   value = module.dms_replication.dms_certificate_id
# }

# output "dms_replication_dms_certificate_certificate_arn" {
#   value = module.dms_replication.dms_certificate_certificate_arn
# }

# output "dms_replication_dms_endpoint_id" {
#   value = module.dms_replication.dms_endpoint_id
# }

# output "dms_replication_dms_endpoint_endpoint_arn" {
#   value = module.dms_replication.dms_endpoint_endpoint_arn
# }

output "dms_replication_dms_replication_subnet_group_id" {
  value = module.dms_replication.dms_replication_subnet_group_id
}

output "dms_replication_dms_replication_subnet_group_vpc_id" {
  value = module.dms_replication.dms_replication_subnet_group_vpc_id
}

output "dms_replication_dms_replication_instance_id" {
  value = module.dms_replication.dms_replication_instance_id
}

output "dms_replication_dms_replication_instance_replication_instance_arn" {
  value = module.dms_replication.dms_replication_instance_replication_instance_arn
}

output "dms_replication_dms_replication_instance_replication_instance_private_ips" {
  value = module.dms_replication.dms_replication_instance_replication_instance_private_ips
}

output "dms_replication_dms_replication_instance_replication_instance_public_ips" {
  value = module.dms_replication.dms_replication_instance_replication_instance_public_ips
}

# output "dms_replication_dms_replication_task_id" {
#   value = module.dms_replication.dms_replication_task_id
# }

# output "dms_replication_dms_replication_task_replication_task_arn" {
#   value = module.dms_replication.dms_replication_task_replication_task_arn
# }

# output "dms_replication_dms_event_subscription_id" {
#   value = module.dms_replication.dms_event_subscription_id
# }

# output "dms_replication_dms_event_subscription_arn" {
#   value = module.dms_replication.dms_event_subscription_arn
# }

# Targets


#---------------------------------------------------------------
# AWS SNS
#---------------------------------------------------------------
output "dms_sns_topic_arn" {
  value = module.dms_sns.sns_topic_arn
}

output "dms_sns_topic_id" {
  value = module.dms_sns.sns_topic_id
}