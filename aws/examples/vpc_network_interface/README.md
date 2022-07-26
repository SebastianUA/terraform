# Work with VPC_NETWORK_INTERFACE via terraform

A terraform module for making VPC_NETWORK_INTERFACE.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "vpc_network_interface" {
  source = "../../modules/vpc_network_interface"

  enable_network_interface          = true
  network_interface_name            = ""
  network_interface_subnet_id       = "subnet-0f1fb26a610ee91b0"
  network_interface_private_ips     = ["172.31.80.113"]
  network_interface_security_groups = ["sg-027f744d00f5611fb"]

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
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_network_interface` - Enable VPC network interface usage (`default = False`)
- `network_interface_name` - Set name for VPC network interface (`default = ""`)
- `network_interface_subnet_id` - (Required) Subnet ID to create the ENI in. (`default = ""`)
- `network_interface_description` - (Optional) A description for the network interface. (`default = null`)
- `network_interface_private_ips` - (Optional) List of private IPs to assign to the ENI. (`default = null`)
- `network_interface_private_ips_count` - (Optional) Number of secondary private IPs to assign to the ENI. The total number of private IPs will be 1 + private_ips_count, as a primary private IP will be assiged to an ENI by default. (`default = null`)
- `network_interface_security_groups` - (Optional) List of security group IDs to assign to the ENI. (`default = null`)
- `network_interface_source_dest_check` - (Optional) Whether to enable source destination checking for the ENI. Default true. (`default = True`)
- `network_interface_attachment` - (Optional) Block to define the attachment of the ENI. (`default = []`)
- `enable_network_interface_sg_attachment` - Enable Elastic network interface SG attachment usage (`default = False`)
- `network_interface_sg_attachment_security_group_id` - (Required) The ID of the security group. (`default = ""`)
- `network_interface_sg_attachment_network_interface_id` - (Required) The ID of the network interface to attach to. (`default = ""`)
- `enable_network_interface_attachment` - Enable network interface attachment usage (`default = False`)
- `network_interface_attachment_instance_id` - (Required) Instance ID to attach. (`default = ""`)
- `network_interface_attachment_network_interface_id` - ENI ID to attach. (`default = ""`)
- `network_interface_attachment_device_index` - (Required) Network interface index (int). (`default = 2`)

## Module Output Variables
----------------------
- `network_interface_id` - The ID of the network interface.
- `network_interface_subnet_id` - Subnet ID the ENI is in.
- `network_interface_mac_address` - The MAC address of the network interface.
- `network_interface_private_dns_name` - The private DNS name of the network interface (IPv4).
- `network_interface_description` - A description for the network interface.
- `network_interface_private_ips` - List of private IPs assigned to the ENI.
- `network_interface_security_groups` - List of security groups attached to the ENI.
- `network_interface_attachment` - Block defining the attachment of the ENI.
- `network_interface_source_dest_check` - Whether source destination checking is enabled
- `network_interface_tags` - Tags assigned to the ENI.
- `network_interface_attachment_instance_id` - Instance ID.
- `network_interface_attachment_network_interface_id` - Network interface ID.
- `network_interface_attachment_attachment_id` - The ENI Attachment ID.
- `network_interface_attachment_status` - The status of the Network Interface Attachment.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
