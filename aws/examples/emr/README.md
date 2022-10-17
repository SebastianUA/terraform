# Work with EMR via terraform

A terraform module for making EMR.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "vpc" {
  source      = "../../modules/vpc"
  name        = "endpoint"
  environment = "stage"

  # VPC
  enable_vpc                           = true
  vpc_name                             = "vpc_endpoint"
  vpc_instance_tenancy                 = "dedicated"
  vpc_enable_dns_support               = true
  vpc_enable_dns_hostnames             = true
  vpc_assign_generated_ipv6_cidr_block = false
  # Dedicated tenancy VPCs cannot be enabled for ClassicLink by default
  vpc_enable_classiclink = false
  vpc_cidr_block         = "10.11.0.0/16"

  private_subnet_cidrs = ["10.11.1.0/24"]
  public_subnet_cidrs  = ["10.11.2.0/24", "10.11.3.0/24"]

  # Internet-GateWay
  enable_internet_gateway = true

  # NAT
  enable_nat_gateway = false
  single_nat_gateway = false

  # DHCP
  enable_dhcp                          = true
  vpc_dhcp_options_domain_name         = "ec2.internal"
  vpc_dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  # EIP
  enable_eip = false


  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "emr" {
  source      = "../../modules/emr"
  name        = "TEST"
  environment = "stage"

  # EMR security
  enable_emr_security_configuration        = false
  emr_security_configuration_name          = "emr-security-config"
  emr_security_configuration_configuration = file("./additional_files/erm-security-config.json")

  # EMR cluster
  enable_emr_cluster        = true
  emr_cluster_name          = "emr-cluster-name"
  emr_cluster_release_label = "emr-6.2.0"
  emr_cluster_service_role  = "arn:aws:iam::167127734783:role/emr-service-role"

  emr_cluster_applications                      = ["Spark", "Presto", "Hadoop", "Hive", "Zeppelin"]
  emr_cluster_additional_info                   = file("./additional_files/emr-cluster-additional_info.json")
  emr_cluster_termination_protection            = false
  emr_cluster_keep_job_flow_alive_when_no_steps = true
  emr_cluster_ebs_root_volume_size              = 30
  emr_cluster_configurations_json               = file("./additional_files/emr-cluster-configurations_json.json")
  emr_cluster_autoscaling_role                  = "arn:aws:iam::167127734783:role/emr-service-role"

  emr_cluster_ec2_attributes = [
    {
      # If you want to use public subnet. Tested! :
      # subnet_id                           = element(module.vpc.public_subnets_ids, 0)
      # emr_managed_master_security_group   = module.vpc.vpc_default_security_group_id
      # emr_managed_slave_security_group    = module.vpc.vpc_default_security_group_id
      # instance_profile                    = "arn:aws:iam::167127734783:instance-profile/emr-service-role"

      # If you want to use private subnet:
      subnet_id                         = element(module.vpc.private_subnets_ids, 0)
      emr_managed_master_security_group = "sg-0ac2ce954f45c8f6a"
      emr_managed_slave_security_group  = "sg-0ac2ce954f45c8f6a"
      # You cannot specify a ServiceAccessSecurityGroup for a cluster launched in public subnet
      service_access_security_group = "sg-0919aabecaea96510"
      instance_profile              = "arn:aws:iam::167127734783:instance-profile/emr-service-role"
    }
  ]

  emr_cluster_master_instance_group = [
    {
      instance_type  = "m4.large"
      instance_count = 1

      ebs_config = {
        size                 = 10
        type                 = "gp2"
        volumes_per_instance = 1
      }
    }
  ]

  emr_cluster_core_instance_group = [
    {
      instance_type  = "c4.large"
      instance_count = 1
      # bid_price                       = "1.30"
      autoscaling_policy = file("./additional_files/emr-cluster-core_instance_group-autoscaling_policy.json")

      ebs_config = {
        size                 = 10
        type                 = "gp2"
        volumes_per_instance = 1
      }
    }
  ]

  # it's not working when uses private sabnet;
  # The VPC/subnet configuration was invalid: Your cluster needs access to SQS to enable debugging but subnet does not have route to access SQS. Learn more about private subnet configurations: https://docs.aws.amazon.com/ElasticMapReduce/latest/ManagementGuide/emr-plan-vpc-subnet.html
  emr_cluster_bootstrap_action = [
    {
      path = "s3://elasticmapreduce/bootstrap-actions/run-if"
      name = "runif"
      args = ["instance.isMaster=true", "echo running on master node"]
    },
    {
      path = "s3://alluxio-public/enterprise-emr/2.2.1-1.4/alluxio-emr.sh"
      name = "Install-Alluxio"
      args = [
        "s3://S3_BUCKET_HERE/alluxio-ufs",
        "-d", "https://downloads.alluxio.io/downloads/files/2.2.1/alluxio-2.2.1-bin.tar.gz",
        "-p", "alluxio.user.block.size.bytes.default=122M|alluxio.user.file.writetype.default=CACHE_THROUGH",
        "-s", "|"
      ]
    }
  ]

  emr_cluster_step = [
    {
      name              = "Setup Hadoop Debugging"
      action_on_failure = "TERMINATE_CLUSTER"

      hadoop_jar_step = {
        jar  = "command-runner.jar"
        args = ["state-pusher-script"]
      }
    }
  ]

  # EMR instance group
  enable_emr_instance_group         = true
  emr_instance_group_name           = "emr-instance-group"
  emr_instance_group_instance_type  = "m5.xlarge"
  emr_instance_group_instance_count = 1
  emr_instance_group_ebs_config = [{
    size                 = 10
    type                 = "gp2"
    volumes_per_instance = 1
  }]

  emr_instance_group_autoscaling_policy  = file("./additional_files/emr-cluster-core_instance_group-autoscaling_policy.json")
  emr_instance_group_configurations_json = file("./additional_files/emr-cluster-configurations_json.json")

  # EMR instance fleet
  enable_emr_instance_fleet                    = true
  emr_instance_fleet_name                      = "emr-task-fleet"
  emr_instance_fleet_target_on_demand_capacity = 1
  emr_instance_fleet_target_spot_capacity      = 1

  emr_instance_fleet_instance_type_configs = [
    {
      bid_price                                  = null
      bid_price_as_percentage_of_on_demand_price = 100
      weighted_capacity                          = 1
      instance_type                              = "m4.xlarge"

      ebs_config = {
        size                 = 100
        type                 = "gp2"
        volumes_per_instance = 1
      }
    }
  ]

  emr_instance_fleet_launch_specifications = [
    {
      spot_specification = {
        allocation_strategy      = "capacity-optimized"
        block_duration_minutes   = 0
        timeout_action           = "TERMINATE_CLUSTER"
        timeout_duration_minutes = 10
      }
    }
  ]

  # EMR managed scaling policy
  enable_emr_managed_scaling_policy = true
  emr_managed_scaling_policy_compute_limits = [
    {
      unit_type                       = "InstanceFleetUnits"
      minimum_capacity_units          = 2
      maximum_capacity_units          = 10
      maximum_ondemand_capacity_units = 2
      maximum_core_capacity_units     = 10
    },
    {
      unit_type                       = "Instances"
      minimum_capacity_units          = 2
      maximum_capacity_units          = 10
      maximum_ondemand_capacity_units = 2
      maximum_core_capacity_units     = 10
    },
    {
      unit_type                       = "VCPU"
      minimum_capacity_units          = 2
      maximum_capacity_units          = 10
      maximum_ondemand_capacity_units = 2
      maximum_core_capacity_units     = 10
    }
  ]

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
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_emr_cluster` - Enable emr cluster usage (`default = False`)
- `emr_cluster_name` - The name of the job flow (`default = ""`)
- `emr_cluster_release_label` - (Required) The release label for the Amazon EMR release (`default = null`)
- `emr_cluster_service_role` - (Required) IAM role that will be assumed by the Amazon EMR service to access AWS resources (`default = null`)
- `emr_cluster_scale_down_behavior` - (Optional) The way that individual Amazon EC2 instances terminate when an automatic scale-in activity occurs or an instance group is resized. (`default = null`)
- `emr_cluster_additional_info` - (Optional) A JSON string for selecting additional features such as adding proxy information. Note: Currently there is no API to retrieve the value of this argument after EMR cluster creation from provider, therefore Terraform cannot detect drift from the actual EMR cluster if its value is changed outside Terraform. (`default = null`)
- `emr_cluster_security_configuration` - (Optional) The security configuration name to attach to the EMR cluster. Only valid for EMR clusters with release_label 4.8.0 or greater (`default = null`)
- `emr_cluster_log_uri` - (Optional) S3 bucket to write the log files of the job flow. If a value is not provided, logs are not created (`default = null`)
- `emr_cluster_applications` - (Optional) A list of applications for the cluster. Valid values are: Flink, Hadoop, Hive, Mahout, Pig, Spark, and JupyterHub (as of EMR 5.14.0). Case insensitive (`default = null`)
- `emr_cluster_termination_protection` - (Optional) Switch on/off termination protection (default is false, except when using multiple master nodes). Before attempting to destroy the resource when termination protection is enabled, this configuration must be applied with its value set to false. (`default = False`)
- `emr_cluster_keep_job_flow_alive_when_no_steps` - (Optional) Switch on/off run cluster with no steps or when all steps are complete (default is on) (`default = null`)
- `emr_cluster_ebs_root_volume_size` - (Optional) Size in GiB of the EBS root device volume of the Linux AMI that is used for each EC2 instance. Available in Amazon EMR version 4.x and later. (`default = null`)
- `emr_cluster_custom_ami_id` - (Optional) A custom Amazon Linux AMI for the cluster (instead of an EMR-owned AMI). Available in Amazon EMR version 5.7.0 and later. (`default = null`)
- `emr_cluster_configurations` - (Optional) List of configurations supplied for the EMR cluster you are creating (`default = null`)
- `emr_cluster_configurations_json` - (Optional) A JSON string for supplying list of configurations for the EMR cluster. (`default = null`)
- `emr_cluster_visible_to_all_users` - Optional) Whether the job flow is visible to all IAM users of the AWS account associated with the job flow. Default true (`default = True`)
- `emr_cluster_autoscaling_role` - (Optional) An IAM role for automatic scaling policies. The IAM role provides permissions that the automatic scaling feature requires to launch and terminate EC2 instances in an instance group. (`default = null`)
- `emr_cluster_step_concurrency_level` - (Optional) The number of steps that can be executed concurrently. You can specify a maximum of 256 steps. Only valid for EMR clusters with release_label 5.28.0 or greater. (default is 1) (`default = 1`)
- `emr_cluster_master_instance_group` - (Optional) Configuration block to use an Instance Group for the master node type. Cannot be specified if master_instance_type argument or instance_group configuration blocks are set. (`default = []`)
- `emr_cluster_core_instance_group` - (Optional) Configuration block to use an Instance Group for the core node type. Cannot be specified if core_instance_count argument, core_instance_type argument, or instance_group configuration blocks are set. (`default = []`)
- `emr_cluster_master_instance_fleet` - (Optional) Configuration block to use an Instance Fleet for the master node type. Cannot be specified if master_instance_type argument or instance_group configuration blocks are set. (`default = []`)
- `emr_cluster_core_instance_fleet` - (Optional) Configuration block to use an Instance Fleet for the core node type. Cannot be specified if core_instance_count argument, core_instance_type argument, or instance_group configuration blocks are set. (`default = []`)
- `emr_cluster_ec2_attributes` - (Optional) Attributes for the EC2 instances running the job flow. (`default = []`)
- `emr_cluster_kerberos_attributes` - (Optional) Kerberos configuration for the cluster. (`default = []`)
- `emr_cluster_bootstrap_action` - (Optional) Ordered list of bootstrap actions that will be run before Hadoop is started on the cluster nodes. (`default = []`)
- `emr_cluster_step` - (Optional) List of steps to run when creating the cluster. Defined below. It is highly recommended to utilize the lifecycle configuration block with ignore_changes if other steps are being managed outside of Terraform. This argument is processed in attribute-as-blocks mode. (`default = []`)
- `enable_emr_instance_group` - Enable emr instance group usage (`default = False`)
- `emr_instance_group_name` - Human friendly name given to the instance group. Changing this forces a new resource to be created. (`default = ""`)
- `emr_instance_group_cluster_id` - ID of the EMR Cluster to attach to. Changing this forces a new resource to be created. (`default = ""`)
- `emr_instance_group_instance_type` - (Required) The EC2 instance type for all instances in the instance group. Changing this forces a new resource to be created. (`default = null`)
- `emr_instance_group_instance_count` - (optional) target number of instances for the instance group. defaults to 0. (`default = 0`)
- `emr_instance_group_bid_price` - (Optional) If set, the bid price for each EC2 instance in the instance group, expressed in USD. By setting this attribute, the instance group is being declared as a Spot Instance, and will implicitly create a Spot request. Leave this blank to use On-Demand Instances. (`default = null`)
- `emr_instance_group_ebs_optimized` - (Optional) Indicates whether an Amazon EBS volume is EBS-optimized. Changing this forces a new resource to be created. (`default = null`)
- `emr_instance_group_autoscaling_policy` - (Optional) The autoscaling policy document. This is a JSON formatted string. See EMR Auto Scaling (`default = null`)
- `emr_instance_group_configurations_json` - (Optional) A JSON string for supplying list of configurations specific to the EMR instance group. Note that this can only be changed when using EMR release 5.21 or later. (`default = null`)
- `emr_instance_group_ebs_config` - (Optional) One or more ebs_config blocks as defined below. Changing this forces a new resource to be created. (`default = []`)
- `enable_emr_security_configuration` - Enable emr security configuration usage (`default = False`)
- `emr_security_configuration_configuration` - (Required) A JSON formatted Security Configuration (`default = null`)
- `emr_security_configuration_name` - (Optional) The name of the EMR Security Configuration. By default generated by Terraform. (`default = null`)
- `emr_security_configuration_name_prefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with emr_security_configuration_name. (`default = null`)
- `enable_emr_instance_fleet` - Enable emr instance fleet usage (`default = False`)
- `emr_instance_fleet_cluster_id` - ID of the EMR Cluster to attach to. Changing this forces a new resource to be created. (`default = ""`)
- `emr_instance_fleet_name` - (Optional) Friendly name given to the instance fleet. (`default = ""`)
- `emr_instance_fleet_target_on_demand_capacity` - (Optional) The target capacity of On-Demand units for the instance fleet, which determines how many On-Demand instances to provision. (`default = 1`)
- `emr_instance_fleet_target_spot_capacity` - (Optional) The target capacity of Spot units for the instance fleet, which determines how many Spot instances to provision. (`default = 1`)
- `emr_instance_fleet_instance_type_configs` - (Optional) Configuration block for instance fleet (`default = [{'bid_price': None, 'bid_price_as_percentage_of_on_demand_price': 100, 'weighted_capacity': 1, 'instance_type': 'm4.xlarge'}]`)
- `emr_instance_fleet_ebs_config` - (Optional) Configuration block(s) for EBS volumes attached to each instance in the instance group. (`default = []`)
- `emr_instance_fleet_configurations` - (Optional) A configuration classification that applies when provisioning cluster instances, which can include configurations for applications and software that run on the cluster. List of configuration blocks. (`default = []`)
- `emr_instance_fleet_launch_specifications` - (Optional) Configuration block for launch specifications (`default = []`)
- `enable_emr_managed_scaling_policy` - Enable emr managed scaling policy usage (`default = False`)
- `emr_managed_scaling_policy_cluster_id` - The id of the EMR cluster (`default = ""`)
- `emr_managed_scaling_policy_compute_limits` - (Required) Configuration block with compute limit settings. (`default = []`)
- `enable_emr_studio_session_mapping` - Enable emr studio session mapping usage (`default = False`)
- `emr_studio_session_mapping_studio_id` - The ID of the Amazon EMR Studio to which the user or group will be mapped. (`default = ""`)
- `emr_studio_session_mapping_identity_type` - (Required) Specifies whether the identity to map to the Amazon EMR Studio is a USER or a GROUP (`default = null`)
- `emr_studio_session_mapping_session_policy_arn` - (Required) The Amazon Resource Name (ARN) for the session policy that will be applied to the user or group. You should specify the ARN for the session policy that you want to apply, not the ARN of your user role. (`default = null`)
- `emr_studio_session_mapping_identity_id` - (Optional) The globally unique identifier (GUID) of the user or group from the Amazon Web Services SSO Identity Store. (`default = null`)
- `emr_studio_session_mapping_identity_name` - (Optional) The name of the user or group from the Amazon Web Services SSO Identity Store. (`default = null`)
- `enable_emr_studio_session_mapping` - Enable emr studio session mapping usage (`default = False`)
- `emr_studio_name` - A descriptive name for the Amazon EMR Studio. (`default = ""`)
- `emr_studio_auth_mode` - (Required) Specifies whether the Studio authenticates users using IAM or Amazon Web Services SSO. Valid values are SSO or IAM (`default = null`)
- `emr_studio_default_s3_location` - (Required) The Amazon S3 location to back up Amazon EMR Studio Workspaces and notebook files. (`default = null`)
- `emr_studio_engine_security_group_id` - (Required) The ID of the Amazon EMR Studio Engine security group. The Engine security group allows inbound network traffic from the Workspace security group, and it must be in the same VPC specified by vpc_id (`default = null`)
- `emr_studio_service_role` - (Required) The IAM role that the Amazon EMR Studio assumes. The service role provides a way for Amazon EMR Studio to interoperate with other Amazon Web Services services. (`default = null`)
- `emr_studio_subnet_ids` - (Required) A list of subnet IDs to associate with the Amazon EMR Studio. A Studio can have a maximum of 5 subnets. The subnets must belong to the VPC specified by vpc_id. Studio users can create a Workspace in any of the specified subnets. (`default = null`)
- `emr_studio_vpc_id` - (Required) The ID of the Amazon Virtual Private Cloud (Amazon VPC) to associate with the Studio. (`default = null`)
- `emr_studio_workspace_security_group_id` - (Required) The ID of the Amazon EMR Studio Workspace security group. The Workspace security group allows outbound network traffic to resources in the Engine security group, and it must be in the same VPC specified by vpc_id. (`default = null`)
- `emr_studio_description` - (Optional) A detailed description of the Amazon EMR Studio. (`default = null`)
- `emr_studio_idp_auth_url` - (Optional) The authentication endpoint of your identity provider (IdP). Specify this value when you use IAM authentication and want to let federated users log in to a Studio with the Studio URL and credentials from your IdP. Amazon EMR Studio redirects users to this endpoint to enter credentials. (`default = null`)
- `emr_studio_idp_relay_state_parameter_name` - (Optional) The name that your identity provider (IdP) uses for its RelayState parameter. For example, RelayState or TargetSource. Specify this value when you use IAM authentication and want to let federated users log in to a Studio using the Studio URL. The RelayState parameter differs by IdP. (`default = null`)
- `emr_studio_user_role` - (Optional) - The IAM user role that users and groups assume when logged in to an Amazon EMR Studio. Only specify a User Role when you use Amazon Web Services SSO authentication. The permissions attached to the User Role can be scoped down for each user or group using session policies. (`default = null`)
- `enable_emrcontainers_virtual_cluster` - Enable emrcontainers virtual cluster usage (`default = False`)
- `emrcontainers_virtual_cluster_name` - Name of the virtual cluster. (`default = ""`)
- `emrcontainers_virtual_cluster_container_provider` - (Required) Configuration block for the container provider associated with your cluster. (`default = []`)
- `enable_emrserverless_application` - Enable emrserverless application usage (`default = False`)
- `emrserverless_application_name` - The name of the application. (`default = ""`)
- `emrserverless_application_release_label` - (Required) The EMR release version associated with the application. (`default = null`)
- `emrserverless_application_type` - (Required) The type of application you want to start, such as spark or hive. (`default = null`)
- `emrserverless_application_initial_capacity` - (Optional) The capacity to initialize when the application is created. (`default = {}`)
- `emrserverless_application_maximum_capacity` - (Optional) The maximum capacity to allocate when the application is created. This is cumulative across all workers at any given point in time, not just when an application is created. No new resources will be created once any one of the defined limits is hit. (`default = {}`)
- `emrserverless_application_auto_start_configuration` - (Optional) The configuration for an application to automatically start on job submission. (`default = {}`)
- `emrserverless_application_auto_stop_configuration` - (Optional) The configuration for an application to automatically stop after a certain amount of time being idle. (`default = {}`)
- `emrserverless_application_network_configuration` - (Optional) The network configuration for customer VPC connectivity. (`default = {}`)

## Module Output Variables
----------------------
- `emr_cluster_arn` - The ARN of the cluster.
- `emr_cluster_name` - The name of the cluster.
- `emr_cluster_id` - The ID of the EMR Cluster
- `emr_cluster_release_label` - The release label for the Amazon EMR release.
- `emr_cluster_master_public_dns` - The public DNS name of the master EC2 instance.
- `emr_cluster_log_uri` - The path to the Amazon S3 location where logs for this cluster are stored.
- `emr_cluster_applications` - The applications installed on this cluster.
- `emr_cluster_ec2_attributes` - Provides information about the EC2 instances in a cluster grouped by category: key name, subnet ID, IAM instance profile, and so on.
- `emr_cluster_bootstrap_action` - A list of bootstrap actions that will be run before Hadoop is started on the cluster nodes.
- `emr_cluster_configurations` - The list of Configurations supplied to the EMR cluster.
- `emr_cluster_service_role` - The IAM role that will be assumed by the Amazon EMR service to access AWS resources on your behalf.
- `emr_cluster_visible_to_all_users` - Indicates whether the job flow is visible to all IAM users of the AWS account associated with the job flow.
- `emr_cluster_tags` - The list of tags associated with a cluster.
- `emr_instance_group_id` - The EMR Instance ID
- `emr_instance_group_running_instance_count` - The number of instances currently running in this instance group.
- `emr_instance_group_status` - The current status of the instance group.
- `emr_security_configuration_id` - The ID of the EMR Security Configuration (Same as the name)
- `emr_security_configuration_name` - The Name of the EMR Security Configuration
- `emr_security_configuration_configuration` - The JSON formatted Security Configuration
- `emr_security_configuration_creation_date` - Date the Security Configuration was created
- `emr_instance_fleet_id` - The unique identifier of the instance fleet.
- `emr_instance_fleet_provisioned_spot_capacity` - The number of Spot units that have been provisioned for this instance fleet to fulfill TargetSpotCapacity. This provisioned capacity might be less than or greater than TargetSpotCapacity.
- `emr_instance_fleet_provisioned_on_demand_capacity` - The number of On-Demand units that have been provisioned for the instance fleet to fulfill TargetOnDemandCapacity. This provisioned capacity might be less than or greater than TargetOnDemandCapacity.
- `emr_managed_scaling_policy_id` - The unique identifier of managed scaling policy
- `emr_studio_id` - The id of the Elastic MapReduce Studio.
- `emr_studio_arn` - ARN of the studio.
- `emr_studio_url` - The unique access URL of the Amazon EMR Studio.
- `emr_studio_session_mapping_id` - The id of the Elastic MapReduce Studio Session Mapping.
- `emrcontainers_virtual_cluster_id` - The ID of the cluster.
- `emrcontainers_virtual_cluster_arn` - ARN of the cluster.
- `emrserverless_application_id` - The ID of the cluster.
- `emrserverless_application_arn` - ARN of the cluster.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
