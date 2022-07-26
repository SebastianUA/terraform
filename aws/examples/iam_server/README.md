# Work with IAM_SERVER via terraform

A terraform module for making IAM_SERVER.


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
  region  = "us-east-1"
  profile = "default"
}

module "iam_server" {
  source      = "../../modules/iam_server"
  name        = "TEST-iam-server"
  environment = "stage"

  enable_iam_server_certificate = true
  iam_server_certificate_name   = "my-cert"

  iam_server_certificate_body        = file("additional_files/self-ca-cert.pem")
  iam_server_certificate_private_key = file("additional_files/test-key.pem")

  iam_server_certificate_chain = null
  iam_server_certificate_path  = "/"
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_iam_server_certificate` - Allow upload server certificate (`default = False`)
- `iam_server_certificate_name` - Set custom iam server cert name (`default = ""`)
- `iam_server_certificate_name_prefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with iam_server_certificate_name. (`default = ""`)
- `iam_server_certificate_body` - (Required) The contents of the public key certificate in PEM-encoded format. (`default = ""`)
- `iam_server_certificate_private_key` - (Required) The contents of the private key in PEM-encoded format. (`default = ""`)
- `iam_server_certificate_chain` - (Optional) The contents of the certificate chain. This is typically a concatenation of the PEM-encoded public key certificates of the chain. (`default = null`)
- `iam_server_certificate_path` - (Optional) The IAM path for the server certificate. If it is not included, it defaults to a slash (/). If this certificate is for use with AWS CloudFront, the path must be in format /cloudfront/your_path_here. See IAM Identifiers for more details on IAM Paths. (`default = null`)

## Module Output Variables
----------------------
- `iam_server_certificate_id` - The unique Server Certificate name
- `iam_server_certificate_arn` - The Amazon Resource Name (ARN) specifying the server certificate.
- `iam_server_certificate_name` - The name of the Server Certificate


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
