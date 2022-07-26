# Work with OPSWORKS via terraform

A terraform module for making OPSWORKS.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = "~> 2.49"
  }
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "iam_role" {
  source      = "../../modules/iam_role"
  name        = "TEST-role"
  environment = "stage"

  # Using IAM role
  enable_iam_role             = true
  iam_role_name               = "opsworks-role-test"
  iam_role_description        = "It's just a simple IAM role to test TF module"
  iam_role_assume_role_policy = file("additional_files/assume_role_policy.json")

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy
  enable_iam_role_policy = true
  iam_role_policy_name   = "opsworks-policy-test"
  iam_role_policy        = file("additional_files/policy.json")

  # Using IAM instance profile
  enable_iam_instance_profile = true
  iam_instance_profile_name   = "opsworks-instance-profile-test"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "opsworks" {
  source = "../../modules/opsworks"

  region      = "us-east-1"
  environment = "stage"

  enable_opsworks_stack                       = true
  opsworks_stack_name                         = ""
  opsworks_stack_service_role_arn             = module.iam_role.iam_role_arn
  opsworks_stack_default_instance_profile_arn = module.iam_role.instance_profile_arn
  opsworks_stack_vpc_id                       = "vpc-56af732c"
  opsworks_stack_default_subnet_id            = "subnet-8851dea6"

  enable_opsworks_static_web_layer = true
  opsworks_static_web_layer_name   = "opsworks-static-web-layer"

  enable_opsworks_custom_layer = true
  opsworks_custom_layer_name   = "opsworks-custom-layer"

  enable_opsworks_instance              = true
  opsworks_instance_instance_type       = "t2.large"
  opsworks_instance_os                  = "Amazon Linux 2015.09"
  opsworks_instance_state               = "stopped"
  opsworks_instance_virtualization_type = "hvm"
  opsworks_instance_tenancy             = "default"
  opsworks_instance_root_device_type    = "ebs"


  enable_opsworks_application     = true
  opsworks_application_name       = "opsworks-app-test"
  opsworks_application_short_name = "app-test"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. (`default = {}`)
- `enable_opsworks_stack` - Enable opsworks stack usage (`default = False`)
- `opsworks_stack_name` - The name of the stack. (`default = ""`)
- `opsworks_stack_service_role_arn` - (Required) The ARN of an IAM role that the OpsWorks service will act as. (`default = ""`)
- `opsworks_stack_default_instance_profile_arn` - (Required) The ARN of an IAM Instance Profile that created instances will have by default. (`default = ""`)
- `opsworks_stack_agent_version` - (Optional) If set to 'LATEST', OpsWorks will automatically install the latest version. (`default = LATEST`)
- `opsworks_stack_berkshelf_version` - (Optional) If manage_berkshelf is enabled, the version of Berkshelf to use. (`default = null`)
- `opsworks_stack_configuration_manager_name` - (Optional) Name of the configuration manager to use. Defaults to 'Chef'. (`default = Chef`)
- `opsworks_stack_configuration_manager_version` - (Optional) Version of the configuration manager to use (11.10 or 12 for now). Defaults to 12. (`default = 11.10`)
- `opsworks_stack_custom_cookbooks_source` - (Optional) When use_custom_cookbooks is set, provide this sub-object (`default = []`)
- `opsworks_stack_custom_json` - (Optional) Custom JSON attributes to apply to the entire stack. (`default = null`)
- `opsworks_stack_default_availability_zone` - (Optional) Name of the availability zone where instances will be created by default. This is required unless you set vpc_id (`default = null`)
- `opsworks_stack_default_os` - (Optional) Name of OS that will be installed on instances by default. (`default = null`)
- `opsworks_stack_default_root_device_type` - (Optional) Name of the type of root device instances will have by default. (`default = null`)
- `opsworks_stack_default_ssh_key_name` - (Optional) Name of the SSH keypair that instances will have by default. (`default = null`)
- `opsworks_stack_default_subnet_id` - (Optional) Id of the subnet in which instances will be created by default. Mandatory if vpc_id is set, and forbidden if it isn't. (`default = null`)
- `opsworks_stack_manage_berkshelf` - (Optional) Boolean value controlling whether Opsworks will run Berkshelf for this stack. (`default = null`)
- `opsworks_stack_hostname_theme` - (Optional) Keyword representing the naming scheme that will be used for instance hostnames within this stack. (`default = null`)
- `opsworks_stack_color` - (Optional) Color to paint next to the stack's resources in the OpsWorks console. (`default = null`)
- `opsworks_stack_use_custom_cookbooks` - (Optional) Boolean value controlling whether the custom cookbook settings are enabled. (`default = null`)
- `opsworks_stack_use_opsworks_security_groups` - (Optional) Boolean value controlling whether the standard OpsWorks security groups apply to created instances. (`default = null`)
- `opsworks_stack_vpc_id` - (Optional) The id of the VPC that this stack belongs to. (`default = null`)
- `enable_opsworks_static_web_layer` - Enable opsworks static web layer usage (`default = False`)
- `opsworks_static_web_layer_stack_id` - The id of the stack the layer will belong to. (`default = ""`)
- `opsworks_static_web_layer_name` - (Optional) A human-readable name for the layer. (`default = ""`)
- `opsworks_static_web_layer_auto_assign_elastic_ips` - (Optional) Whether to automatically assign an elastic IP address to the layer's instances. (`default = null`)
- `opsworks_static_web_layer_auto_assign_public_ips` - (Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances. (`default = null`)
- `opsworks_static_web_layer_custom_instance_profile_arn` - (Optional) The ARN of an IAM profile that will be used for the layer's instances. (`default = null`)
- `opsworks_static_web_layer_custom_security_group_ids` - (Optional) Ids for a set of security groups to apply to the layer's instances. (`default = null`)
- `opsworks_static_web_layer_auto_healing` - (Optional) Whether to enable auto-healing for the layer. (`default = null`)
- `opsworks_static_web_layer_install_updates_on_boot` - (Optional) Whether to install OS and package updates on each instance when it boots. (`default = null`)
- `opsworks_static_web_layer_instance_shutdown_timeout` -  (Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event. (`default = null`)
- `opsworks_static_web_layer_elastic_load_balancer` - (Optional) Name of an Elastic Load Balancer to attach to this layer (`default = null`)
- `opsworks_static_web_layer_drain_elb_on_shutdown` - (Optional) Whether to enable Elastic Load Balancing connection draining. (`default = null`)
- `opsworks_static_web_layer_system_packages` - (Optional) Names of a set of system packages to install on the layer's instances. (`default = null`)
- `opsworks_static_web_layer_use_ebs_optimized_instances` - (Optional) Whether to use EBS-optimized instances. (`default = null`)
- `opsworks_static_web_layer_custom_configure_recipes` - "" (`default = null`)
- `opsworks_static_web_layer_custom_deploy_recipes` - "" (`default = null`)
- `opsworks_static_web_layer_custom_setup_recipes` - "" (`default = null`)
- `opsworks_static_web_layer_custom_shutdown_recipes` - "" (`default = null`)
- `opsworks_static_web_layer_custom_undeploy_recipes` - "" (`default = null`)
- `opsworks_static_web_layer_ebs_volume` - (Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances. (`default = []`)
- `enable_opsworks_custom_layer` - Enable opsworks custom layer usage (`default = False`)
- `opsworks_custom_layer_name` - A human-readable name for the layer. (`default = ""`)
- `opsworks_custom_layer_short_name` - A short, machine-readable name for the layer, which will be used to identify it in the Chef node JSON. (`default = ""`)
- `opsworks_custom_layer_stack_id` - The id of the stack the layer will belong to. (`default = ""`)
- `opsworks_custom_layer_auto_assign_elastic_ips` - (Optional) Whether to automatically assign an elastic IP address to the layer's instances. (`default = null`)
- `opsworks_custom_layer_auto_assign_public_ips` - (Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances. (`default = null`)
- `opsworks_custom_layer_custom_instance_profile_arn` - (Optional) The ARN of an IAM profile that will be used for the layer's instances. (`default = null`)
- `opsworks_custom_layer_custom_security_group_ids` - (Optional) Ids for a set of security groups to apply to the layer's instances. (`default = null`)
- `opsworks_custom_layer_auto_healing` - (Optional) Whether to enable auto-healing for the layer. (`default = null`)
- `opsworks_custom_layer_install_updates_on_boot` - (Optional) Whether to install OS and package updates on each instance when it boots. (`default = null`)
- `opsworks_custom_layer_instance_shutdown_timeout` - (Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event. (`default = null`)
- `opsworks_custom_layer_elastic_load_balancer` - (Optional) Name of an Elastic Load Balancer to attach to this layer (`default = null`)
- `opsworks_custom_layer_drain_elb_on_shutdown` - (Optional) Whether to enable Elastic Load Balancing connection draining. (`default = null`)
- `opsworks_custom_layer_system_packages` - (Optional) Names of a set of system packages to install on the layer's instances. (`default = null`)
- `opsworks_custom_layer_use_ebs_optimized_instances` - (Optional) Whether to use EBS-optimized instances. (`default = null`)
- `opsworks_custom_layer_ebs_volume` - (Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances. (`default = []`)
- `opsworks_custom_layer_custom_json` -  (Optional) Custom JSON attributes to apply to the layer. (`default = null`)
- `opsworks_custom_layer_custom_configure_recipes` - "" (`default = null`)
- `opsworks_custom_layer_custom_deploy_recipes` - "" (`default = null`)
- `opsworks_custom_layer_custom_setup_recipes` - "" (`default = null`)
- `opsworks_custom_layer_custom_shutdown_recipes` - "" (`default = null`)
- `opsworks_custom_layer_custom_undeploy_recipes` - "" (`default = null`)
- `enable_opsworks_ganglia_layer` - Enable opsworks ganglia layer usage (`default = False`)
- `opsworks_ganglia_layer_name` - A human-readable name for the layer. (`default = ""`)
- `opsworks_ganglia_layer_stack_id` - The id of the stack the layer will belong to. (`default = ""`)
- `opsworks_ganglia_layer_password` - (Required) The password to use for Ganglia. (`default = ""`)
- `opsworks_ganglia_layer_url` - (Optional) The URL path to use for Ganglia. Defaults to '/ganglia'. (`default = /ganglia`)
- `opsworks_ganglia_layer_username` - (Optiona) The username to use for Ganglia. Defaults to 'opsworks'. (`default = opsworks`)
- `opsworks_ganglia_layer_auto_assign_elastic_ips` - (Optional) Whether to automatically assign an elastic IP address to the layer's instances. (`default = null`)
- `opsworks_ganglia_layer_auto_assign_public_ips` - (Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances. (`default = null`)
- `opsworks_ganglia_layer_custom_instance_profile_arn` - (Optional) The ARN of an IAM profile that will be used for the layer's instances. (`default = null`)
- `opsworks_ganglia_layer_custom_security_group_ids` - (Optional) Ids for a set of security groups to apply to the layer's instances. (`default = null`)
- `opsworks_ganglia_layer_auto_healing` - (Optional) Whether to enable auto-healing for the layer. (`default = null`)
- `opsworks_ganglia_layer_install_updates_on_boot` - (Optional) Whether to install OS and package updates on each instance when it boots. (`default = null`)
- `opsworks_ganglia_layer_instance_shutdown_timeout` - (Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event. (`default = null`)
- `opsworks_ganglia_layer_elastic_load_balancer` - (Optional) Name of an Elastic Load Balancer to attach to this layer (`default = null`)
- `opsworks_ganglia_layer_drain_elb_on_shutdown` - (Optional) Whether to enable Elastic Load Balancing connection draining. (`default = null`)
- `opsworks_ganglia_layer_system_packages` - (Optional) Names of a set of system packages to install on the layer's instances. (`default = null`)
- `opsworks_ganglia_layer_use_ebs_optimized_instances` - (Optional) Whether to use EBS-optimized instances. (`default = null`)
- `opsworks_ganglia_layer_ebs_volume` - (Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances. (`default = []`)
- `opsworks_ganglia_layer_custom_json` -  (Optional) Custom JSON attributes to apply to the layer. (`default = null`)
- `opsworks_ganglia_layer_custom_configure_recipes` - "" (`default = null`)
- `opsworks_ganglia_layer_custom_deploy_recipes` - "" (`default = null`)
- `opsworks_ganglia_layer_custom_setup_recipes` - "" (`default = null`)
- `opsworks_ganglia_layer_custom_shutdown_recipes` - "" (`default = null`)
- `opsworks_ganglia_layer_custom_undeploy_recipes` - "" (`default = null`)
- `enable_opsworks_haproxy_layer` - Enable opsworks Haproxy layer usage (`default = False`)
- `opsworks_haproxy_layer_name` - A human-readable name for the layer. (`default = ""`)
- `opsworks_haproxy_layer_stack_id` - The id of the stack the layer will belong to. (`default = ""`)
- `opsworks_haproxy_layer_stats_password` - (Required) The password to use for Haproxy. (`default = ""`)
- `opsworks_haproxy_layer_stats_url` - (Optional) The HAProxy stats URL. Defaults to '/haproxy?stats'. (`default = /haproxy?stats`)
- `opsworks_haproxy_layer_stats_user` - (Optiona) The username to use for HAProxy. Defaults to 'opsworks'. (`default = opsworks`)
- `opsworks_haproxy_layer_auto_assign_elastic_ips` - (Optional) Whether to automatically assign an elastic IP address to the layer's instances. (`default = null`)
- `opsworks_haproxy_layer_auto_assign_public_ips` - (Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances. (`default = null`)
- `opsworks_haproxy_layer_custom_instance_profile_arn` - (Optional) The ARN of an IAM profile that will be used for the layer's instances. (`default = null`)
- `opsworks_haproxy_layer_custom_security_group_ids` - (Optional) Ids for a set of security groups to apply to the layer's instances. (`default = null`)
- `opsworks_haproxy_layer_auto_healing` - (Optional) Whether to enable auto-healing for the layer. (`default = null`)
- `opsworks_haproxy_layer_install_updates_on_boot` - (Optional) Whether to install OS and package updates on each instance when it boots. (`default = null`)
- `opsworks_haproxy_layer_instance_shutdown_timeout` - (Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event. (`default = null`)
- `opsworks_haproxy_layer_elastic_load_balancer` - (Optional) Name of an Elastic Load Balancer to attach to this layer (`default = null`)
- `opsworks_haproxy_layer_drain_elb_on_shutdown` - (Optional) Whether to enable Elastic Load Balancing connection draining. (`default = null`)
- `opsworks_haproxy_layer_system_packages` - (Optional) Names of a set of system packages to install on the layer's instances. (`default = null`)
- `opsworks_haproxy_layer_use_ebs_optimized_instances` - (Optional) Whether to use EBS-optimized instances. (`default = null`)
- `opsworks_haproxy_layer_ebs_volume` - (Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances. (`default = []`)
- `opsworks_haproxy_layer_custom_json` -  (Optional) Custom JSON attributes to apply to the layer. (`default = null`)
- `opsworks_haproxy_layer_custom_configure_recipes` - "" (`default = null`)
- `opsworks_haproxy_layer_custom_deploy_recipes` - "" (`default = null`)
- `opsworks_haproxy_layer_custom_setup_recipes` - "" (`default = null`)
- `opsworks_haproxy_layer_custom_shutdown_recipes` - "" (`default = null`)
- `opsworks_haproxy_layer_custom_undeploy_recipes` - "" (`default = null`)
- `enable_opsworks_memcached_layer` - Enable opsworks Memcached layer usage (`default = False`)
- `opsworks_memcached_layer_name` - A human-readable name for the layer. (`default = ""`)
- `opsworks_memcached_layer_stack_id` - The id of the stack the layer will belong to. (`default = ""`)
- `opsworks_memcached_layer_allocated_memory` - (Optional) Amount of memory to allocate for the cache on each instance, in megabytes. Defaults to 512MB. (`default = 512MB`)
- `opsworks_memcached_layer_auto_assign_elastic_ips` - (Optional) Whether to automatically assign an elastic IP address to the layer's instances. (`default = null`)
- `opsworks_memcached_layer_auto_assign_public_ips` - (Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances. (`default = null`)
- `opsworks_memcached_layer_custom_instance_profile_arn` - (Optional) The ARN of an IAM profile that will be used for the layer's instances. (`default = null`)
- `opsworks_memcached_layer_custom_security_group_ids` - (Optional) Ids for a set of security groups to apply to the layer's instances. (`default = null`)
- `opsworks_memcached_layer_auto_healing` - (Optional) Whether to enable auto-healing for the layer. (`default = null`)
- `opsworks_memcached_layer_install_updates_on_boot` - (Optional) Whether to install OS and package updates on each instance when it boots. (`default = null`)
- `opsworks_memcached_layer_instance_shutdown_timeout` - (Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event. (`default = null`)
- `opsworks_memcached_layer_elastic_load_balancer` - (Optional) Name of an Elastic Load Balancer to attach to this layer (`default = null`)
- `opsworks_memcached_layer_drain_elb_on_shutdown` - (Optional) Whether to enable Elastic Load Balancing connection draining. (`default = null`)
- `opsworks_memcached_layer_system_packages` - (Optional) Names of a set of system packages to install on the layer's instances. (`default = null`)
- `opsworks_memcached_layer_use_ebs_optimized_instances` - (Optional) Whether to use EBS-optimized instances. (`default = null`)
- `opsworks_memcached_layer_ebs_volume` - (Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances. (`default = []`)
- `opsworks_memcached_layer_custom_json` -  (Optional) Custom JSON attributes to apply to the layer. (`default = null`)
- `opsworks_memcached_layer_custom_configure_recipes` - "" (`default = null`)
- `opsworks_memcached_layer_custom_deploy_recipes` - "" (`default = null`)
- `opsworks_memcached_layer_custom_setup_recipes` - "" (`default = null`)
- `opsworks_memcached_layer_custom_shutdown_recipes` - "" (`default = null`)
- `opsworks_memcached_layer_custom_undeploy_recipes` - "" (`default = null`)
- `enable_opsworks_mysql_layer` - Enable opsworks Mysql layer usage (`default = False`)
- `opsworks_mysql_layer_name` - A human-readable name for the layer. (`default = ""`)
- `opsworks_mysql_layer_stack_id` - The id of the stack the layer will belong to. (`default = ""`)
- `opsworks_mysql_layer_auto_assign_elastic_ips` - (Optional) Whether to automatically assign an elastic IP address to the layer's instances. (`default = null`)
- `opsworks_mysql_layer_auto_assign_public_ips` - (Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances. (`default = null`)
- `opsworks_mysql_layer_custom_instance_profile_arn` - (Optional) The ARN of an IAM profile that will be used for the layer's instances. (`default = null`)
- `opsworks_mysql_layer_custom_security_group_ids` - (Optional) Ids for a set of security groups to apply to the layer's instances. (`default = null`)
- `opsworks_mysql_layer_auto_healing` - (Optional) Whether to enable auto-healing for the layer. (`default = null`)
- `opsworks_mysql_layer_install_updates_on_boot` - (Optional) Whether to install OS and package updates on each instance when it boots. (`default = null`)
- `opsworks_mysql_layer_instance_shutdown_timeout` - (Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event. (`default = null`)
- `opsworks_mysql_layer_elastic_load_balancer` - (Optional) Name of an Elastic Load Balancer to attach to this layer (`default = null`)
- `opsworks_mysql_layer_drain_elb_on_shutdown` - (Optional) Whether to enable Elastic Load Balancing connection draining. (`default = null`)
- `opsworks_mysql_layer_system_packages` - (Optional) Names of a set of system packages to install on the layer's instances. (`default = null`)
- `opsworks_mysql_layer_use_ebs_optimized_instances` - (Optional) Whether to use EBS-optimized instances. (`default = null`)
- `opsworks_mysql_layer_ebs_volume` - (Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances. (`default = []`)
- `opsworks_mysql_layer_custom_json` -  (Optional) Custom JSON attributes to apply to the layer. (`default = null`)
- `opsworks_mysql_layer_custom_configure_recipes` - "" (`default = null`)
- `opsworks_mysql_layer_custom_deploy_recipes` - "" (`default = null`)
- `opsworks_mysql_layer_custom_setup_recipes` - "" (`default = null`)
- `opsworks_mysql_layer_custom_shutdown_recipes` - "" (`default = null`)
- `opsworks_mysql_layer_custom_undeploy_recipes` - "" (`default = null`)
- `enable_opsworks_java_app_layer` - Enable opsworks java layer usage (`default = False`)
- `opsworks_java_app_layer_name` - A human-readable name for the layer. (`default = ""`)
- `opsworks_java_app_layer_stack_id` - The id of the stack the layer will belong to. (`default = ""`)
- `opsworks_java_app_layer_auto_assign_elastic_ips` - (Optional) Whether to automatically assign an elastic IP address to the layer's instances. (`default = null`)
- `opsworks_java_app_layer_auto_assign_public_ips` - (Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances. (`default = null`)
- `opsworks_java_app_layer_custom_instance_profile_arn` - (Optional) The ARN of an IAM profile that will be used for the layer's instances. (`default = null`)
- `opsworks_java_app_layer_custom_security_group_ids` - (Optional) Ids for a set of security groups to apply to the layer's instances. (`default = null`)
- `opsworks_java_app_layer_auto_healing` - (Optional) Whether to enable auto-healing for the layer. (`default = null`)
- `opsworks_java_app_layer_install_updates_on_boot` - (Optional) Whether to install OS and package updates on each instance when it boots. (`default = null`)
- `opsworks_java_app_layer_instance_shutdown_timeout` - (Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event. (`default = null`)
- `opsworks_java_app_layer_elastic_load_balancer` - (Optional) Name of an Elastic Load Balancer to attach to this layer (`default = null`)
- `opsworks_java_app_layer_drain_elb_on_shutdown` - (Optional) Whether to enable Elastic Load Balancing connection draining. (`default = null`)
- `opsworks_java_app_layer_system_packages` - (Optional) Names of a set of system packages to install on the layer's instances. (`default = null`)
- `opsworks_java_app_layer_use_ebs_optimized_instances` - (Optional) Whether to use EBS-optimized instances. (`default = null`)
- `opsworks_java_app_layer_ebs_volume` - (Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances. (`default = []`)
- `opsworks_java_app_layer_custom_json` -  (Optional) Custom JSON attributes to apply to the layer. (`default = null`)
- `opsworks_java_app_layer_custom_configure_recipes` - "" (`default = null`)
- `opsworks_java_app_layer_custom_deploy_recipes` - "" (`default = null`)
- `opsworks_java_app_layer_custom_setup_recipes` - "" (`default = null`)
- `opsworks_java_app_layer_custom_shutdown_recipes` - "" (`default = null`)
- `opsworks_java_app_layer_custom_undeploy_recipes` - "" (`default = null`)
- `opsworks_java_app_layer_app_server` - (Optional) Keyword for the application container to use. Defaults to 'tomcat'. (`default = tomcat`)
- `opsworks_java_app_layer_app_server_version` - (Optional) Version of the selected application container to use. Defaults to '7'. (`default = 7`)
- `opsworks_java_app_layer_jvm_type` - (Optional) Keyword for the type of JVM to use. Defaults to openjdk. (`default = openjdk`)
- `opsworks_java_app_layer_jvm_options` - (Optional) Options to set for the JVM. (`default = null`)
- `opsworks_java_app_layer_jvm_version` - (Optional) Version of JVM to use. Defaults to '7'. (`default = 7`)
- `enable_opsworks_nodejs_app_layer` - Enable opsworks nodejs layer usage (`default = False`)
- `opsworks_nodejs_app_layer_name` - A human-readable name for the layer. (`default = ""`)
- `opsworks_nodejs_app_layer_stack_id` - The id of the stack the layer will belong to. (`default = ""`)
- `opsworks_nodejs_app_layer_auto_assign_elastic_ips` - (Optional) Whether to automatically assign an elastic IP address to the layer's instances. (`default = null`)
- `opsworks_nodejs_app_layer_auto_assign_public_ips` - (Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances. (`default = null`)
- `opsworks_nodejs_app_layer_custom_instance_profile_arn` - (Optional) The ARN of an IAM profile that will be used for the layer's instances. (`default = null`)
- `opsworks_nodejs_app_layer_custom_security_group_ids` - (Optional) Ids for a set of security groups to apply to the layer's instances. (`default = null`)
- `opsworks_nodejs_app_layer_auto_healing` - (Optional) Whether to enable auto-healing for the layer. (`default = null`)
- `opsworks_nodejs_app_layer_install_updates_on_boot` - (Optional) Whether to install OS and package updates on each instance when it boots. (`default = null`)
- `opsworks_nodejs_app_layer_instance_shutdown_timeout` - (Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event. (`default = null`)
- `opsworks_nodejs_app_layer_elastic_load_balancer` - (Optional) Name of an Elastic Load Balancer to attach to this layer (`default = null`)
- `opsworks_nodejs_app_layer_drain_elb_on_shutdown` - (Optional) Whether to enable Elastic Load Balancing connection draining. (`default = null`)
- `opsworks_nodejs_app_layer_system_packages` - (Optional) Names of a set of system packages to install on the layer's instances. (`default = null`)
- `opsworks_nodejs_app_layer_use_ebs_optimized_instances` - (Optional) Whether to use EBS-optimized instances. (`default = null`)
- `opsworks_nodejs_app_layer_ebs_volume` - (Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances. (`default = []`)
- `opsworks_nodejs_app_layer_custom_json` -  (Optional) Custom JSON attributes to apply to the layer. (`default = null`)
- `opsworks_nodejs_app_layer_custom_configure_recipes` - "" (`default = null`)
- `opsworks_nodejs_app_layer_custom_deploy_recipes` - "" (`default = null`)
- `opsworks_nodejs_app_layer_custom_setup_recipes` - "" (`default = null`)
- `opsworks_nodejs_app_layer_custom_shutdown_recipes` - "" (`default = null`)
- `opsworks_nodejs_app_layer_custom_undeploy_recipes` - "" (`default = null`)
- `opsworks_nodejs_app_layer_nodejs_version` - (Optional) The version of NodeJS to use. Defaults to '0.10.38'. (`default = 0.10.38`)
- `enable_opsworks_php_app_layer` - Enable opsworks php layer usage (`default = False`)
- `opsworks_php_app_layer_name` - A human-readable name for the layer. (`default = ""`)
- `opsworks_php_app_layer_stack_id` - The id of the stack the layer will belong to. (`default = ""`)
- `opsworks_php_app_layer_auto_assign_elastic_ips` - (Optional) Whether to automatically assign an elastic IP address to the layer's instances. (`default = null`)
- `opsworks_php_app_layer_auto_assign_public_ips` - (Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances. (`default = null`)
- `opsworks_php_app_layer_custom_instance_profile_arn` - (Optional) The ARN of an IAM profile that will be used for the layer's instances. (`default = null`)
- `opsworks_php_app_layer_custom_security_group_ids` - (Optional) Ids for a set of security groups to apply to the layer's instances. (`default = null`)
- `opsworks_php_app_layer_auto_healing` - (Optional) Whether to enable auto-healing for the layer. (`default = null`)
- `opsworks_php_app_layer_install_updates_on_boot` - (Optional) Whether to install OS and package updates on each instance when it boots. (`default = null`)
- `opsworks_php_app_layer_instance_shutdown_timeout` - (Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event. (`default = null`)
- `opsworks_php_app_layer_elastic_load_balancer` - (Optional) Name of an Elastic Load Balancer to attach to this layer (`default = null`)
- `opsworks_php_app_layer_drain_elb_on_shutdown` - (Optional) Whether to enable Elastic Load Balancing connection draining. (`default = null`)
- `opsworks_php_app_layer_system_packages` - (Optional) Names of a set of system packages to install on the layer's instances. (`default = null`)
- `opsworks_php_app_layer_use_ebs_optimized_instances` - (Optional) Whether to use EBS-optimized instances. (`default = null`)
- `opsworks_php_app_layer_ebs_volume` - (Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances. (`default = []`)
- `opsworks_php_app_layer_custom_json` -  (Optional) Custom JSON attributes to apply to the layer. (`default = null`)
- `opsworks_php_app_layer_custom_configure_recipes` - "" (`default = null`)
- `opsworks_php_app_layer_custom_deploy_recipes` - "" (`default = null`)
- `opsworks_php_app_layer_custom_setup_recipes` - "" (`default = null`)
- `opsworks_php_app_layer_custom_shutdown_recipes` - "" (`default = null`)
- `opsworks_php_app_layer_custom_undeploy_recipes` - "" (`default = null`)
- `enable_opsworks_rails_app_layer` - Enable opsworks rails layer usage (`default = False`)
- `opsworks_rails_app_layer_name` - A human-readable name for the layer. (`default = ""`)
- `opsworks_rails_app_layer_stack_id` - The id of the stack the layer will belong to. (`default = ""`)
- `opsworks_rails_app_layer_auto_assign_elastic_ips` - (Optional) Whether to automatically assign an elastic IP address to the layer's instances. (`default = null`)
- `opsworks_rails_app_layer_auto_assign_public_ips` - (Optional) For stacks belonging to a VPC, whether to automatically assign a public IP address to each of the layer's instances. (`default = null`)
- `opsworks_rails_app_layer_custom_instance_profile_arn` - (Optional) The ARN of an IAM profile that will be used for the layer's instances. (`default = null`)
- `opsworks_rails_app_layer_custom_security_group_ids` - (Optional) Ids for a set of security groups to apply to the layer's instances. (`default = null`)
- `opsworks_rails_app_layer_auto_healing` - (Optional) Whether to enable auto-healing for the layer. (`default = null`)
- `opsworks_rails_app_layer_install_updates_on_boot` - (Optional) Whether to install OS and package updates on each instance when it boots. (`default = null`)
- `opsworks_rails_app_layer_instance_shutdown_timeout` - (Optional) The time, in seconds, that OpsWorks will wait for Chef to complete after triggering the Shutdown event. (`default = null`)
- `opsworks_rails_app_layer_elastic_load_balancer` - (Optional) Name of an Elastic Load Balancer to attach to this layer (`default = null`)
- `opsworks_rails_app_layer_drain_elb_on_shutdown` - (Optional) Whether to enable Elastic Load Balancing connection draining. (`default = null`)
- `opsworks_rails_app_layer_system_packages` - (Optional) Names of a set of system packages to install on the layer's instances. (`default = null`)
- `opsworks_rails_app_layer_use_ebs_optimized_instances` - (Optional) Whether to use EBS-optimized instances. (`default = null`)
- `opsworks_rails_app_layer_ebs_volume` - (Optional) ebs_volume blocks, as described below, will each create an EBS volume and connect it to the layer's instances. (`default = []`)
- `opsworks_rails_app_layer_custom_json` -  (Optional) Custom JSON attributes to apply to the layer. (`default = null`)
- `opsworks_rails_app_layer_custom_configure_recipes` - "" (`default = null`)
- `opsworks_rails_app_layer_custom_deploy_recipes` - "" (`default = null`)
- `opsworks_rails_app_layer_custom_setup_recipes` - "" (`default = null`)
- `opsworks_rails_app_layer_custom_shutdown_recipes` - "" (`default = null`)
- `opsworks_rails_app_layer_custom_undeploy_recipes` - "" (`default = null`)
- `opsworks_rails_app_layer_app_server` - (Optional) Keyword for the app server to use. Defaults to 'apache_passenger'. (`default = apache_passenger`)
- `opsworks_rails_app_layer_bundler_version` - (Optional) When OpsWorks is managing Bundler, which version to use. Defaults to '1.5.3'. (`default = 1.5.3`)
- `opsworks_rails_app_layer_manage_bundler` - (Optional) Whether OpsWorks should manage bundler. On by default. (`default = null`)
- `opsworks_rails_app_layer_passenger_version` - (Optional) The version of Passenger to use. Defaults to '4.0.46'. (`default = 4.0.46`)
- `opsworks_rails_app_layer_ruby_version` - (Optional) The version of Ruby to use. Defaults to '2.0.0'. (`default = 2.0.0`)
- `opsworks_rails_app_layer_rubygems_version` - (Optional) The version of RubyGems to use. Defaults to '2.2.2'. (`default = 2.2.2`)
- `enable_opsworks_user_profile` - Enable opsworks user profile usage (`default = False`)
- `opsworks_user_profile_user_arn` - (Required) The user's IAM ARN (`default = ""`)
- `opsworks_user_profile_ssh_username` - (Required) The ssh username, with witch this user wants to log in (`default = ""`)
- `opsworks_user_profile_allow_self_management` - (Optional) Whether users can specify their own SSH public key through the My Settings page (`default = null`)
- `opsworks_user_profile_ssh_public_key` - (Optional) The users public key (`default = null`)
- `enable_opsworks_application` - Enable opsworks application usage (`default = False`)
- `opsworks_application_name` - A human-readable name for the application. (`default = ""`)
- `opsworks_application_short_name` - A short, machine-readable name for the application. This can only be defined on resource creation and ignored on resource update. (`default = ""`)
- `opsworks_application_description` - (Optional) A description of the app. (`default = ""`)
- `opsworks_application_stack_id` - The id of the stack the application will belong to. (`default = ""`)
- `opsworks_application_type` - (Required) Opsworks application type. One of aws-flow-ruby, java, rails, php, nodejs, static or other. (`default = other`)
- `opsworks_application_domains` - (Optional) A list of virtual host alias. (`default = []`)
- `opsworks_application_environment` - (Optional) Object to define environment variables. (`default = []`)
- `opsworks_application_app_source` - (Optional) SCM configuration of the app (`default = []`)
- `opsworks_application_data_source_arn` - (Optional) The data source's ARN. (`default = null`)
- `opsworks_application_data_source_type` - (Optional) The data source's type one of AutoSelectOpsworksMysqlInstance, OpsworksMysqlInstance, or RdsDbInstance. (`default = null`)
- `opsworks_application_data_source_database_name` - (Optional) The database name. (`default = null`)
- `opsworks_application_enable_ssl` - (Optional) Whether to enable SSL for the app. This must be set in order to let ssl_configuration.private_key, ssl_configuration.certificate and ssl_configuration.chain take effect. (`default = null`)
- `opsworks_application_ssl_configuration` - (Optional) The SSL configuration of the app. (`default = []`)
- `opsworks_application_document_root` - (Optional) Subfolder for the document root for application of type rails. (`default = null`)
- `opsworks_application_auto_bundle_on_deploy` - (Optional) Run bundle install when deploying for application of type rails. (`default = null`)
- `opsworks_application_rails_env` - (Required if type = rails) The name of the Rails environment for application of type rails. (`default = null`)
- `opsworks_application_aws_flow_ruby_settings` - (Optional) Specify activity and workflow workers for your app using the aws-flow gem. (`default = null`)
- `enable_opsworks_instance` - Enable opsworks instance usage (`default = False`)
- `opsworks_instance_stack_id` - The id of the stack the instance will belong to. (`default = ""`)
- `opsworks_instance_layer_ids` - (Required) The ids of the layers the instance will belong to. (`default = []`)
- `opsworks_instance_instance_type` - (Required) The type of instance to start (`default = null`)
- `opsworks_instance_os` - (Optional) Name of operating system that will be installed. (`default = null`)
- `opsworks_instance_state` - (Optional) The desired state of the instance. Can be either 'running' or 'stopped'. (`default = null`)
- `opsworks_instance_install_updates_on_boot` - (Optional) Controls where to install OS and package updates when the instance boots. Defaults to true. (`default = True`)
- `opsworks_instance_auto_scaling_type` - (Optional) Creates load-based or time-based instances. If set, can be either: 'load' or 'timer'. (`default = null`)
- `opsworks_instance_availability_zone` - (Optional) Name of the availability zone where instances will be created by default. (`default = null`)
- `opsworks_instance_ebs_optimized` - (Optional) If true, the launched EC2 instance will be EBS-optimized. (`default = null`)
- `opsworks_instance_hostname` - (Optional) The instance's host name. (`default = null`)
- `opsworks_instance_architecture` - (Optional) Machine architecture for created instances. Can be either 'x86_64' (the default) or 'i386' (`default = x86_64`)
- `opsworks_instance_ami_id` - (Optional) The AMI to use for the instance. If an AMI is specified, os must be 'Custom'. (`default = null`)
- `opsworks_instance_root_device_type` - (Optional) Name of the type of root device instances will have by default. Can be either 'ebs' or 'instance-store' (`default = null`)
- `opsworks_instance_ssh_key_name` - (Optional) Name of the SSH keypair that instances will have by default. (`default = null`)
- `opsworks_instance_agent_version` - (Optional) The AWS OpsWorks agent to install. Defaults to 'INHERIT'. (`default = null`)
- `opsworks_instance_subnet_id` - (Optional) Subnet ID to attach to (`default = null`)
- `opsworks_instance_tenancy` - (Optional) Instance tenancy to use. Can be one of 'default', 'dedicated' or 'host' (`default = null`)
- `opsworks_instance_virtualization_type` - (Optional) Keyword to choose what virtualization mode created instances will use. Can be either 'paravirtual' or 'hvm'. (`default = null`)
- `opsworks_instance_root_block_device` - (Optional) Customize details about the root block device of the instance.  (`default = []`)
- `opsworks_instance_ebs_block_device` - (Optional) Additional EBS block devices to attach to the instance. (`default = []`)
- `opsworks_instance_ephemeral_block_device` - (Optional) Customize Ephemeral (also known as 'Instance Store') volumes on the instance. (`default = []`)
- `opsworks_instance_timeouts` - Set timeouts for opsworks instance (`default = []`)
- `enable_opsworks_rds_db_instance` - Enable opsworks rds db instance usage (`default = False`)
- `opsworks_rds_db_instance_stack_id` - The stack to register a db instance for. Changing this will force a new resource. (`default = ""`)
- `opsworks_rds_db_instance_rds_db_instance_arn` - (Required) The db instance to register for this stack. Changing this will force a new resource. (`default = ""`)
- `opsworks_rds_db_instance_db_user` - (Required) A db username (`default = ""`)
- `opsworks_rds_db_instance_db_password` - (Required) A db password (`default = ""`)
- `enable_opsworks_permission` - Enable opsworks permission usage (`default = False`)
- `opsworks_permission_stack_id` - (Required) The stack to set the permissions for (`default = ""`)
- `opsworks_permission_user_arn` - (Required) The user's IAM ARN to set permissions for (`default = ""`)
- `opsworks_permission_allow_ssh` - (Optional) Whether the user is allowed to use SSH to communicate with the instance (`default = True`)
- `opsworks_permission_allow_sudo` - (Optional) Whether the user is allowed to use sudo to elevate privileges (`default = True`)
- `opsworks_permission_level` - (Optional) The users permission level. Mus be one of deny, show, deploy, manage, iam_only (`default = iam_only`)

## Module Output Variables
----------------------
- `opsworks_stack_id` - The id of the stack.
- `opsworks_static_web_layer_id` - The id of the layer.
- `opsworks_custom_layer_id` - The id of the custom layer.
- `opsworks_ganglia_layer_id` - The id of the ganglia layer.
- `opsworks_haproxy_layer_id` - The id of the haproxy layer.
- `opsworks_memcached_layer_id` - The id of the memcached layer.
- `opsworks_mysql_layer_id` - The id of the mysql layer.
- `opsworks_java_app_layer_id` - The id of the java app layer.
- `opsworks_nodejs_app_layer_id` - The id of the nodejs app layer.
- `opsworks_php_app_layer_id` - The id of the php app layer.
- `opsworks_rails_app_layer_id` - The id of the rails app layer.
- `opsworks_user_profile_id` - Same value as user_arn
- `opsworks_application_id` - The id of the application.
- `opsworks_instance_id` - The id of the OpsWorks instance.
- `opsworks_instance_agent_version` - The AWS OpsWorks agent version.
- `opsworks_instance_availability_zone` - The availability zone of the instance.
- `opsworks_instance_ec2_instance_id` - EC2 instance ID
- `opsworks_instance_ssh_key_name` - The key name of the instance
- `opsworks_instance_public_dns` - The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC.
- `opsworks_instance_public_ip` - The public IP address assigned to the instance, if applicable.
- `opsworks_instance_private_dns` - The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC
- `opsworks_instance_private_ip` - The private IP address assigned to the instance
- `opsworks_instance_subnet_id` - The VPC subnet ID.
- `opsworks_instance_tenancy` - The Instance tenancy
- `opsworks_instance_security_group_ids` - The associated security groups.
- `opsworks_rds_db_instance_id` - The computed id. Please note that this is only used internally to identify the stack <-> instance relation. This value is not used in aws.
- `opsworks_permission_id` - The computed id of the permission. Please note that this is only used internally to identify the permission. This value is not used in aws.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
