# Work with HEROKU_CERT via terraform

A terraform module for making HEROKU_CERT.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"

  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 3.2.0"
    }
  }
}

provider "heroku" {
  email   = null
  api_key = null

  headers = null

  delays {
    post_app_create_delay    = 5
    post_space_create_delay  = 5
    post_domain_create_delay = 5
  }

  timeouts {
    addon_create_timeout = 20
  }
}

module "heroku_cert" {
  source = "../../modules/heroku_cert"

  enable_cert            = true
  cert_app               = "your-app-here"
  cert_certificate_chain = file("additional_files/server.crt")
  cert_private_key       = file("additional_files/server.key")

}

```

## Module Input Variables
----------------------
- `enable_cert` - Enable Heroku cert usage (`default = False`)
- `cert_app` - (Required) The Heroku app to add to. (`default = null`)
- `cert_certificate_chain` - (Required) The certificate chain to add (`default = null`)
- `cert_private_key` - (Required) The private key for a given certificate chain (`default = null`)

## Module Output Variables
----------------------
- `cert_id` - The ID of the add-on
- `cert_cname` - The CNAME for the SSL endpoint
- `cert_name` - The name of the SSL certificate


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
