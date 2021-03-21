#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "directory_service" {
  source = "../../modules/directory_service"

  # directory service directory
  enable_directory_service_directory   = true
  directory_service_directory_name     = "corp.ad.linux-notes.org"
  directory_service_directory_password = "SuperSecretPassw0rd"
  directory_service_directory_edition  = "Standard"
  directory_service_directory_type     = "MicrosoftAD"

  # directory service log subscription
  enable_directory_service_log_subscription         = false
  directory_service_log_subscription_log_group_name = "cloudwatch_name_here"

  # directory service conditional forwarder
  enable_directory_service_conditional_forwarder             = false
  directory_service_conditional_forwarder_remote_domain_name = "linux-notes.org"
  directory_service_conditional_forwarder_dns_ips = [
    "8.8.8.8",
    "8.8.4.4"
  ]


  tags = map(
    "ENV", "dev",
    "Createdby", "Vitaliy Natarov"
  )
}
