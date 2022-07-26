# Work with WORKLINK via terraform

A terraform module for making WORKLINK.


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

module "worklink" {
  source      = "../../modules/worklink"
  name        = "TEST"
  environment = "stage"

  # worklink fleet
  enable_worklink_fleet            = true
  worklink_fleet_name              = ""
  worklink_fleet_network           = []
  worklink_fleet_identity_provider = []

  # worklink
  enable_worklink_website_certificate_authority_association       = true
  worklink_website_certificate_authority_association_fleet_arn    = ""
  worklink_website_certificate_authority_association_certificate  = file("additional_files/certificate.pem")
  worklink_website_certificate_authority_association_display_name = null
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_worklink_fleet` - Enable worklink fleet usage (`default = False`)
- `worklink_fleet_name` - A region-unique name for the AMI. (`default = ""`)
- `worklink_fleet_audit_stream_arn` - (Optional) The ARN of the Amazon Kinesis data stream that receives the audit events. (`default = null`)
- `worklink_fleet_device_ca_certificate` - (Optional) The certificate chain, including intermediate certificates and the root certificate authority certificate used to issue device certificates. (`default = null`)
- `worklink_fleet_display_name` - (Optional) The name of the fleet. (`default = null`)
- `worklink_fleet_optimize_for_end_user_location` - (Optional) The option to optimize for better performance by routing traffic through the closest AWS Region to users, which may be outside of your home Region. Defaults to true. (`default = null`)
- `worklink_fleet_network` - (Optional) Provide this to allow manage the company network configuration for the fleet. (`default = []`)
- `worklink_fleet_identity_provider` - (Optional) Provide this to allow manage the identity provider configuration for the fleet. (`default = []`)
- `enable_worklink_website_certificate_authority_association` - Enable worklink website certificate authority association usage (`default = False`)
- `worklink_website_certificate_authority_association_fleet_arn` - The ARN of the fleet. (`default = ""`)
- `worklink_website_certificate_authority_association_certificate` - (Required, ForceNew) The root certificate of the Certificate Authority. (`default = null`)
- `worklink_website_certificate_authority_association_display_name` - (Optional, ForceNew) The certificate name to display. (`default = null`)

## Module Output Variables
----------------------
- `worklink_fleet_id` - The ARN of the created WorkLink Fleet.
- `worklink_fleet_arn` - The ARN of the created WorkLink Fleet.
- `worklink_fleet_company_code` - The identifier used by users to sign in to the Amazon WorkLink app.
- `worklink_fleet_created_time` - The time that the fleet was created.
- `worklink_fleet_last_updated_time` - The time that the fleet was last updated.
- `worklink_website_certificate_authority_association_id` - The ID of worklink website certificate authority association
- `worklink_website_certificate_authority_association_website_ca_id` - A unique identifier for the Certificate Authority.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
