#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks."
  default     = {}
}

#---------------------------------------------------
# AWS opsworks stack
#---------------------------------------------------
variable "enable_opsworks_stack" {
  description = "Enable opsworks stack usage"
  default     = false
}

variable "opsworks_stack_name" {
  description = "The name of the stack."
  default     = ""
}

variable "opsworks_stack_service_role_arn" {
  description = "(Required) The ARN of an IAM role that the OpsWorks service will act as."
  default     = ""
}

variable "opsworks_stack_default_instance_profile_arn" {
  description = "(Required) The ARN of an IAM Instance Profile that created instances will have by default."
  default     = ""
}

variable "opsworks_stack_agent_version" {
  description = "(Optional) If set to 'LATEST', OpsWorks will automatically install the latest version."
  default     = "LATEST"
}

variable "opsworks_stack_berkshelf_version" {
  description = "(Optional) If manage_berkshelf is enabled, the version of Berkshelf to use."
  default     = null
}

variable "opsworks_stack_configuration_manager_name" {
  description = "(Optional) Name of the configuration manager to use. Defaults to 'Chef'."
  default     = "Chef"
}

variable "opsworks_stack_configuration_manager_version" {
  description = "(Optional) Version of the configuration manager to use (11.10 or 12 for now). Defaults to 12."
  default     = "11.10"
}

variable "opsworks_stack_custom_cookbooks_source" {
  description = "(Optional) When use_custom_cookbooks is set, provide this sub-object"
  default     = []
}

variable "opsworks_stack_custom_json" {
  description = "(Optional) Custom JSON attributes to apply to the entire stack."
  default     = null
}

variable "opsworks_stack_default_availability_zone" {
  description = "(Optional) Name of the availability zone where instances will be created by default. This is required unless you set vpc_id"
  default     = null
}

variable "opsworks_stack_default_os" {
  description = "(Optional) Name of OS that will be installed on instances by default."
  default     = null
}

variable "opsworks_stack_default_root_device_type" {
  description = "(Optional) Name of the type of root device instances will have by default."
  default     = null
}

variable "opsworks_stack_default_ssh_key_name" {
  description = "(Optional) Name of the SSH keypair that instances will have by default."
  default     = null
}

variable "opsworks_stack_default_subnet_id" {
  description = "(Optional) Id of the subnet in which instances will be created by default. Mandatory if vpc_id is set, and forbidden if it isn't."
  default     = null
}

variable "opsworks_stack_manage_berkshelf" {
  description = "(Optional) Boolean value controlling whether Opsworks will run Berkshelf for this stack."
  default     = null
}

variable "opsworks_stack_hostname_theme" {
  description = "(Optional) Keyword representing the naming scheme that will be used for instance hostnames within this stack."
  default     = null
}

variable "opsworks_stack_color" {
  description = "(Optional) Color to paint next to the stack's resources in the OpsWorks console."
  default     = null
}

variable "opsworks_stack_use_custom_cookbooks" {
  description = "(Optional) Boolean value controlling whether the custom cookbook settings are enabled."
  default     = null
}

variable "opsworks_stack_use_opsworks_security_groups" {
  description = "(Optional) Boolean value controlling whether the standard OpsWorks security groups apply to created instances."
  default     = null
}

variable "opsworks_stack_vpc_id" {
  description = "(Optional) The id of the VPC that this stack belongs to."
  default     = null
}

#---------------------------------------------------
# AWS opsworks static web layer
#---------------------------------------------------
variable "enable_opsworks_static_web_layer" {
  description = "Enable opsworks static web layer usage"
  default     = false
}

variable "opsworks_static_web_layer_stack_id" {
  description = "The id of the stack the layer will belong to."
  default     = ""
}

variable "opsworks_static_web_layer_name" {
  description = "(Optional) A human-readable name for the layer."
  default     = ""
}

variable "opsworks_static_web_layer_auto_assign_elastic_ips" {
  description = "(Optional) Whether to automatically assign an elastic IP address to the layer's instances."
  default     = null
}

variable "opsworks_static_web_layer_auto_assign_public_ips" {
  description = "(Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances."
  default     = null
}

variable "opsworks_static_web_layer_custom_instance_profile_arn" {
  description = "(Optional) The ARN of an IAM profile that will be used for the layer's instances."
  default     = null
}

variable "opsworks_static_web_layer_custom_security_group_ids" {
  description = "(Optional) Ids for a set of security groups to apply to the layer's instances."
  default     = null
}

variable "opsworks_static_web_layer_auto_healing" {
  description = "(Optional) Whether to enable auto-healing for the layer."
  default     = null
}

variable "opsworks_static_web_layer_install_updates_on_boot" {
  description = "(Optional) Whether to install OS and package updates on each instance when it boots."
  default     = null
}

variable "opsworks_static_web_layer_instance_shutdown_timeout" {
  description = " (Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event."
  default     = null
}

variable "opsworks_static_web_layer_elastic_load_balancer" {
  description = "(Optional) Name of an Elastic Load Balancer to attach to this layer"
  default     = null
}

variable "opsworks_static_web_layer_drain_elb_on_shutdown" {
  description = "(Optional) Whether to enable Elastic Load Balancing connection draining."
  default     = null
}

variable "opsworks_static_web_layer_system_packages" {
  description = "(Optional) Names of a set of system packages to install on the layer's instances."
  default     = null
}

variable "opsworks_static_web_layer_use_ebs_optimized_instances" {
  description = "(Optional) Whether to use EBS-optimized instances."
  default     = null
}

