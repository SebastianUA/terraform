# Work with AWS ACM via terraform

A terraform module for making Amazon Certificate Manager.

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~>0.12.2"
}

provider "aws" {
    region                  = "us-east-1"
    profile                 = "default"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
}

module "acm_certificate" {
    source                      = "../../modules/acm"
                        
    acm_certificate             = "true"

    domain_name                 = "linux-notes.org"
    subject_alternative_names   = ["www.linux-notes.org", "linux-notes.org"]
    validation_method           = "EMAIL"

    import_existing_certificate = "false"
    #private_key                 = ""
    #certificate_body            = ""
    #certificate_chain           = ""
}

module "acm_certificate_validation" {
    source                      = "../../modules/acm"
    
    acm_certificate_validation  = "true"
    certificate_arn             = "${module.acm_certificate.aws_acm_certificate_arn}"
    validation_record_fqdns     = []
}

```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix  (`default     = "TEST-ACM`)
- `region` - The region where to deploy this code (e.g. us-east-1)-  (`default     = "us-east-1`)
- `environment` - Environment for service (`  default     = "STAGE`)
- `orchestration` - Type of orchestration  (`  default     = "Terraform`)
- `createdby` -  Created by  (`  default     = "Vitaliy Natarov`)
- `acm_certificate` - Enable acm certificate usage  (`  default     = "false`)
- `domain_name` - (Required) A domain name for which the certificate should be issued  (`  default     = "`)
- `validation_method` - (Required) Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform (`  default     = "DNS`)
- `subject_alternative_names` - (Optional) A list of domains that should be SANs in the issued certificate (`  default     = []`)
- `import_existing_certificate` - Enable to import existing certificate (`  default     = "false`)
- `private_key` - (Required) The certificate's PEM-formatted private key (`  default     = "`)
- `certificate_body` - (Required) The certificate's PEM-formatted public key (`  default     = "`)
- `certificate_chain` - (Optional) The certificate's PEM-formatted chain (`  default     = "`)
- `acm_certificate_validation` - Enable to use acm certificate validation  (`  default     = "false`)
- `certificate_arn` - (Required) The ARN of the certificate that is being validated.  (`  default     = "`)
- `validation_record_fqdns` - (Optional) List of FQDNs that implement the validation. Only valid for DNS validation method ACM certificates. If this is set, the resource can implement additional sanity checks and has an explicit dependency on the resource that is implementing the validation (`  default     = []`)
- `timeouts_create` - (Default 45m) How long to wait for a certificate to be issued.  (`  default     = "45m`)

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
