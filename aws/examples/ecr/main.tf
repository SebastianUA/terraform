#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

module "ecr" {
    source                          = "../../modules/ecr"
    name                            = "test"
    environment                     = "dev"

    enable_ecr_repository           = true
    # You could use custom name for ECR repo
    ecr_repository_name             = "test-ecr-repo"

    enable_ecr_repository_policy    = true
    policy_json_file                = file("additional_files/policy.json")

    enable_ecr_lifecycle_policy     = true
    lifecycle_policy_json_file      = file("additional_files/lifecycle_policy.json")

    tags                            = map("Env", "stage", "Orchestration", "Terraform")
}