variable "opsworks_static_web_layer_custom_configure_recipes" {
  description = ""
  default     = null
}

variable "opsworks_static_web_layer_custom_deploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_static_web_layer_custom_setup_recipes" {
  description = ""
  default     = null
}

variable "opsworks_static_web_layer_custom_shutdown_recipes" {
  description = ""
  default     = null
}

variable "opsworks_static_web_layer_custom_undeploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_static_web_layer_ebs_volume" {
  description = "(Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances."
  default     = []
}

#---------------------------------------------------
# AWS opsworks custom layer
#---------------------------------------------------
variable "enable_opsworks_custom_layer" {
  description = "Enable opsworks custom layer usage"
  default     = false
}

variable "opsworks_custom_layer_name" {
  description = "A human-readable name for the layer."
  default     = ""
}

variable "opsworks_custom_layer_short_name" {
  description = "A short, machine-readable name for the layer, which will be used to identify it in the Chef node JSON."
  default     = ""
}

variable "opsworks_custom_layer_stack_id" {
  description = "The id of the stack the layer will belong to."
  default     = ""
}

variable "opsworks_custom_layer_auto_assign_elastic_ips" {
  description = "(Optional) Whether to automatically assign an elastic IP address to the layer's instances."
  default     = null
}

variable "opsworks_custom_layer_auto_assign_public_ips" {
  description = "(Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances."
  default     = null
}

variable "opsworks_custom_layer_custom_instance_profile_arn" {
  description = "(Optional) The ARN of an IAM profile that will be used for the layer's instances."
  default     = null
}

variable "opsworks_custom_layer_custom_security_group_ids" {
  description = "(Optional) Ids for a set of security groups to apply to the layer's instances."
  default     = null
}

variable "opsworks_custom_layer_auto_healing" {
  description = "(Optional) Whether to enable auto-healing for the layer."
  default     = null
}

variable "opsworks_custom_layer_install_updates_on_boot" {
  description = "(Optional) Whether to install OS and package updates on each instance when it boots."
  default     = null
}

variable "opsworks_custom_layer_instance_shutdown_timeout" {
  description = "(Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event."
  default     = null
}

variable "opsworks_custom_layer_elastic_load_balancer" {
  description = "(Optional) Name of an Elastic Load Balancer to attach to this layer"
  default     = null
}

variable "opsworks_custom_layer_drain_elb_on_shutdown" {
  description = "(Optional) Whether to enable Elastic Load Balancing connection draining."
  default     = null
}

variable "opsworks_custom_layer_system_packages" {
  description = "(Optional) Names of a set of system packages to install on the layer's instances."
  default     = null
}

variable "opsworks_custom_layer_use_ebs_optimized_instances" {
  description = "(Optional) Whether to use EBS-optimized instances."
  default     = null
}

variable "opsworks_custom_layer_ebs_volume" {
  description = "(Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances."
  default     = []
}

variable "opsworks_custom_layer_custom_json" {
  description = " (Optional) Custom JSON attributes to apply to the layer."
  default     = null
}

variable "opsworks_custom_layer_custom_configure_recipes" {
  description = ""
  default     = null
}

variable "opsworks_custom_layer_custom_deploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_custom_layer_custom_setup_recipes" {
  description = ""
  default     = null
}

variable "opsworks_custom_layer_custom_shutdown_recipes" {
  description = ""
  default     = null
}

variable "opsworks_custom_layer_custom_undeploy_recipes" {
  description = ""
  default     = null
}

#---------------------------------------------------
# AWS opsworks ganglia layer
#---------------------------------------------------
variable "enable_opsworks_ganglia_layer" {
  description = "Enable opsworks ganglia layer usage"
  default     = false
}

variable "opsworks_ganglia_layer_name" {
  description = "A human-readable name for the layer."
  default     = ""
}

variable "opsworks_ganglia_layer_stack_id" {
  description = "The id of the stack the layer will belong to."
  default     = ""
}

variable "opsworks_ganglia_layer_password" {
  description = "(Required) The password to use for Ganglia."
  default     = ""
}

variable "opsworks_ganglia_layer_url" {
  description = "(Optional) The URL path to use for Ganglia. Defaults to '/ganglia'."
  default     = "/ganglia"
}

variable "opsworks_ganglia_layer_username" {
  description = "(Optiona) The username to use for Ganglia. Defaults to 'opsworks'."
  default     = "opsworks"
}

variable "opsworks_ganglia_layer_auto_assign_elastic_ips" {
  description = "(Optional) Whether to automatically assign an elastic IP address to the layer's instances."
  default     = null
}

variable "opsworks_ganglia_layer_auto_assign_public_ips" {
  description = "(Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances."
  default     = null
}

variable "opsworks_ganglia_layer_custom_instance_profile_arn" {
  description = "(Optional) The ARN of an IAM profile that will be used for the layer's instances."
  default     = null
}

variable "opsworks_ganglia_layer_custom_security_group_ids" {
  description = "(Optional) Ids for a set of security groups to apply to the layer's instances."
  default     = null
}

variable "opsworks_ganglia_layer_auto_healing" {
  description = "(Optional) Whether to enable auto-healing for the layer."
  default     = null
}

variable "opsworks_ganglia_layer_install_updates_on_boot" {
  description = "(Optional) Whether to install OS and package updates on each instance when it boots."
  default     = null
}

variable "opsworks_ganglia_layer_instance_shutdown_timeout" {
  description = "(Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event."
  default     = null
}

