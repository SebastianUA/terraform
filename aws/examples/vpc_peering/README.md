# Work with AWS VPC_PEERING via terraform

A terraform module for making VPC_PEERING.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#---------------------------------------------------------------
# 1rst VPC for peering
#---------------------------------------------------------------
module "vpc_1" {
  source      = "../../modules/vpc_peering"
  name        = "test"
  environment = "stage"


  # VPC peering
  enable_vpc_peering_connection_accepter      = true
  vpc_peering_connection_accepter_auto_accept = true
  vpc_peering_connection_vpc_id               = "vpc_id_1"


  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

#---------------------------------------------------------------
# 2d VPC for peering with VPC flow log & VPC network ACLs
#---------------------------------------------------------------
module "vpc_2" {
  source      = "../../modules/vpc_peering"
  name        = "test2"
  environment = "stage"

  # VPC peering
  enable_vpc_peering_connection      = true
  vpc_peering_connection_vpc_id      = "vpc_id_2"
  vpc_peering_connection_peer_vpc_id = "vpc_id_1" #module.vpc_1.vpc_id


  vpc_peering_connection_accepter = [
    {
      allow_remote_vpc_dns_resolution  = true
      allow_classic_link_to_remote_vpc = true
      allow_vpc_to_remote_classic_link = true
    }
  ]

  vpc_peering_connection_requester = [
    {
      allow_remote_vpc_dns_resolution  = true
      allow_classic_link_to_remote_vpc = true
      allow_vpc_to_remote_classic_link = true
    }
  ]

  vpc_peering_connection_auto_accept = true

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.vpc_1
  ]
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_vpc_peering_connection` - Enable VPC peering usage (`default = False`)
- `vpc_peering_connection_name` - Set name for VPC peering connection (`default = ""`)
- `vpc_peering_connection_vpc_id` - Set vpc_id for peering connection (`default = ""`)
- `vpc_peering_connection_peer_vpc_id` - (Required) The ID of the VPC with which you are creating the VPC Peering Connection. (`default = null`)
- `vpc_peering_connection_peer_owner_id` - (Optional) The AWS account ID of the owner of the peer VPC. Defaults to the account ID the AWS provider is currently connected to. (`default = null`)
- `vpc_peering_connection_auto_accept` - (Optional) Accept the peering (both VPCs need to be in the same AWS account). (`default = null`)
- `vpc_peering_connection_peer_region` - (Optional) The region of the accepter VPC of the [VPC Peering Connection]. auto_accept must be false, and use the aws_vpc_peering_connection_accepter to manage the accepter side. (`default = null`)
- `vpc_peering_connection_accepter` - (Optional) - An optional configuration block that allows for [VPC Peering Connection] (https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that accepts the peering connection (a maximum of one). (`default = []`)
- `vpc_peering_connection_requester` - (Optional) - A optional configuration block that allows for [VPC Peering Connection] (https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that requests the peering connection (a maximum of one). (`default = []`)
- `vpc_peering_connection_timeouts` - Set timeouts used for creating a peering connection (`default = []`)
- `enable_vpc_peering_connection_options` - Enable VPC peering connection options usage (`default = False`)
- `vpc_peering_connection_options_vpc_peering_connection_id` - The ID of the requester VPC peering connection. (`default = ""`)
- `vpc_peering_connection_options_accepter` - (Optional) - An optional configuration block that allows for [VPC Peering Connection] (https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that accepts the peering connection (a maximum of one). (`default = []`)
- `vpc_peering_connection_options_requester` - (Optional) - A optional configuration block that allows for [VPC Peering Connection] (https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that requests the peering connection (a maximum of one). (`default = []`)
- `enable_vpc_peering_connection_accepter` - Enable VPC endpoint usage (`default = False`)
- `vpc_peering_connection_accepter_name` - Set name for VPC peering connection accepter (`default = ""`)
- `vpc_peering_connection_accepter_vpc_peering_connection_id` - (Optional) Whether or not to accept the peering request. Defaults to false. (`default = False`)
- `vpc_peering_connection_accepter_auto_accept` - (Optional) Whether or not to accept the peering request. Defaults to false. (`default = False`)

## Module Output Variables
----------------------
- `vpc_peering_connection_id` - The ID of the VPC Peering Connection.
- `vpc_peering_connection_accept_status` - The status of the VPC Peering Connection request.
- `vpc_peering_connection_options_id` - The ID of the VPC Peering Connection Options.
- `vpc_peering_connection_accepter_id` - The ID of the VPC Peering Connection.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
