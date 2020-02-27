# Work with AWS IAM for server using via terraform
=======================

A terraform module for making IAM server.

## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.12.12"
}

provider "aws" {
    region  = "us-east-1"
    profile = "default"
}

module "iam_server" {
    source                                      = "../../modules/iam_server"
    name                                        = "TEST"
    environment                                 = "PROD"

    enable_iam_server_certificate               = true
    iam_server_certificate_name                 = "my-cert"

    iam_server_certificate_body                 = file("additional_files/self-ca-cert.pem")
    iam_server_certificate_private_key          = file("additional_files/test-key.pem")

    iam_server_certificate_chain                = null
    iam_server_certificate_path                 = "/"
}
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `enable_iam_server_certificate` - Allow upload server certificate (`default     = false`).
- `iam_server_certificate_name` - Set custom iam server cert name (`default     = ""`).
- `iam_server_certificate_name_prefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with iam_server_certificate_name. (`default     = ""`).
- `iam_server_certificate_body` - (Required) The contents of the public key certificate in PEM-encoded format. (`default     = ""`).
- `iam_server_certificate_private_key` - (Required) The contents of the private key in PEM-encoded format. (`default     = ""`).
- `iam_server_certificate_chain` - (Optional) The contents of the certificate chain. This is typically a concatenation of the PEM-encoded public key certificates of the chain (`default     = null`).
- `iam_server_certificate_path` - (Optional) The IAM path for the server certificate. If it is not included, it defaults to a slash (/). If this certificate is for use with AWS CloudFront, the path must be in format /cloudfront/your_path_here. See IAM Identifiers for more details on IAM Paths (`default     = null`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