variable "opsworks_ganglia_layer_elastic_load_balancer" {
  description = "(Optional) Name of an Elastic Load Balancer to attach to this layer"
  default     = null
}

variable "opsworks_ganglia_layer_drain_elb_on_shutdown" {
  description = "(Optional) Whether to enable Elastic Load Balancing connection draining."
  default     = null
}

variable "opsworks_ganglia_layer_system_packages" {
  description = "(Optional) Names of a set of system packages to install on the layer's instances."
  default     = null
}

variable "opsworks_ganglia_layer_use_ebs_optimized_instances" {
  description = "(Optional) Whether to use EBS-optimized instances."
  default     = null
}

variable "opsworks_ganglia_layer_ebs_volume" {
  description = "(Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances."
  default     = []
}

variable "opsworks_ganglia_layer_custom_json" {
  description = " (Optional) Custom JSON attributes to apply to the layer."
  default     = null
}

variable "opsworks_ganglia_layer_custom_configure_recipes" {
  description = ""
  default     = null
}

variable "opsworks_ganglia_layer_custom_deploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_ganglia_layer_custom_setup_recipes" {
  description = ""
  default     = null
}

variable "opsworks_ganglia_layer_custom_shutdown_recipes" {
  description = ""
  default     = null
}

variable "opsworks_ganglia_layer_custom_undeploy_recipes" {
  description = ""
  default     = null
}

#---------------------------------------------------
# AWS opsworks haproxy layer
#---------------------------------------------------
variable "enable_opsworks_haproxy_layer" {
  description = "Enable opsworks Haproxy layer usage"
  default     = false
}

variable "opsworks_haproxy_layer_name" {
  description = "A human-readable name for the layer."
  default     = ""
}

variable "opsworks_haproxy_layer_stack_id" {
  description = "The id of the stack the layer will belong to."
  default     = ""
}

variable "opsworks_haproxy_layer_stats_password" {
  description = "(Required) The password to use for Haproxy."
  default     = ""
}

variable "opsworks_haproxy_layer_stats_url" {
  description = "(Optional) The HAProxy stats URL. Defaults to '/haproxy?stats'."
  default     = "/haproxy?stats"
}

variable "opsworks_haproxy_layer_stats_user" {
  description = "(Optiona) The username to use for HAProxy. Defaults to 'opsworks'."
  default     = "opsworks"
}

variable "opsworks_haproxy_layer_auto_assign_elastic_ips" {
  description = "(Optional) Whether to automatically assign an elastic IP address to the layer's instances."
  default     = null
}

variable "opsworks_haproxy_layer_auto_assign_public_ips" {
  description = "(Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances."
  default     = null
}

variable "opsworks_haproxy_layer_custom_instance_profile_arn" {
  description = "(Optional) The ARN of an IAM profile that will be used for the layer's instances."
  default     = null
}

variable "opsworks_haproxy_layer_custom_security_group_ids" {
  description = "(Optional) Ids for a set of security groups to apply to the layer's instances."
  default     = null
}

variable "opsworks_haproxy_layer_auto_healing" {
  description = "(Optional) Whether to enable auto-healing for the layer."
  default     = null
}

variable "opsworks_haproxy_layer_install_updates_on_boot" {
  description = "(Optional) Whether to install OS and package updates on each instance when it boots."
  default     = null
}

variable "opsworks_haproxy_layer_instance_shutdown_timeout" {
  description = "(Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event."
  default     = null
}

variable "opsworks_haproxy_layer_elastic_load_balancer" {
  description = "(Optional) Name of an Elastic Load Balancer to attach to this layer"
  default     = null
}

variable "opsworks_haproxy_layer_drain_elb_on_shutdown" {
  description = "(Optional) Whether to enable Elastic Load Balancing connection draining."
  default     = null
}

variable "opsworks_haproxy_layer_system_packages" {
  description = "(Optional) Names of a set of system packages to install on the layer's instances."
  default     = null
}

variable "opsworks_haproxy_layer_use_ebs_optimized_instances" {
  description = "(Optional) Whether to use EBS-optimized instances."
  default     = null
}

variable "opsworks_haproxy_layer_ebs_volume" {
  description = "(Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances."
  default     = []
}

variable "opsworks_haproxy_layer_custom_json" {
  description = " (Optional) Custom JSON attributes to apply to the layer."
  default     = null
}

variable "opsworks_haproxy_layer_custom_configure_recipes" {
  description = ""
  default     = null
}

variable "opsworks_haproxy_layer_custom_deploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_haproxy_layer_custom_setup_recipes" {
  description = ""
  default     = null
}

variable "opsworks_haproxy_layer_custom_shutdown_recipes" {
  description = ""
  default     = null
}

variable "opsworks_haproxy_layer_custom_undeploy_recipes" {
  description = ""
  default     = null
}

#---------------------------------------------------
# AWS opsworks memcached layer
#---------------------------------------------------
variable "enable_opsworks_memcached_layer" {
  description = "Enable opsworks Memcached layer usage"
  default     = false
}

variable "opsworks_memcached_layer_name" {
  description = "A human-readable name for the layer."
  default     = ""
}

variable "opsworks_memcached_layer_stack_id" {
  description = "The id of the stack the layer will belong to."
  default     = ""
}

variable "opsworks_memcached_layer_allocated_memory" {
  description = "(Optional) Amount of memory to allocate for the cache on each instance, in megabytes. Defaults to 512MB."
  default     = "512MB"
}

