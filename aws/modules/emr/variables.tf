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

#---------------------------------------------------
# AWS EMR studio session mapping
#---------------------------------------------------
variable "enable_emr_studio_session_mapping" {
  description = "Enable emr studio session mapping usage"
  default     = false
}

variable "emr_studio_session_mapping_studio_id" {
  description = "The ID of the Amazon EMR Studio to which the user or group will be mapped."
  default     = ""
}

variable "emr_studio_session_mapping_identity_type" {
  description = "(Required) Specifies whether the identity to map to the Amazon EMR Studio is a USER or a GROUP"
  default     = null
}

variable "emr_studio_session_mapping_session_policy_arn" {
  description = "(Required) The Amazon Resource Name (ARN) for the session policy that will be applied to the user or group. You should specify the ARN for the session policy that you want to apply, not the ARN of your user role."
  default     = null
}

variable "emr_studio_session_mapping_identity_id" {
  description = "(Optional) The globally unique identifier (GUID) of the user or group from the Amazon Web Services SSO Identity Store."
  default     = null
}

variable "emr_studio_session_mapping_identity_name" {
  description = "(Optional) The name of the user or group from the Amazon Web Services SSO Identity Store."
  default     = null
}

#---------------------------------------------------
# AWS EMR studio
#---------------------------------------------------
variable "enable_emr_studio_session_mapping" {
  description = "Enable emr studio session mapping usage"
  default     = false
}

variable "emr_studio_name" {
  description = "A descriptive name for the Amazon EMR Studio."
  default     = ""
}

variable "emr_studio_auth_mode" {
  description = "(Required) Specifies whether the Studio authenticates users using IAM or Amazon Web Services SSO. Valid values are SSO or IAM"
  default     = null
}

variable "emr_studio_default_s3_location" {
  description = "(Required) The Amazon S3 location to back up Amazon EMR Studio Workspaces and notebook files."
  default     = null
}

variable "emr_studio_engine_security_group_id" {
  description = "(Required) The ID of the Amazon EMR Studio Engine security group. The Engine security group allows inbound network traffic from the Workspace security group, and it must be in the same VPC specified by vpc_id"
  default     = null
}

variable "emr_studio_service_role" {
  description = "(Required) The IAM role that the Amazon EMR Studio assumes. The service role provides a way for Amazon EMR Studio to interoperate with other Amazon Web Services services."
  default     = null
}

variable "emr_studio_subnet_ids" {
  description = "(Required) A list of subnet IDs to associate with the Amazon EMR Studio. A Studio can have a maximum of 5 subnets. The subnets must belong to the VPC specified by vpc_id. Studio users can create a Workspace in any of the specified subnets."
  default     = null
}

variable "emr_studio_vpc_id" {
  description = "(Required) The ID of the Amazon Virtual Private Cloud (Amazon VPC) to associate with the Studio."
  default     = null
}

variable "emr_studio_workspace_security_group_id" {
  description = "(Required) The ID of the Amazon EMR Studio Workspace security group. The Workspace security group allows outbound network traffic to resources in the Engine security group, and it must be in the same VPC specified by vpc_id."
  default     = null
}

variable "emr_studio_description" {
  description = "(Optional) A detailed description of the Amazon EMR Studio."
  default     = null
}

variable "emr_studio_idp_auth_url" {
  description = "(Optional) The authentication endpoint of your identity provider (IdP). Specify this value when you use IAM authentication and want to let federated users log in to a Studio with the Studio URL and credentials from your IdP. Amazon EMR Studio redirects users to this endpoint to enter credentials."
  default     = null
}

variable "emr_studio_idp_relay_state_parameter_name" {
  description = "(Optional) The name that your identity provider (IdP) uses for its RelayState parameter. For example, RelayState or TargetSource. Specify this value when you use IAM authentication and want to let federated users log in to a Studio using the Studio URL. The RelayState parameter differs by IdP."
  default     = null
}

variable "emr_studio_user_role" {
  description = "(Optional) - The IAM user role that users and groups assume when logged in to an Amazon EMR Studio. Only specify a User Role when you use Amazon Web Services SSO authentication. The permissions attached to the User Role can be scoped down for each user or group using session policies."
  default     = null
}

#---------------------------------------------------
# AWS EMR containers virtual cluster
#---------------------------------------------------
variable "enable_emrcontainers_virtual_cluster" {
  description = "Enable emrcontainers virtual cluster usage"
  default     = false
}

variable "emrcontainers_virtual_cluster_name" {
  description = "Name of the virtual cluster."
  default     = ""
}

variable "emrcontainers_virtual_cluster_container_provider" {
  description = "(Required) Configuration block for the container provider associated with your cluster."
  default     = []
}

#---------------------------------------------------
# AWS emr serverless application
#---------------------------------------------------
variable "enable_emrserverless_application" {
  description = "Enable emrserverless application usage"
  default     = false
}

variable "emrserverless_application_name" {
  description = "The name of the application."
  default     = ""
}

variable "emrserverless_application_release_label" {
  description = "(Required) The EMR release version associated with the application."
  default     = null
}

variable "emrserverless_application_type" {
  description = "(Required) The type of application you want to start, such as spark or hive."
  default     = null
}

variable "emrserverless_application_initial_capacity" {
  description = "(Optional) The capacity to initialize when the application is created."
  default     = {}
}

variable "emrserverless_application_maximum_capacity" {
  description = "(Optional) The maximum capacity to allocate when the application is created. This is cumulative across all workers at any given point in time, not just when an application is created. No new resources will be created once any one of the defined limits is hit."
  default     = {}
}

variable "emrserverless_application_auto_start_configuration" {
  description = "(Optional) The configuration for an application to automatically start on job submission."
  default     = {}
}

variable "emrserverless_application_auto_stop_configuration" {
  description = "(Optional) The configuration for an application to automatically stop after a certain amount of time being idle."
  default     = {}
}

variable "emrserverless_application_network_configuration" {
  description = "(Optional) The network configuration for customer VPC connectivity."
  default     = {}
}