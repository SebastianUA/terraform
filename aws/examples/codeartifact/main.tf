#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"
}

provider "aws" {
  region                  = "us-west-2"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "codeartifact_domain" {
  source = "../../modules/codeartifact"

  # codeartifact domain
  enable_codeartifact_domain         = true
  codeartifact_domain                = ""
  codeartifact_domain_encryption_key = null

  tags = map("Env", "stage", "Orchestration", "Terraform")

}

module "codeartifact_domain_permissions_policy" {
  source = "../../modules/codeartifact"

  # codeartifact domain
  enable_codeartifact_domain         = true
  codeartifact_domain                = ""
  codeartifact_domain_encryption_key = null

  # AWS CodeArtifact domain permissions policy
  enable_codeartifact_domain_permissions_policy   = true
  codeartifact_domain_permissions_policy_document = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "codeartifact:CreateRepository",
            "Effect": "Allow",
            "Principal": "*",
            "Resource": "${module.codeartifact_domain.codeartifact_domain_arn}"
        }
    ]
}
EOF

  depends_on = [
    module.codeartifact_domain
  ]

}


module "codeartifact_repository" {
  source = "../../modules/codeartifact"

  # codeartifact repository
  enable_codeartifact_repository               = true
  codeartifact_repository                      = "codeartifact-repo"
  codeartifact_repository_description          = "test artifact repo"
  codeartifact_repository_domain               = module.codeartifact_domain.codeartifact_domain_domain
  codeartifact_repository_upstream             = []
  codeartifact_repository_external_connections = []

  # 
  enable_codeartifact_repository_permissions_policy   = true
  codeartifact_repository_permissions_policy_domain   = module.codeartifact_domain.codeartifact_domain_domain
  codeartifact_repository_permissions_policy_document = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "codeartifact:CreateRepository",
            "Effect": "Allow",
            "Principal": "*",
            "Resource": "${module.codeartifact_domain.codeartifact_domain_arn}"
        }
    ]
}
EOF

  tags = map("Env", "stage", "Orchestration", "Terraform")

  depends_on = [
    module.codeartifact_domain
  ]
}