variable "opsworks_memcached_layer_auto_assign_elastic_ips" {
  description = "(Optional) Whether to automatically assign an elastic IP address to the layer's instances."
  default     = null
}

variable "opsworks_memcached_layer_auto_assign_public_ips" {
  description = "(Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances."
  default     = null
}

variable "opsworks_memcached_layer_custom_instance_profile_arn" {
  description = "(Optional) The ARN of an IAM profile that will be used for the layer's instances."
  default     = null
}

variable "opsworks_memcached_layer_custom_security_group_ids" {
  description = "(Optional) Ids for a set of security groups to apply to the layer's instances."
  default     = null
}

variable "opsworks_memcached_layer_auto_healing" {
  description = "(Optional) Whether to enable auto-healing for the layer."
  default     = null
}

variable "opsworks_memcached_layer_install_updates_on_boot" {
  description = "(Optional) Whether to install OS and package updates on each instance when it boots."
  default     = null
}

variable "opsworks_memcached_layer_instance_shutdown_timeout" {
  description = "(Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event."
  default     = null
}

variable "opsworks_memcached_layer_elastic_load_balancer" {
  description = "(Optional) Name of an Elastic Load Balancer to attach to this layer"
  default     = null
}

variable "opsworks_memcached_layer_drain_elb_on_shutdown" {
  description = "(Optional) Whether to enable Elastic Load Balancing connection draining."
  default     = null
}

variable "opsworks_memcached_layer_system_packages" {
  description = "(Optional) Names of a set of system packages to install on the layer's instances."
  default     = null
}

variable "opsworks_memcached_layer_use_ebs_optimized_instances" {
  description = "(Optional) Whether to use EBS-optimized instances."
  default     = null
}

variable "opsworks_memcached_layer_ebs_volume" {
  description = "(Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances."
  default     = []
}

variable "opsworks_memcached_layer_custom_json" {
  description = " (Optional) Custom JSON attributes to apply to the layer."
  default     = null
}

variable "opsworks_memcached_layer_custom_configure_recipes" {
  description = ""
  default     = null
}

variable "opsworks_memcached_layer_custom_deploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_memcached_layer_custom_setup_recipes" {
  description = ""
  default     = null
}

variable "opsworks_memcached_layer_custom_shutdown_recipes" {
  description = ""
  default     = null
}

variable "opsworks_memcached_layer_custom_undeploy_recipes" {
  description = ""
  default     = null
}

#---------------------------------------------------
# AWS opsworks mysql layer
#---------------------------------------------------
variable "enable_opsworks_mysql_layer" {
  description = "Enable opsworks Mysql layer usage"
  default     = false
}

variable "opsworks_mysql_layer_name" {
  description = "A human-readable name for the layer."
  default     = ""
}

variable "opsworks_mysql_layer_stack_id" {
  description = "The id of the stack the layer will belong to."
  default     = ""
}

variable "opsworks_mysql_layer_auto_assign_elastic_ips" {
  description = "(Optional) Whether to automatically assign an elastic IP address to the layer's instances."
  default     = null
}

variable "opsworks_mysql_layer_auto_assign_public_ips" {
  description = "(Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances."
  default     = null
}

variable "opsworks_mysql_layer_custom_instance_profile_arn" {
  description = "(Optional) The ARN of an IAM profile that will be used for the layer's instances."
  default     = null
}

variable "opsworks_mysql_layer_custom_security_group_ids" {
  description = "(Optional) Ids for a set of security groups to apply to the layer's instances."
  default     = null
}

variable "opsworks_mysql_layer_auto_healing" {
  description = "(Optional) Whether to enable auto-healing for the layer."
  default     = null
}

variable "opsworks_mysql_layer_install_updates_on_boot" {
  description = "(Optional) Whether to install OS and package updates on each instance when it boots."
  default     = null
}

variable "opsworks_mysql_layer_instance_shutdown_timeout" {
  description = "(Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event."
  default     = null
}

variable "opsworks_mysql_layer_elastic_load_balancer" {
  description = "(Optional) Name of an Elastic Load Balancer to attach to this layer"
  default     = null
}

variable "opsworks_mysql_layer_drain_elb_on_shutdown" {
  description = "(Optional) Whether to enable Elastic Load Balancing connection draining."
  default     = null
}

variable "opsworks_mysql_layer_system_packages" {
  description = "(Optional) Names of a set of system packages to install on the layer's instances."
  default     = null
}

variable "opsworks_mysql_layer_use_ebs_optimized_instances" {
  description = "(Optional) Whether to use EBS-optimized instances."
  default     = null
}

variable "opsworks_mysql_layer_ebs_volume" {
  description = "(Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances."
  default     = []
}

variable "opsworks_mysql_layer_custom_json" {
  description = " (Optional) Custom JSON attributes to apply to the layer."
  default     = null
}

variable "opsworks_mysql_layer_custom_configure_recipes" {
  description = ""
  default     = null
}

variable "opsworks_mysql_layer_custom_deploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_mysql_layer_custom_setup_recipes" {
  description = ""
  default     = null
}

variable "opsworks_mysql_layer_custom_shutdown_recipes" {
  description = ""
  default     = null
}

variable "opsworks_mysql_layer_custom_undeploy_recipes" {
  description = ""
  default     = null
}

#---------------------------------------------------
# AWS opsworks java app layer
#---------------------------------------------------
variable "enable_opsworks_java_app_layer" {
  description = "Enable opsworks java layer usage"
  default     = false
}

variable "opsworks_java_app_layer_name" {
  description = "A human-readable name for the layer."
  default     = ""
}

