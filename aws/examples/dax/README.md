# Work with DAX via terraform

A terraform module for making DAX.


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

module "dax" {
  source      = "../../modules/dax"
  name        = "TEST"
  environment = "stage"

  # DAX cluster
  enable_dax_cluster             = true
  dax_cluster_name               = "test-dax-cluster"
  dax_cluster_iam_role_arn       = "arn:aws:iam::167127734783:role/admin-role"
  dax_cluster_node_type          = "dax.r4.large"
  dax_cluster_replication_factor = 1

  # DAX parameter group
  enable_dax_parameter_group = true
  dax_parameter_group_name   = "test-dax-param-group"
  dax_parameter_group_parameters = [
    {
      name  = "query-ttl-millis"
      value = 100000
    },
    {
      name  = "record-ttl-millis"
      value = 100000
    }
  ]

  # DAX subnet group
  enable_dax_subnet_group     = false
  dax_subnet_group_name       = "test-dax-subnet-group"
  dax_subnet_group_subnet_ids = []

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
- `enable_dax_cluster` - Enable dax cluster usage (`default = False`)
- `dax_cluster_name` - Group identifier. DAX converts this name to lowercase (`default = ""`)
- `dax_cluster_iam_role_arn` - (Required) A valid Amazon Resource Name (ARN) that identifies an IAM role. At runtime, DAX will assume this role and use the role's permissions to access DynamoDB on your behalf (`default = null`)
- `dax_cluster_node_type` - (Required) The compute and memory capacity of the nodes. See Nodes for supported node types (`default = null`)
- `dax_cluster_replication_factor` - (Required) The number of nodes in the DAX cluster. A replication factor of 1 will create a single-node cluster, without any read replicas (`default = 1`)
- `dax_cluster_availability_zones` - (Optional) List of Availability Zones in which the nodes will be created (`default = null`)
- `dax_cluster_description` - (Optional) Description for the cluster (`default = null`)
- `dax_cluster_notification_topic_arn` - (Optional) An Amazon Resource Name (ARN) of an SNS topic to send DAX notifications to. Example: arn:aws:sns:us-east-1:012345678999:my_sns_topic (`default = null`)
- `dax_cluster_parameter_group_name` - (Optional) Name of the parameter group to associate with this DAX cluster (`default = null`)
- `dax_cluster_maintenance_window` - (Optional) Specifies the weekly time range for when maintenance on the cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00 (`default = null`)
- `dax_cluster_security_group_ids` - (Optional) One or more VPC security groups associated with the cluster (`default = null`)
- `dax_cluster_subnet_group_name` - (Optional) Name of the subnet group to be used for the cluster (`default = null`)
- `dax_cluster_server_side_encryption` - (Optional) Encrypt at rest options (`default = []`)
- `dax_cluster_timeouts` - aws_dax_cluster provides Timeouts and they can be set. (`default = {}`)
- `enable_dax_parameter_group` - Enable dax parameter group usage (`default = False`)
- `dax_parameter_group_name` - The name of the parameter group. (`default = ""`)
- `dax_parameter_group_description` - (Optional, ForceNew) A description of the parameter group. (`default = ""`)
- `dax_parameter_group_parameters` - (Optional) The parameters of the parameter group. (`default = []`)
- `enable_dax_subnet_group` - Enable dax subnet group usage (`default = False`)
- `dax_subnet_group_name` - The name of the subnet group. (`default = ""`)
- `dax_subnet_group_subnet_ids` - (Required) A list of VPC subnet IDs for the subnet group. (`default = []`)
- `dax_subnet_group_description` - (Optional) A description of the subnet group. (`default = null`)

## Module Output Variables
----------------------
- `dax_cluster_id` - The ID of the DAX cluster
- `dax_cluster_arn` - The ARN of the DAX cluster
- `dax_cluster_nodes` - List of node objects including id, address, port and availability_zone. Referenceable e.g. as aws_dax_cluster.test.nodes.0.address
- `dax_cluster_configuration_endpoint` - The configuration endpoint for this DAX cluster, consisting of a DNS name and a port number
- `dax_cluster_cluster_address` - The DNS name of the DAX cluster without the port appended
- `dax_cluster_port` - The port used by the configuration endpoint
- `dax_parameter_group_id` - The name of the parameter group.
- `dax_subnet_group_id` - The name of the subnet group.
- `dax_subnet_group_vpc_id` - VPC ID of the subnet group.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
