# Work with RAM via terraform

A terraform module for making RAM.


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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Account from resoure will be shared (owner)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "owner"

  alias = "owner"
}


module "ram_owner" {
  source      = "../../modules/ram"
  name        = "tmp"
  environment = "dev"

  providers = {
    aws = aws.owner
  }

  # RAM resource share
  enable_ram_resource_share                    = true
  ram_resource_share_name                      = "test-ram-shared-resource-1"
  ram_resource_share_allow_external_principals = true

  # RAM resource association
  enable_ram_resource_association       = true
  ram_resource_association_resource_arn = "arn:aws:ec2:us-east-1:167127734783:transit-gateway/tgw-095a7bb025f42d2b0"

  # RAM principal association
  enable_ram_principal_association    = true
  ram_principal_association_principal = "XXXXXXXXXXXXXXXXX"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Account to resoure will be shared (main)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "main"
}

module "ram_main_accepter" {
  source      = "../../modules/ram"
  name        = "tmp"
  environment = "dev"

  # RAM resource share accepter
  enable_ram_resource_share_accepter    = true
  ram_resource_share_accepter_share_arn = module.ram_owner.ram_principal_association_id

  depends_on = [
    module.ram_owner
  ]
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - Set region (`default = us-east-1`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_ram_resource_share` - Enable ram resource share usage (`default = False`)
- `ram_resource_share_name` - The name of the resource share. (`default = ""`)
- `ram_resource_share_allow_external_principals` - (Optional) Indicates whether principals outside your organization can be associated with a resource share. (`default = null`)
- `enable_ram_resource_association` - Enable ram resource association usage (`default = False`)
- `ram_resource_association_resource_arn` - (Required) Amazon Resource Name (ARN) of the resource to associate with the RAM Resource Share. (`default = null`)
- `ram_resource_association_resource_share_arn` - Amazon Resource Name (ARN) of the RAM Resource Share. (`default = ""`)
- `enable_ram_principal_association` - Enable ram principal association usage (`default = False`)
- `ram_principal_association_principal` - (Required) The principal to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN. (`default = null`)
- `ram_principal_association_resource_share_arn` - The Amazon Resource Name (ARN) of the resource share. (`default = null`)
- `enable_ram_resource_share_accepter` - Enable ram resource share accepter usage (`default = False`)
- `ram_resource_share_accepter_share_arn` - The ARN of the resource share. (`default = ""`)

## Module Output Variables
----------------------
- `ram_resource_share_id` - The Amazon Resource Name (ARN) of the resource share.
- `ram_resource_share_arn` - The Amazon Resource Name (ARN) of the resource share.
- `ram_resource_association_id` - The Amazon Resource Name (ARN) of the resource share.
- `ram_principal_association_id` - The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma.
- `ram_resource_share_accepter_id` - The ID of RAM resource share accepter
- `ram_resource_share_accepter_invitation_arn` - The ARN of the resource share invitation.
- `ram_resource_share_accepter_share_id` - The ID of the resource share as displayed in the console.
- `ram_resource_share_accepter_status` - The status of the resource share (ACTIVE, PENDING, FAILED, DELETING, DELETED).
- `ram_resource_share_accepter_receiver_account_id` - The account ID of the receiver account which accepts the invitation.
- `ram_resource_share_accepter_sender_account_id` - The account ID of the sender account which submits the invitation.
- `ram_resource_share_accepter_share_name` - The name of the resource share.
- `ram_resource_share_accepter_resources` - A list of the resource ARNs shared via the resource share.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