variable "opsworks_java_app_layer_stack_id" {
  description = "The id of the stack the layer will belong to."
  default     = ""
}

variable "opsworks_java_app_layer_auto_assign_elastic_ips" {
  description = "(Optional) Whether to automatically assign an elastic IP address to the layer's instances."
  default     = null
}

variable "opsworks_java_app_layer_auto_assign_public_ips" {
  description = "(Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances."
  default     = null
}

variable "opsworks_java_app_layer_custom_instance_profile_arn" {
  description = "(Optional) The ARN of an IAM profile that will be used for the layer's instances."
  default     = null
}

variable "opsworks_java_app_layer_custom_security_group_ids" {
  description = "(Optional) Ids for a set of security groups to apply to the layer's instances."
  default     = null
}

variable "opsworks_java_app_layer_auto_healing" {
  description = "(Optional) Whether to enable auto-healing for the layer."
  default     = null
}

variable "opsworks_java_app_layer_install_updates_on_boot" {
  description = "(Optional) Whether to install OS and package updates on each instance when it boots."
  default     = null
}

variable "opsworks_java_app_layer_instance_shutdown_timeout" {
  description = "(Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event."
  default     = null
}

variable "opsworks_java_app_layer_elastic_load_balancer" {
  description = "(Optional) Name of an Elastic Load Balancer to attach to this layer"
  default     = null
}

variable "opsworks_java_app_layer_drain_elb_on_shutdown" {
  description = "(Optional) Whether to enable Elastic Load Balancing connection draining."
  default     = null
}

variable "opsworks_java_app_layer_system_packages" {
  description = "(Optional) Names of a set of system packages to install on the layer's instances."
  default     = null
}

variable "opsworks_java_app_layer_use_ebs_optimized_instances" {
  description = "(Optional) Whether to use EBS-optimized instances."
  default     = null
}

variable "opsworks_java_app_layer_ebs_volume" {
  description = "(Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances."
  default     = []
}

variable "opsworks_java_app_layer_custom_json" {
  description = " (Optional) Custom JSON attributes to apply to the layer."
  default     = null
}

variable "opsworks_java_app_layer_custom_configure_recipes" {
  description = ""
  default     = null
}

variable "opsworks_java_app_layer_custom_deploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_java_app_layer_custom_setup_recipes" {
  description = ""
  default     = null
}

variable "opsworks_java_app_layer_custom_shutdown_recipes" {
  description = ""
  default     = null
}

variable "opsworks_java_app_layer_custom_undeploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_java_app_layer_app_server" {
  description = "(Optional) Keyword for the application container to use. Defaults to 'tomcat'."
  default     = "tomcat"
}

variable "opsworks_java_app_layer_app_server_version" {
  description = "(Optional) Version of the selected application container to use. Defaults to '7'."
  default     = 7
}


variable "opsworks_java_app_layer_jvm_type" {
  description = "(Optional) Keyword for the type of JVM to use. Defaults to openjdk."
  default     = "openjdk"
}

variable "opsworks_java_app_layer_jvm_options" {
  description = "(Optional) Options to set for the JVM."
  default     = null
}

variable "opsworks_java_app_layer_jvm_version" {
  description = "(Optional) Version of JVM to use. Defaults to '7'."
  default     = 7
}

#---------------------------------------------------
# AWS opsworks nodejs app layer
#---------------------------------------------------
variable "enable_opsworks_nodejs_app_layer" {
  description = "Enable opsworks nodejs layer usage"
  default     = false
}

variable "opsworks_nodejs_app_layer_name" {
  description = "A human-readable name for the layer."
  default     = ""
}

variable "opsworks_nodejs_app_layer_stack_id" {
  description = "The id of the stack the layer will belong to."
  default     = ""
}

variable "opsworks_nodejs_app_layer_auto_assign_elastic_ips" {
  description = "(Optional) Whether to automatically assign an elastic IP address to the layer's instances."
  default     = null
}

variable "opsworks_nodejs_app_layer_auto_assign_public_ips" {
  description = "(Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances."
  default     = null
}

variable "opsworks_nodejs_app_layer_custom_instance_profile_arn" {
  description = "(Optional) The ARN of an IAM profile that will be used for the layer's instances."
  default     = null
}

variable "opsworks_nodejs_app_layer_custom_security_group_ids" {
  description = "(Optional) Ids for a set of security groups to apply to the layer's instances."
  default     = null
}

variable "opsworks_nodejs_app_layer_auto_healing" {
  description = "(Optional) Whether to enable auto-healing for the layer."
  default     = null
}

variable "opsworks_nodejs_app_layer_install_updates_on_boot" {
  description = "(Optional) Whether to install OS and package updates on each instance when it boots."
  default     = null
}

variable "opsworks_nodejs_app_layer_instance_shutdown_timeout" {
  description = "(Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event."
  default     = null
}

variable "opsworks_nodejs_app_layer_elastic_load_balancer" {
  description = "(Optional) Name of an Elastic Load Balancer to attach to this layer"
  default     = null
}

variable "opsworks_nodejs_app_layer_drain_elb_on_shutdown" {
  description = "(Optional) Whether to enable Elastic Load Balancing connection draining."
  default     = null
}

variable "opsworks_nodejs_app_layer_system_packages" {
  description = "(Optional) Names of a set of system packages to install on the layer's instances."
  default     = null
}

variable "opsworks_nodejs_app_layer_use_ebs_optimized_instances" {
  description = "(Optional) Whether to use EBS-optimized instances."
  default     = null
}

