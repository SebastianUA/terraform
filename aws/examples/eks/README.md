# Work with EKS via terraform

A terraform module for making EKS.


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
  region  = "us-east-1"
  profile = "default"
}

module "iam_role" {
  source      = "../../modules/iam_role"
  name        = "TEST"
  environment = "stage"

  # Using IAM role
  enable_iam_role      = true
  iam_role_name        = "tf-role-for-testing"
  iam_role_description = "It's just a simple IAM role to test TF module"
  # Inside additional_files directory I will add additional policies for assume_role_policy usage in the future....
  assume_role_policy = file("additional_files/iam/assume_role_policy_with_mfa.json")

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy
  enable_iam_role_policy = true
  iam_role_policy_name   = "my-iam-role-policy-for-testing-terraform"
  iam_role_policy        = file("additional_files/iam/policy.json")

  # Using IAM role policy attachment
  enable_iam_role_policy_attachment = false
  policy_arns                       = ["test"]

  # Using IAM instance profile
  enable_iam_instance_profile = true
  iam_instance_profile_name   = "tf-role-for-testing"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "vpc" {
  source      = "../../modules/vpc"
  name        = "test"
  environment = "stage"

  # VPC
  enable_vpc = true
  vpc_name   = ""

  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
  # Dedicated tenancy VPCs cannot be enabled for ClassicLink by default
  enable_classiclink = false

  vpc_cidr             = "172.32.0.0/16"
  private_subnet_cidrs = ["172.32.64.0/20"]
  public_subnet_cidrs  = ["172.32.80.0/20", "172.32.0.0/20"]
  #azs                                 = ["us-east-1a", "us-east-1b"]

  #Internet-GateWay
  enable_internet_gateway = true
  # NAT GW
  enable_nat_gateway = false
  single_nat_gateway = true
  # VPN GW
  enable_vpn_gateway = false
  # DHCP
  enable_dhcp = true
  # EIP
  enable_eip = false

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "eks" {
  source      = "../../modules/eks"
  name        = "TEST"
  environment = "NonProd"

  # Create AWS EKS cluster
  enable_eks_cluster   = true
  eks_cluster_name     = "eks-test-cluster-1"
  eks_cluster_role_arn = module.iam_role.iam_role_arn

  eks_cluster_enabled_cluster_log_types = ["api", "audit"]
  eks_cluster_version                   = null

  eks_cluster_vpc_config = [
    {
      subnet_ids = module.vpc.private_subnets_ids

      public_access_cidrs     = null
      endpoint_private_access = null
      endpoint_public_access  = null
      security_group_ids      = null
    }
  ]

  eks_cluster_encryption_config = []

  # AWS EKS NodeGroup
  enable_eks_node_group          = true
  eks_node_group_node_group_name = "dev-1"
  eks_node_group_node_role_arn   = module.iam_role.iam_role_arn // only as for example!
  eks_node_group_subnet_ids      = module.vpc.private_subnets_ids

  eks_node_group_scaling_config = [
    {
      max_size     = 1
      desired_size = 1
      min_size     = 1
    }
  ]

  eks_node_group_ami_type       = "AL2_x86_64"
  eks_node_group_disk_size      = 20
  eks_node_group_instance_types = ["t3.medium"]

  eks_node_group_remote_access = [
    {
      ec2_ssh_key               = null
      source_security_group_ids = null
    }
  ]

  eks_node_group_launch_template = []
  eks_node_group_timeouts        = []

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
- `enable_eks_cluster` - Enable creating AWS EKS cluster (`default = False`)
- `eks_cluster_name` - Custom name of the cluster. (`default = ""`)
- `eks_cluster_role_arn` - (Required) The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf. (`default = ""`)
- `eks_cluster_enabled_cluster_log_types` - (Optional) A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging (`default = []`)
- `eks_cluster_version` - (Optional) Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS. (`default = null`)
- `eks_cluster_vpc_config` - (Required) Nested argument for the VPC associated with your cluster. Amazon EKS VPC resources have specific requirements to work properly with Kubernetes. For more information, see Cluster VPC Considerations and Cluster Security Group Considerations in the Amazon EKS User Guide. (`default = []`)
- `eks_cluster_encryption_config` - (Optional) Configuration block with encryption configuration for the cluster. Only available on Kubernetes 1.13 and above clusters created after March 6, 2020. (`default = []`)
- `eks_cluster_timeouts` - Set timeouts for EKS cluster (`default = {}`)
- `enable_eks_fargate_profile` - Enable EKS fargate profile usage (`default = False`)
- `eks_fargate_profile_name` - Name of the EKS Fargate Profile. (`default = ""`)
- `eks_fargate_profile_cluster_name` - Name of the EKS Cluster. (`default = ""`)
- `eks_fargate_profile_pod_execution_role_arn` - (Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Fargate Profile. (`default = ""`)
- `eks_fargate_profile_subnet_ids` - (Required) Identifiers of private EC2 Subnets to associate with the EKS Fargate Profile. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster). (`default = []`)
- `eks_fargate_profile_selector` - (Required) Configuration block(s) for selecting Kubernetes Pods to execute with this EKS Fargate Profile.  (`default = []`)
- `eks_fargate_profile_timeouts` - Set timeouts for EKS fargate profile (`default = {}`)
- `enable_eks_node_group` - Enable EKS node group usage (`default = False`)
- `eks_node_group_node_group_name` - Name of the EKS Node Group. (`default = ""`)
- `eks_node_group_cluster_name` - Name of the EKS Cluster. (`default = ""`)
- `eks_node_group_node_role_arn` - (Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group. (`default = ""`)
- `eks_node_group_subnet_ids` - (Required) Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster). (`default = []`)
- `eks_node_group_scaling_config` - "" (`default = [{'max_size': 1, 'desired_size': 1, 'min_size': 1}]`)
- `eks_node_group_ami_type` - (Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU. Terraform will only perform drift detection if a configuration value is provided. (`default = AL2_x86_64`)
- `eks_node_group_disk_size` - (Optional) Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided. (`default = 20`)
- `eks_node_group_force_update_version` - (Optional) Force version update if existing pods are unable to be drained due to a pod disruption budget issue. (`default = null`)
- `eks_node_group_instance_types` - (Optional) Set of instance types associated with the EKS Node Group. Defaults to ['t3.medium']. Terraform will only perform drift detection if a configuration value is provided. Currently, the EKS API only accepts a single value in the set. (`default = ['t3.medium']`)
- `eks_node_group_labels` - (Optional) Key-value mapping of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed. (`default = {}`)
- `eks_node_group_release_version` - (Optional) AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version. (`default = null`)
- `eks_node_group_version` - (Optional) Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided. (`default = null`)
- `eks_node_group_remote_access` - (Optional) Configuration block with remote access settings. (`default = []`)
- `eks_node_group_launch_template` - (Optional) Configuration block with Launch Template settings. (`default = []`)
- `eks_node_group_timeouts` - Set timeouts for EKS node group (`default = {}`)

## Module Output Variables
----------------------
- `eks_cluster_id` - The name of the cluster.
- `eks_cluster_arn` - The Amazon Resource Name (ARN) of the cluster.
- `eks_cluster_endpoint` - The endpoint for your Kubernetes API server.
- `eks_cluster_identity` - Nested attribute containing identity provider information for your cluster. Only available on Kubernetes version 1.13 and 1.14 clusters created or upgraded on or after September 3, 2019.
- `eks_cluster_platform_version` - The platform version for the cluster.
- `eks_cluster_status` - TThe status of the EKS cluster. One of CREATING, ACTIVE, DELETING, FAILED.
- `eks_cluster_version` - The Kubernetes server version for the cluster.
- `eks_cluster_certificate_authority` - Nested attribute containing certificate-authority-data for your cluster.
- `eks_cluster_vpc_config` - Additional nested attributes
- `eks_fargate_profile_arn` - Amazon Resource Name (ARN) of the EKS Fargate Profile.
- `eks_fargate_profile_id` - EKS Cluster name and EKS Fargate Profile name separated by a colon (:).
- `eks_fargate_profile_status` - Status of the EKS Fargate Profile.
- `eks_node_group_arn` - Amazon Resource Name (ARN) of the EKS Node Group.
- `eks_node_group_id` - EKS Cluster name and EKS Node Group name separated by a colon (:).
- `eks_node_group_status` - Status of the EKS Node Group.
- `eks_node_group_resources` - List of objects containing information about underlying resources.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
