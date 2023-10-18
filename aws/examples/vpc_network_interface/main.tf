terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = [pathexpand("~/.aws/credentials")]
}

module "vpc_network_interface" {
  source = "../../modules/vpc_network_interface"

  enable_network_interface          = true
  network_interface_name            = ""
  network_interface_subnet_id       = "subnet-0f1fb26a610ee91b0"
  network_interface_private_ips     = ["172.31.80.113"]
  network_interface_security_groups = ["sg-027f744d00f5611fb"]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}