variable "opsworks_nodejs_app_layer_ebs_volume" {
  description = "(Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances."
  default     = []
}

variable "opsworks_nodejs_app_layer_custom_json" {
  description = " (Optional) Custom JSON attributes to apply to the layer."
  default     = null
}

variable "opsworks_nodejs_app_layer_custom_configure_recipes" {
  description = ""
  default     = null
}

variable "opsworks_nodejs_app_layer_custom_deploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_nodejs_app_layer_custom_setup_recipes" {
  description = ""
  default     = null
}

variable "opsworks_nodejs_app_layer_custom_shutdown_recipes" {
  description = ""
  default     = null
}

variable "opsworks_nodejs_app_layer_custom_undeploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_nodejs_app_layer_nodejs_version" {
  description = "(Optional) The version of NodeJS to use. Defaults to '0.10.38'."
  default     = "0.10.38"
}

#---------------------------------------------------
# AWS opsworks php app layer
#---------------------------------------------------
variable "enable_opsworks_php_app_layer" {
  description = "Enable opsworks php layer usage"
  default     = false
}

variable "opsworks_php_app_layer_name" {
  description = "A human-readable name for the layer."
  default     = ""
}

variable "opsworks_php_app_layer_stack_id" {
  description = "The id of the stack the layer will belong to."
  default     = ""
}

variable "opsworks_php_app_layer_auto_assign_elastic_ips" {
  description = "(Optional) Whether to automatically assign an elastic IP address to the layer's instances."
  default     = null
}

variable "opsworks_php_app_layer_auto_assign_public_ips" {
  description = "(Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances."
  default     = null
}

variable "opsworks_php_app_layer_custom_instance_profile_arn" {
  description = "(Optional) The ARN of an IAM profile that will be used for the layer's instances."
  default     = null
}

variable "opsworks_php_app_layer_custom_security_group_ids" {
  description = "(Optional) Ids for a set of security groups to apply to the layer's instances."
  default     = null
}

variable "opsworks_php_app_layer_auto_healing" {
  description = "(Optional) Whether to enable auto-healing for the layer."
  default     = null
}

variable "opsworks_php_app_layer_install_updates_on_boot" {
  description = "(Optional) Whether to install OS and package updates on each instance when it boots."
  default     = null
}

variable "opsworks_php_app_layer_instance_shutdown_timeout" {
  description = "(Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event."
  default     = null
}

variable "opsworks_php_app_layer_elastic_load_balancer" {
  description = "(Optional) Name of an Elastic Load Balancer to attach to this layer"
  default     = null
}

variable "opsworks_php_app_layer_drain_elb_on_shutdown" {
  description = "(Optional) Whether to enable Elastic Load Balancing connection draining."
  default     = null
}

variable "opsworks_php_app_layer_system_packages" {
  description = "(Optional) Names of a set of system packages to install on the layer's instances."
  default     = null
}

variable "opsworks_php_app_layer_use_ebs_optimized_instances" {
  description = "(Optional) Whether to use EBS-optimized instances."
  default     = null
}

variable "opsworks_php_app_layer_ebs_volume" {
  description = "(Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances."
  default     = []
}

variable "opsworks_php_app_layer_custom_json" {
  description = " (Optional) Custom JSON attributes to apply to the layer."
  default     = null
}

variable "opsworks_php_app_layer_custom_configure_recipes" {
  description = ""
  default     = null
}

variable "opsworks_php_app_layer_custom_deploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_php_app_layer_custom_setup_recipes" {
  description = ""
  default     = null
}

variable "opsworks_php_app_layer_custom_shutdown_recipes" {
  description = ""
  default     = null
}

variable "opsworks_php_app_layer_custom_undeploy_recipes" {
  description = ""
  default     = null
}

#---------------------------------------------------
# AWS opsworks rails app layer
#---------------------------------------------------
variable "enable_opsworks_rails_app_layer" {
  description = "Enable opsworks rails layer usage"
  default     = false
}

variable "opsworks_rails_app_layer_name" {
  description = "A human-readable name for the layer."
  default     = ""
}

variable "opsworks_rails_app_layer_stack_id" {
  description = "The id of the stack the layer will belong to."
  default     = ""
}

variable "opsworks_rails_app_layer_auto_assign_elastic_ips" {
  description = "(Optional) Whether to automatically assign an elastic IP address to the layer's instances."
  default     = null
}

variable "opsworks_rails_app_layer_auto_assign_public_ips" {
  description = "(Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances."
  default     = null
}

variable "opsworks_rails_app_layer_custom_instance_profile_arn" {
  description = "(Optional) The ARN of an IAM profile that will be used for the layer's instances."
  default     = null
}

variable "opsworks_rails_app_layer_custom_security_group_ids" {
  description = "(Optional) Ids for a set of security groups to apply to the layer's instances."
  default     = null
}

variable "opsworks_rails_app_layer_auto_healing" {
  description = "(Optional) Whether to enable auto-healing for the layer."
  default     = null
}

variable "opsworks_rails_app_layer_install_updates_on_boot" {
  description = "(Optional) Whether to install OS and package updates on each instance when it boots."
  default     = null
}

variable "opsworks_rails_app_layer_instance_shutdown_timeout" {
  description = "(Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event."
  default     = null
}

variable "opsworks_rails_app_layer_elastic_load_balancer" {
  description = "(Optional) Name of an Elastic Load Balancer to attach to this layer"
  default     = null
}

