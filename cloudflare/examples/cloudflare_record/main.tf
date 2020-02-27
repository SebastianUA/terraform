#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.12.12"
}
provider "cloudflare" {
    version = "~> 2.0"
    email   = ""
    api_key = ""
}
module "cloudflare_record" {
    source                          = "../../modules/cloudflare_record"
    name                            = "cloudflare_record"

    enable_cloudflare_record        = "true"

    value                           = "192.168.0.11"

    data                            = {
        service  = "_sip"
        proto    = "_tls"
        name     = "terraform-srv"
        priority = 0
        weight   = 0
        port     = 443
        target   = "linux-notes.org"
  }
}
