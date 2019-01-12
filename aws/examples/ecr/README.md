# Work with AWS ECR via terraform

A terraform module for ECR.

## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
module "ecr" {
    source                          = "../../modules/ecr"
    name                            = "test"
    region                          = "us-west-2"
    environment                     = "PROD"

    enable_ecr_repository           = true
    # You could use custom name for ECR repo
    #ecr_repository_name             = "test-ecr-repo"


    enable_ecr_repository_policy    = true
    policy_json_file                = "additional_files/policy.json"

    enable_ecr_lifecycle_policy     = true
    lifecycle_policy_json_file      = "additional_files/lifecycle_policy.json"
}
```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default     = "TEST-ASG"`).
- `region` - The region where to deploy this code (e.g. us-east-1) - (`default     = "us-east-1"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `enable_ecr_repository` - Enable ecr repo creating (`default     = false`).
- `ecr_repository_name` - Name of the repository (`default     = ""`).
- `timeouts_delete` - (Default 20 minutes) How long to wait for a repository to be deleted (`default     = "20m"`).
- `enable_ecr_repository_policy` - Enable ecr repo policy usage (`default     = false`).
- `repository` - (Required) Name of the repository to apply the policy (`default     = ""`).
- `policy_json_file` - Json file with policy (`default     = ""`).
- `enable_ecr_lifecycle_policy` - Enable ecr lifecycle policy (`default     = false`).
- `lifecycle_policy_json_file` - Json file with lifecycle policy (`default     = ""`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