variable "opsworks_rails_app_layer_drain_elb_on_shutdown" {
  description = "(Optional) Whether to enable Elastic Load Balancing connection draining."
  default     = null
}

variable "opsworks_rails_app_layer_system_packages" {
  description = "(Optional) Names of a set of system packages to install on the layer's instances."
  default     = null
}

variable "opsworks_rails_app_layer_use_ebs_optimized_instances" {
  description = "(Optional) Whether to use EBS-optimized instances."
  default     = null
}

variable "opsworks_rails_app_layer_ebs_volume" {
  description = "(Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances."
  default     = []
}

variable "opsworks_rails_app_layer_custom_json" {
  description = " (Optional) Custom JSON attributes to apply to the layer."
  default     = null
}

variable "opsworks_rails_app_layer_custom_configure_recipes" {
  description = ""
  default     = null
}

variable "opsworks_rails_app_layer_custom_deploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_rails_app_layer_custom_setup_recipes" {
  description = ""
  default     = null
}

variable "opsworks_rails_app_layer_custom_shutdown_recipes" {
  description = ""
  default     = null
}

variable "opsworks_rails_app_layer_custom_undeploy_recipes" {
  description = ""
  default     = null
}

variable "opsworks_rails_app_layer_app_server" {
  description = "(Optional) Keyword for the app server to use. Defaults to 'apache_passenger'."
  default     = "apache_passenger"
}

variable "opsworks_rails_app_layer_bundler_version" {
  description = "(Optional) When OpsWorks is managing Bundler, which version to use. Defaults to '1.5.3'."
  default     = "1.5.3"
}

variable "opsworks_rails_app_layer_manage_bundler" {
  description = "(Optional) Whether OpsWorks should manage bundler. On by default."
  default     = null
}

variable "opsworks_rails_app_layer_passenger_version" {
  description = "(Optional) The version of Passenger to use. Defaults to '4.0.46'."
  default     = "4.0.46"
}

variable "opsworks_rails_app_layer_ruby_version" {
  description = "(Optional) The version of Ruby to use. Defaults to '2.0.0'."
  default     = "2.0.0"
}

variable "opsworks_rails_app_layer_rubygems_version" {
  description = "(Optional) The version of RubyGems to use. Defaults to '2.2.2'."
  default     = "2.2.2"
}

#---------------------------------------------------
# AWS opsworks user profile
#---------------------------------------------------
variable "enable_opsworks_user_profile" {
  description = "Enable opsworks user profile usage"
  default     = false
}

variable "opsworks_user_profile_user_arn" {
  description = "(Required) The user's IAM ARN"
  default     = ""
}

variable "opsworks_user_profile_ssh_username" {
  description = "(Required) The ssh username, with witch this user wants to log in"
  default     = ""
}

variable "opsworks_user_profile_allow_self_management" {
  description = "(Optional) Whether users can specify their own SSH public key through the My Settings page"
  default     = null
}

variable "opsworks_user_profile_ssh_public_key" {
  description = "(Optional) The users public key"
  default     = null
}

#---------------------------------------------------
# AWS opsworks application
#---------------------------------------------------
variable "enable_opsworks_application" {
  description = "Enable opsworks application usage"
  default     = false
}

variable "opsworks_application_name" {
  description = "A human-readable name for the application."
  default     = ""
}

variable "opsworks_application_short_name" {
  description = "A short, machine-readable name for the application. This can only be defined on resource creation and ignored on resource update."
  default     = ""
}

variable "opsworks_application_description" {
  description = "(Optional) A description of the app."
  default     = ""
}

variable "opsworks_application_stack_id" {
  description = "The id of the stack the application will belong to."
  default     = ""
}

variable "opsworks_application_type" {
  description = "(Required) Opsworks application type. One of aws-flow-ruby, java, rails, php, nodejs, static or other."
  default     = "other"
}

variable "opsworks_application_domains" {
  description = "(Optional) A list of virtual host alias."
  default     = []
}

variable "opsworks_application_environment" {
  description = "(Optional) Object to define environment variables."
  default     = []
}

variable "opsworks_application_app_source" {
  description = "(Optional) SCM configuration of the app"
  default     = []
}

variable "opsworks_application_data_source_arn" {
  description = "(Optional) The data source's ARN."
  default     = null
}

variable "opsworks_application_data_source_type" {
  description = "(Optional) The data source's type one of AutoSelectOpsworksMysqlInstance, OpsworksMysqlInstance, or RdsDbInstance."
  default     = null
}

variable "opsworks_application_data_source_database_name" {
  description = "(Optional) The database name."
  default     = null
}

variable "opsworks_application_enable_ssl" {
  description = "(Optional) Whether to enable SSL for the app. This must be set in order to let ssl_configuration.private_key, ssl_configuration.certificate and ssl_configuration.chain take effect."
  default     = null
}

variable "opsworks_application_ssl_configuration" {
  description = "(Optional) The SSL configuration of the app."
  default     = []
}

variable "opsworks_application_document_root" {
  description = "(Optional) Subfolder for the document root for application of type rails."
  default     = null
}

variable "opsworks_application_auto_bundle_on_deploy" {
  description = "(Optional) Run bundle install when deploying for application of type rails."
  default     = null
}

variable "opsworks_application_rails_env" {
  description = "(Required if type = rails) The name of the Rails environment for application of type rails."
  default     = null
}

variable "opsworks_application_aws_flow_ruby_settings" {
  description = "(Optional) Specify activity and workflow workers for your app using the aws-flow gem."
  default     = null
}

