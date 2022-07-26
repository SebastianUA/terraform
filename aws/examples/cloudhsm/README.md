# Work with CLOUDHSM via terraform

A terraform module for making CLOUDHSM.


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
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "cloudhsm" {
  source = "../../modules/cloudhsm"

  name        = "test"
  environment = "stage"

  enable_cloudhsm_v2_cluster     = true
  cloudhsm_v2_cluster_subnet_ids = ["subnet-8851dea6", "subnet-c3a5f589", "subnet-1d7df041"]
  cloudhsm_v2_cluster_name       = ""
  tags                           = map("Env", "stage", "Orchestration", "Terraform")

  enable_cloudhsm_v2_hsm    = true
  cloudhsm_v2_hsm_subnet_id = "subnet-8851dea6"
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - Add additional tags (`default = {}`)
- `enable_cloudhsm_v2_cluster` - Enable cloudhsm v2 cluster usage (`default = False`)
- `cloudhsm_v2_cluster_hsm_type` - (Required) The type of HSM module in the cluster. Currently, only hsm1.medium is supported. (`default = hsm1.medium`)
- `cloudhsm_v2_cluster_subnet_ids` - (Required) The IDs of subnets in which cluster will operate. (`default = []`)
- `cloudhsm_v2_cluster_source_backup_identifier` - (Optional) The id of Cloud HSM v2 cluster backup to be restored. (`default = null`)
- `cloudhsm_v2_cluster_name` - Name for cloudhsm v2 cluster (`default = ""`)
- `enable_cloudhsm_v2_hsm` - Enable cloudhsm v2 hsm usage (`default = False`)
- `cloudhsm_v2_hsm_subnet_id` - (Optional) The ID of subnet in which HSM module will be located. (`default = null`)
- `cloudhsm_v2_hsm_cluster_id` - (Required) The ID of Cloud HSM v2 cluster to which HSM will be added. (`default = ""`)
- `cloudhsm_v2_hsm_availability_zone` - (Optional) The IDs of AZ in which HSM module will be located. Do not use together with subnet_id. (`default = null`)
- `cloudhsm_v2_hsm_ip_address` - (Optional) The IP address of HSM module. Must be within the CIDR of selected subnet. (`default = null`)

## Module Output Variables
----------------------
- `cloudhsm_v2_cluster_id` - The id of the CloudHSM cluster.
- `cloudhsm_v2_cluster_state` - The state of the cluster.
- `cloudhsm_v2_cluster_vpc_id` - The id of the VPC that the CloudHSM cluster resides in.
- `cloudhsm_v2_cluster_security_group_id` - The ID of the security group associated with the CloudHSM cluster.
- `cloudhsm_v2_hsm_id` - The id of the HSM module.
- `cloudhsm_v2_hsm_state` - The state of the HSM module.
- `cloudhsm_v2_hsm_eni_id` - The id of the ENI interface allocated for HSM module.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
