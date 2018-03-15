#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "cloudflare" {
    email = ""
    token = ""
}
module "cloudflare_record" {
    source                          = "../../modules/cloudflare_record"
    name                            = "cloudflare_record"
}

