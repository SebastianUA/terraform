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
