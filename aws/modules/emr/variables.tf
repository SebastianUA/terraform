#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS EMR cluster
#---------------------------------------------------
variable "enable_emr_cluster" {
  description = "Enable emr cluster usage"
  default     = false
}

variable "emr_cluster_name" {
  description = "The name of the job flow"
  default     = ""
}

variable "emr_cluster_release_label" {
  description = "(Required) The release label for the Amazon EMR release"
  default     = null
}

variable "emr_cluster_service_role" {
  description = "(Required) IAM role that will be assumed by the Amazon EMR service to access AWS resources"
  default     = null
}

variable "emr_cluster_scale_down_behavior" {
  description = "(Optional) The way that individual Amazon EC2 instances terminate when an automatic scale-in activity occurs or an instance group is resized."
  default     = null
}

variable "emr_cluster_additional_info" {
  description = "(Optional) A JSON string for selecting additional features such as adding proxy information. Note: Currently there is no API to retrieve the value of this argument after EMR cluster creation from provider, therefore Terraform cannot detect drift from the actual EMR cluster if its value is changed outside Terraform."
  default     = null
}

variable "emr_cluster_security_configuration" {
  description = "(Optional) The security configuration name to attach to the EMR cluster. Only valid for EMR clusters with release_label 4.8.0 or greater"
  default     = null
}

variable "emr_cluster_log_uri" {
  description = "(Optional) S3 bucket to write the log files of the job flow. If a value is not provided, logs are not created"
  default     = null
}

variable "emr_cluster_applications" {
  description = "(Optional) A list of applications for the cluster. Valid values are: Flink, Hadoop, Hive, Mahout, Pig, Spark, and JupyterHub (as of EMR 5.14.0). Case insensitive"
  default     = null
}

variable "emr_cluster_termination_protection" {
  description = "(Optional) Switch on/off termination protection (default is false, except when using multiple master nodes). Before attempting to destroy the resource when termination protection is enabled, this configuration must be applied with its value set to false."
  default     = false
}

variable "emr_cluster_keep_job_flow_alive_when_no_steps" {
  description = "(Optional) Switch on/off run cluster with no steps or when all steps are complete (default is on)"
  default     = null
}

variable "emr_cluster_ebs_root_volume_size" {
  description = "(Optional) Size in GiB of the EBS root device volume of the Linux AMI that is used for each EC2 instance. Available in Amazon EMR version 4.x and later."
  default     = null
}

variable "emr_cluster_custom_ami_id" {
  description = "(Optional) A custom Amazon Linux AMI for the cluster (instead of an EMR-owned AMI). Available in Amazon EMR version 5.7.0 and later."
  default     = null
}

variable "emr_cluster_configurations" {
  description = "(Optional) List of configurations supplied for the EMR cluster you are creating"
  default     = null
}

variable "emr_cluster_configurations_json" {
  description = "(Optional) A JSON string for supplying list of configurations for the EMR cluster."
  default     = null
}

variable "emr_cluster_visible_to_all_users" {
  description = "Optional) Whether the job flow is visible to all IAM users of the AWS account associated with the job flow. Default true"
  default     = true
}

variable "emr_cluster_autoscaling_role" {
  description = "(Optional) An IAM role for automatic scaling policies. The IAM role provides permissions that the automatic scaling feature requires to launch and terminate EC2 instances in an instance group."
  default     = null
}

variable "emr_cluster_step_concurrency_level" {
  description = "(Optional) The number of steps that can be executed concurrently. You can specify a maximum of 256 steps. Only valid for EMR clusters with release_label 5.28.0 or greater. (default is 1)"
  default     = 1
}

variable "emr_cluster_master_instance_group" {
  description = "(Optional) Configuration block to use an Instance Group for the master node type. Cannot be specified if master_instance_type argument or instance_group configuration blocks are set."
  default     = []
}

variable "emr_cluster_core_instance_group" {
  description = "(Optional) Configuration block to use an Instance Group for the core node type. Cannot be specified if core_instance_count argument, core_instance_type argument, or instance_group configuration blocks are set."
  default     = []
}

variable "emr_cluster_master_instance_fleet" {
  description = "(Optional) Configuration block to use an Instance Fleet for the master node type. Cannot be specified if master_instance_type argument or instance_group configuration blocks are set."
  default     = []
}

variable "emr_cluster_core_instance_fleet" {
  description = "(Optional) Configuration block to use an Instance Fleet for the core node type. Cannot be specified if core_instance_count argument, core_instance_type argument, or instance_group configuration blocks are set."
  default     = []
}

variable "emr_cluster_ec2_attributes" {
  description = "(Optional) Attributes for the EC2 instances running the job flow."
  default     = []
}

variable "emr_cluster_kerberos_attributes" {
  description = "(Optional) Kerberos configuration for the cluster."
  default     = []
}

variable "emr_cluster_bootstrap_action" {
  description = "(Optional) Ordered list of bootstrap actions that will be run before Hadoop is started on the cluster nodes."
  default     = []
}

