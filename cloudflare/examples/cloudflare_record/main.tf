#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}

provider "cloudflare" {
  email   = "email-here"
  api_key = "api-key-here"
}

module "cloudflare_record" {
  source = "../../modules/cloudflare_record"
  #name                            = "cloudflare_record"

  enable_record = true

  #record_value                    = "192.168.0.11"

  record_data = {
    service  = "_sip"
    proto    = "_tls"
    name     = "terraform-srv"
    priority = 0
    weight   = 0
    port     = 443
    target   = "linux-notes.org"
  }
}
