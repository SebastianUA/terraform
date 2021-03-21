# Work with AWS S3OUTPOSTS via terraform

A terraform module for making S3OUTPOSTS.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"
}

provider "aws" {
  region                  = "us-west-2"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "s3outposts" {
  source = "../../modules/s3outposts"


  tags = map("Env", "stage", "Orchestration", "Terraform")

}
```

## Module Input Variables
----------------------