variable "emr_cluster_step" {
  description = "(Optional) List of steps to run when creating the cluster. Defined below. It is highly recommended to utilize the lifecycle configuration block with ignore_changes if other steps are being managed outside of Terraform. This argument is processed in attribute-as-blocks mode."
  default     = []
}

#---------------------------------------------------
# AWS EMR instance group
#---------------------------------------------------
variable "enable_emr_instance_group" {
  description = "Enable emr instance group usage"
  default     = false
}

variable "emr_instance_group_name" {
  description = "Human friendly name given to the instance group. Changing this forces a new resource to be created."
  default     = ""
}

variable "emr_instance_group_cluster_id" {
  description = "ID of the EMR Cluster to attach to. Changing this forces a new resource to be created."
  default     = ""
}

variable "emr_instance_group_instance_type" {
  description = "(Required) The EC2 instance type for all instances in the instance group. Changing this forces a new resource to be created."
  default     = null
}

variable "emr_instance_group_instance_count" {
  description = "(optional) target number of instances for the instance group. defaults to 0."
  default     = 0
}

variable "emr_instance_group_bid_price" {
  description = "(Optional) If set, the bid price for each EC2 instance in the instance group, expressed in USD. By setting this attribute, the instance group is being declared as a Spot Instance, and will implicitly create a Spot request. Leave this blank to use On-Demand Instances."
  default     = null
}

variable "emr_instance_group_ebs_optimized" {
  description = "(Optional) Indicates whether an Amazon EBS volume is EBS-optimized. Changing this forces a new resource to be created."
  default     = null
}

variable "emr_instance_group_autoscaling_policy" {
  description = "(Optional) The autoscaling policy document. This is a JSON formatted string. See EMR Auto Scaling"
  default     = null
}

variable "emr_instance_group_configurations_json" {
  description = "(Optional) A JSON string for supplying list of configurations specific to the EMR instance group. Note that this can only be changed when using EMR release 5.21 or later."
  default     = null
}

variable "emr_instance_group_ebs_config" {
  description = "(Optional) One or more ebs_config blocks as defined below. Changing this forces a new resource to be created."
  default     = []
}

#---------------------------------------------------
# AWS EMR security configuration
#---------------------------------------------------
variable "enable_emr_security_configuration" {
  description = "Enable emr security configuration usage"
  default     = false
}

variable "emr_security_configuration_configuration" {
  description = "(Required) A JSON formatted Security Configuration"
  default     = null
}

variable "emr_security_configuration_name" {
  description = "(Optional) The name of the EMR Security Configuration. By default generated by Terraform."
  default     = null
}

variable "emr_security_configuration_name_prefix" {
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with emr_security_configuration_name."
  default     = null
}

#---------------------------------------------------
# AWS EMR instance fleet
#---------------------------------------------------
variable "enable_emr_instance_fleet" {
  description = "Enable emr instance fleet usage"
  default     = false
}

variable "emr_instance_fleet_cluster_id" {
  description = "ID of the EMR Cluster to attach to. Changing this forces a new resource to be created."
  default     = ""
}

variable "emr_instance_fleet_name" {
  description = "(Optional) Friendly name given to the instance fleet."
  default     = ""
}

variable "emr_instance_fleet_target_on_demand_capacity" {
  description = "(Optional) The target capacity of On-Demand units for the instance fleet, which determines how many On-Demand instances to provision."
  default     = 1
}

variable "emr_instance_fleet_target_spot_capacity" {
  description = "(Optional) The target capacity of Spot units for the instance fleet, which determines how many Spot instances to provision."
  default     = 1
}

variable "emr_instance_fleet_instance_type_configs" {
  description = "(Optional) Configuration block for instance fleet"
  default = [
    {
      bid_price                                  = null
      bid_price_as_percentage_of_on_demand_price = 100
      weighted_capacity                          = 1
      instance_type                              = "m4.xlarge"
    }
  ]
}

variable "emr_instance_fleet_ebs_config" {
  description = "(Optional) Configuration block(s) for EBS volumes attached to each instance in the instance group."
  default     = []
}

variable "emr_instance_fleet_configurations" {
  description = "(Optional) A configuration classification that applies when provisioning cluster instances, which can include configurations for applications and software that run on the cluster. List of configuration blocks."
  default     = []
}

variable "emr_instance_fleet_launch_specifications" {
  description = "(Optional) Configuration block for launch specifications"
  default     = []
}

#---------------------------------------------------
# AWS EMR managed scaling policy
#---------------------------------------------------
variable "enable_emr_managed_scaling_policy" {
  description = "Enable emr managed scaling policy usage"
  default     = false
}

variable "emr_managed_scaling_policy_cluster_id" {
  description = "The id of the EMR cluster"
  default     = ""
}

variable "emr_managed_scaling_policy_compute_limits" {
  description = "(Required) Configuration block with compute limit settings."
  default     = []
}