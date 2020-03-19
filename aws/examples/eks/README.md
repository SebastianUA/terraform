# Work with AWS EKS via terraform

A terraform module for making AWS EKS.

## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region  = "us-east-1"
    profile = "default"
}

module "iam_role" {
    source                                          = "../../modules/iam_role"
    name                                            = "TEST"
    environment                                     = "stage"

    # Using IAM role
    enable_iam_role                                 = true
    iam_role_name                                   = "tf-role-for-testing"
    iam_role_description                            = "It's just a simple IAM role to test TF module"
    # Inside additional_files directory I will add additional policies for assume_role_policy usage in the future....
    assume_role_policy                              = file("additional_files/iam/assume_role_policy_with_mfa.json")

    iam_role_force_detach_policies                  = true
    iam_role_path                                   = "/"
    iam_role_max_session_duration                   = 3600

    # Using IAM role policy
    enable_iam_role_policy                          = true
    iam_role_policy_name                            = "my-iam-role-policy-for-testing-terraform"
    iam_role_policy                                 = file("additional_files/iam/policy.json")

    # Using IAM role policy attachment
    enable_iam_role_policy_attachment               = false
    policy_arns                                     = ["test"]

    # Using IAM instance profile
    enable_iam_instance_profile                     = true
    iam_instance_profile_name                       = "tf-role-for-testing"

    tags                                            = map("Env", "stage", "Orchestration", "Terraform")
}

module "vpc" {
    source                              = "../../modules/vpc"
    name                                = "test"
    environment                         = "stage"

    # VPC
    enable_vpc                          = true
    vpc_name                            = ""

    instance_tenancy                    = "default"
    enable_dns_support                  = true
    enable_dns_hostnames                = true
    assign_generated_ipv6_cidr_block    = false
    # Dedicated tenancy VPCs cannot be enabled for ClassicLink by default
    enable_classiclink                  = false

    vpc_cidr                            = "172.32.0.0/16"
    private_subnet_cidrs                = ["172.32.64.0/20"]
    public_subnet_cidrs                 = ["172.32.80.0/20", "172.32.0.0/20"]
    #azs                                 = ["us-east-1a", "us-east-1b"]

    #Internet-GateWay
    enable_internet_gateway             = true
    # NAT GW
    enable_nat_gateway                  = false
    single_nat_gateway                  = true
    # VPN GW
    enable_vpn_gateway                  = false
    # DHCP
    enable_dhcp                         = true
    # EIP
    enable_eip                          = false

    tags                                = map("Env", "stage", "Orchestration", "Terraform")
}

module "eks" {
    source                              = "../../modules/eks"
    name                                = "TEST"
    environment                         = "NonProd"

    eks_cluster_name                    = ""
    eks_role_arn                        = module.iam_role.iam_role_arn
    # enebling aws eks logs
    eks_enabled_cluster_log_types       = ["api", "audit"]
    eks_version                         = null
    eks_vpc_config_subnet_ids           = module.vpc.private_subnets_ids
    # SG
    # eks_vpc_config_security_group_ids = []

