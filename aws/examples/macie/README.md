# Work with MACIE via terraform

A terraform module for making MACIE.


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

module "macie" {
  source = "../../modules/macie"

  enable_macie_member_account_association            = true
  macie_member_account_association_member_account_id = "123456789012"

  enable_macie_s3_bucket_association      = true
  macie_s3_bucket_association_bucket_name = "s3-bucket-here"
  macie_s3_bucket_association_prefix      = "data"
  macie_s3_bucket_association_classification_type = [{
    continuous = "FULL"
    one_time   = "NONE"
  }]

}

```

## Module Input Variables
----------------------
- `enable_macie_member_account_association` - Enable macie member account association usage (`default = False`)
- `macie_member_account_association_member_account_id` - (Required) The ID of the AWS account that you want to associate with Amazon Macie as a member account. (`default = null`)
- `enable_macie_s3_bucket_association` - Enable macie s3 bucket association usage (`default = False`)
- `macie_s3_bucket_association_bucket_name` - (Required) The name of the S3 bucket that you want to associate with Amazon Macie. (`default = null`)
- `macie_s3_bucket_association_member_account_id` - (Optional) The ID of the Amazon Macie member account whose S3 resources you want to associate with Macie. If member_account_id isn't specified, the action associates specified S3 resources with Macie for the current master account. (`default = null`)
- `macie_s3_bucket_association_prefix` - (Optional) Object key prefix identifying one or more S3 objects to which the association applies. (`default = null`)
- `macie_s3_bucket_association_classification_type` - (Optional) The configuration of how Amazon Macie classifies the S3 objects. (`default = []`)

## Module Output Variables
----------------------
- `macie_member_account_association_id` - The ID of the association.
- `macie_s3_bucket_association_id` - The ID of the association.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