#---------------------------------------------------
# AWS opsworks instance
#---------------------------------------------------
variable "enable_opsworks_instance" {
  description = "Enable opsworks instance usage"
  default     = false
}

variable "opsworks_instance_stack_id" {
  description = "The id of the stack the instance will belong to."
  default     = ""
}

variable "opsworks_instance_layer_ids" {
  description = "(Required) The ids of the layers the instance will belong to."
  default     = []
}

variable "opsworks_instance_instance_type" {
  description = "(Required) The type of instance to start"
  default     = null
}

variable "opsworks_instance_os" {
  description = "(Optional) Name of operating system that will be installed."
  default     = null
}

variable "opsworks_instance_state" {
  description = "(Optional) The desired state of the instance. Can be either 'running' or 'stopped'."
  default     = null
}

variable "opsworks_instance_install_updates_on_boot" {
  description = "(Optional) Controls where to install OS and package updates when the instance boots. Defaults to true."
  default     = true
}

variable "opsworks_instance_auto_scaling_type" {
  description = "(Optional) Creates load-based or time-based instances. If set, can be either: 'load' or 'timer'."
  default     = null
}

variable "opsworks_instance_availability_zone" {
  description = "(Optional) Name of the availability zone where instances will be created by default."
  default     = null
}

variable "opsworks_instance_ebs_optimized" {
  description = "(Optional) If true, the launched EC2 instance will be EBS-optimized."
  default     = null
}

variable "opsworks_instance_hostname" {
  description = "(Optional) The instance's host name."
  default     = null
}

variable "opsworks_instance_architecture" {
  description = "(Optional) Machine architecture for created instances. Can be either 'x86_64' (the default) or 'i386'"
  default     = "x86_64"
}

variable "opsworks_instance_ami_id" {
  description = "(Optional) The AMI to use for the instance. If an AMI is specified, os must be 'Custom'."
  default     = null
}

variable "opsworks_instance_root_device_type" {
  description = "(Optional) Name of the type of root device instances will have by default. Can be either 'ebs' or 'instance-store'"
  default     = null
}

variable "opsworks_instance_ssh_key_name" {
  description = "(Optional) Name of the SSH keypair that instances will have by default."
  default     = null
}

variable "opsworks_instance_agent_version" {
  description = "(Optional) The AWS OpsWorks agent to install. Defaults to 'INHERIT'."
  default     = null
}

variable "opsworks_instance_subnet_id" {
  description = "(Optional) Subnet ID to attach to"
  default     = null
}

variable "opsworks_instance_tenancy" {
  description = "(Optional) Instance tenancy to use. Can be one of 'default', 'dedicated' or 'host'"
  default     = null
}

variable "opsworks_instance_virtualization_type" {
  description = "(Optional) Keyword to choose what virtualization mode created instances will use. Can be either 'paravirtual' or 'hvm'."
  default     = null
}

variable "opsworks_instance_root_block_device" {
  description = "(Optional) Customize details about the root block device of the instance. "
  default     = []
}

variable "opsworks_instance_ebs_block_device" {
  description = "(Optional) Additional EBS block devices to attach to the instance."
  default     = []
}

variable "opsworks_instance_ephemeral_block_device" {
  description = "(Optional) Customize Ephemeral (also known as 'Instance Store') volumes on the instance."
  default     = []
}

variable "opsworks_instance_timeouts_create" {
  description = "(Default 10 minutes) Used when the instance is created. It should cover the time needed for the instance to start successfully."
  default     = "10m"
}

variable "opsworks_instance_timeouts_update" {
  description = "(Default 10 minutes) Used when the instance is changed. It should cover the time needed to either start or stop the instance."
  default     = "10m"
}

variable "opsworks_instance_timeouts_delete" {
  description = "(Default 10 minutes) Used when the instance is deleted. It should cover the time needed for the instance to stop successfully."
  default     = "10m"
}

#---------------------------------------------------
# AWS opsworks RDS db instance
#---------------------------------------------------
variable "enable_opsworks_rds_db_instance" {
  description = "Enable opsworks rds db instance usage"
  default     = false
}

variable "opsworks_rds_db_instance_stack_id" {
  description = "The stack to register a db instance for. Changing this will force a new resource."
  default     = ""
}

variable "opsworks_rds_db_instance_rds_db_instance_arn" {
  description = "(Required) The db instance to register for this stack. Changing this will force a new resource."
  default     = ""
}

variable "opsworks_rds_db_instance_db_user" {
  description = "(Required) A db username"
  default     = ""
}

variable "opsworks_rds_db_instance_db_password" {
  description = "(Required) A db password"
  default     = ""
}

#---------------------------------------------------
# AWS opsworks permission
#---------------------------------------------------
variable "enable_opsworks_permission" {
  description = "Enable opsworks permission usage"
  default     = false
}

variable "opsworks_permission_stack_id" {
  description = "(Required) The stack to set the permissions for"
  default     = ""
}

variable "opsworks_permission_user_arn" {
  description = "(Required) The user's IAM ARN to set permissions for"
  default     = ""
}

variable "opsworks_permission_allow_ssh" {
  description = "(Optional) Whether the user is allowed to use SSH to communicate with the instance"
  default     = true
}

variable "opsworks_permission_allow_sudo" {
  description = "(Optional) Whether the user is allowed to use sudo to elevate privileges"
  default     = true
}

variable "opsworks_permission_level" {
  description = "(Optional) The users permission level. Mus be one of deny, show, deploy, manage, iam_only"
  default     = "iam_only"
}