    tags                                = map("Env", "NonProd", "Orchestration", "Terraform")
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. (`default = ""`)
- `enable_eks_cluster` - Enable creating AWS EKS cluster (`default = ""`)
- `enable_eks_cluster_encryption` - Enable creating AWS EKS cluster with encryption config (`default = ""`)
- `eks_cluster_name` - Custom name of the cluster. (`default = ""`)
- `eks_role_arn` - (Required) The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf. (`default = ""`)
- `eks_enabled_cluster_log_types` - (Optional) A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging (`default = ""`)
- `eks_version` - (Optional) Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS. (`default = ""`)
- `eks_vpc_config_subnet_ids` - (Required) List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane. (`default = ""`)
- `eks_vpc_config_endpoint_private_access` - (Optional) Indicates whether or not the Amazon EKS private API server endpoint is enabled. Default is false. (`default = ""`)
- `eks_vpc_config_endpoint_public_access` - (Optional) Indicates whether or not the Amazon EKS public API server endpoint is enabled. Default is true. (`default = True`)
- `eks_vpc_config_security_group_ids` - (Optional) List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane. (`default = ""`)
- `eks_vpc_config_public_access_cidrs` - (Optional) List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled. EKS defaults this to a list with 0.0.0.0/0. Terraform will only perform drift detection of its value when present in a configuration. (`default = ['0.0.0.0/0']`)
- `encryption_config_provider_key_arn` - (Required) Amazon Resource Name (ARN) of the Key Management Service (KMS) customer master key (CMK). The CMK must be symmetric, created in the same region as the cluster, and if the CMK was created in a different account, the user must have access to the CMK. For more information, see Allowing Users in Other Accounts to Use a CMK in the AWS Key Management Service Developer Guide. (`default = ""`)
- `encryption_config_resources` - (Required) List of strings with resources to be encrypted. Valid values: secrets (`default = ['secrets']`)
- `eks_timeouts_create` - (Default 30 minutes) How long to wait for the EKS Cluster to be created. (`default = 30m`)
- `eks_timeouts_update` - (Default 60 minutes) How long to wait for the EKS Cluster to be updated. Note that the update timeout is used separately for both version and vpc_config update timeouts. (`default = 60m`)
- `eks_timeouts_delete` - (Default 15 minutes) How long to wait for the EKS Cluster to be deleted. (`default = 15m`)
- `enable_eks_fargate_profile` - Enable EKS fargate profile usage (`default = ""`)
- `fargate_profile_name` - Name of the EKS Fargate Profile. (`default = ""`)
- `eks_fargate_profile_cluster_name` - Name of the EKS Cluster. (`default = ""`)
- `eks_fargate_profile_pod_execution_role_arn` - (Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Fargate Profile. (`default = ""`)
- `eks_fargate_profile_subnet_ids` - (Required) Identifiers of private EC2 Subnets to associate with the EKS Fargate Profile. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster). (`default = ""`)
- `eks_fargate_profile_selector_namespace` - (Required) Kubernetes namespace for selection. (`default = ""`)
- `eks_fargate_profile_selector_labels` - (Optional) Key-value mapping of Kubernetes labels for selection. (`default = ""`)
- `eks_fargate_profile_create` - (Default 10 minutes) How long to wait for the EKS Fargate Profile to be created. (`default = 10m`)
- `eks_fargate_profile_delete` - (Default 10 minutes) How long to wait for the EKS Fargate Profile to be deleted. (`default = 10m`)
- `enable_eks_node_group` - Enable EKS node group usage (`default = ""`)
- `eks_node_group_node_group_name` - Name of the EKS Node Group. (`default = ""`)
- `eks_node_group_cluster_name` - Name of the EKS Cluster. (`default = ""`)
- `eks_node_group_node_role_arn` - (Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group. (`default = ""`)
- `eks_node_group_subnet_ids` - (Required) Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster). (`default = ""`)
- `eks_node_group_scaling_config_desired_size` - (Required) Desired number of worker nodes. (`default = 1`)
- `eks_node_group_scaling_config_max_size` - (Required) Maximum number of worker nodes. (`default = 1`)
- `eks_node_group_scaling_config_min_size` - (Required) Minimum number of worker nodes. (`default = 1`)
- `eks_node_group_ami_type` - (Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU. Terraform will only perform drift detection if a configuration value is provided. (`default = AL2_x86_64`)
- `eks_node_group_disk_size` - (Optional) Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided. (`default = 20`)
- `eks_node_group_instance_types` - (Optional) Set of instance types associated with the EKS Node Group. Defaults to ['t3.medium']. Terraform will only perform drift detection if a configuration value is provided. Currently, the EKS API only accepts a single value in the set. (`default = ['t3.medium']`)
- `eks_node_group_labels` - (Optional) Key-value mapping of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed. (`default = ""`)
- `eks_node_group_release_version` - (Optional) AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version. (`default = ""`)
- `eks_node_group_version` - (Optional) Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided. (`default = ""`)
- `eks_node_group_remote_access` - (Optional) Configuration block with remote access settings. (`default = ""`)

## Module Output Variables
----------------------
- `aws_eks_id` - The name of the cluster.
- `aws_eks_arn` - The Amazon Resource Name (ARN) of the cluster.
- `aws_eks_endpoint` - The endpoint for your Kubernetes API server.
- `aws_eks_platform_version` - The platform version for the cluster.
- `aws_eks_status` - TThe status of the EKS cluster. One of CREATING, ACTIVE, DELETING, FAILED.
- `aws_eks_version` - The Kubernetes server version for the cluster.
- `eks_fargate_profile_arn` - Amazon Resource Name (ARN) of the EKS Fargate Profile.
- `eks_fargate_profile_id` - EKS Cluster name and EKS Fargate Profile name separated by a colon (:).
- `eks_fargate_profile_status` - Status of the EKS Fargate Profile.
- `eks_node_group_arn` - Amazon Resource Name (ARN) of the EKS Node Group.
- `eks_node_group_id` - EKS Cluster name and EKS Node Group name separated by a colon (:).
- `eks_node_group_status` - Status of the EKS Node Group.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
