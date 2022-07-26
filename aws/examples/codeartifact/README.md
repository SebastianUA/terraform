# Work with CODEARTIFACT via terraform

A terraform module for making CODEARTIFACT.


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

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

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

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.codeartifact_domain
  ]
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_codeartifact_domain` - Enable codeartifact domain usage (`default = False`)
- `codeartifact_domain` - The name of the domain to create. All domain names in an AWS Region that are in the same AWS account must be unique. The domain name is used as the prefix in DNS hostnames. Do not use sensitive information in a domain name because it is publicly discoverable. (`default = ""`)
- `codeartifact_domain_encryption_key` - (Optional) The encryption key for the domain. This is used to encrypt content stored in a domain. The KMS Key Amazon Resource Name (ARN). The default aws/codeartifact AWS KMS master key is used if this element is absent. (`default = null`)
- `enable_codeartifact_domain_permissions_policy` - Enable codeartifact domain permissions policy usage (`default = False`)
- `codeartifact_domain_permissions_policy_domain` - The name of the domain on which to set the resource policy. (`default = ""`)
- `codeartifact_domain_permissions_policy_document` - (Required) A JSON policy string to be set as the access control resource policy on the provided domain. (`default = null`)
- `codeartifact_domain_permissions_policy_domain_owner` - (Optional) The account number of the AWS account that owns the domain. (`default = null`)
- `codeartifact_domain_permissions_policy_revision` - (Optional) The current revision of the resource policy to be set. This revision is used for optimistic locking, which prevents others from overwriting your changes to the domain's resource policy. (`default = null`)
- `enable_codeartifact_repository` - Enable codeartifact repository usage (`default = False`)
- `codeartifact_repository` - The name of the repository to create. (`default = ""`)
- `codeartifact_repository_domain` - The domain that contains the created repository. (`default = ""`)
- `codeartifact_repository_description` - (Optional) The description of the repository. (`default = null`)
- `codeartifact_repository_domain_owner` - (Optional) The account number of the AWS account that owns the domain. (`default = null`)
- `codeartifact_repository_upstream` - (Optional) A list of upstream repositories to associate with the repository. The order of the upstream repositories in the list determines their priority order when AWS CodeArtifact looks for a requested package version. see Upstream (`default = []`)
- `codeartifact_repository_external_connections` - An array of external connections associated with the repository. Only one external connection can be set per repository. see External Connections. (`default = []`)
- `enable_codeartifact_repository_permissions_policy` - Enable codeartifact repository permissions policy usage (`default = False`)
- `codeartifact_repository_permissions_policy_repository` - The name of the repository to set the resource policy on. (`default = ""`)
- `codeartifact_repository_permissions_policy_domain` - The name of the domain on which to set the resource policy. (`default = codeartifact_repository_permissions_policy_repository`)
- `codeartifact_repository_permissions_policy_document` - (Required) A JSON policy string to be set as the access control resource policy on the provided domain. (`default = null`)
- `codeartifact_repository_permissions_policy_domain_owner` - (Optional) The account number of the AWS account that owns the domain. (`default = null`)
- `codeartifact_repository_permissions_policy_policy_revision` - (Optional) The current revision of the resource policy to be set. This revision is used for optimistic locking, which prevents others from overwriting your changes to the domain's resource policy. (`default = null`)

## Module Output Variables
----------------------
- `codeartifact_domain_id` - The Name of Domain.
- `codeartifact_domain_arn` - The ARN of Domain.
- `codeartifact_domain_domain` - The ARN of Domain.
- `codeartifact_domain_owner` - The AWS account ID that owns the domain.
- `codeartifact_domain_created_time` - A timestamp that represents the date and time the domain was created in RFC3339 format.
- `codeartifact_domain_repository_count` - The number of repositories in the domain.
- `codeartifact_domain_asset_size_bytes` - The total size of all assets in the domain.
- `codeartifact_domain_permissions_policy_id` - The Name of Domain.
- `_resource_arn` - The ARN of the resource associated with the resource policy.
- `codeartifact_repository_id` - The Name of the repository.
- `codeartifact_repository_arn` - The ARN of the repository.
- `codeartifact_repository_administrator_account` - The account number of the AWS account that manages the repository.
- `codeartifact_repository_permissions_policy_id` - The ARN of the resource associated with the resource policy.
- `codeartifact_repository_permissions_resource_policy_arn` - The ARN of the resource associated with the resource policy.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
