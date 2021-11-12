#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

module "ecr" {
  source = "../../modules/ecr"

  name        = "test"
  environment = "dev"

  enable_ecr_repository = true
  ecr_repository_name   = "test-ecr-repo"

  enable_ecr_repository_policy = true
  ecr_repository_policy        = file("additional_files/policy.json")

  enable_ecr_lifecycle_policy = true
  ecr_lifecycle_policy        = file("additional_files/lifecycle_policy.json")

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
