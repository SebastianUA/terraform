# Work with AWS BACKUP via terraform

A terraform module for making BACKUP.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13.5"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "backup" {
  source      = "../../modules/backup"
  name        = "TEST"
  environment = "stage"

  # AWS Backup vault
  enable_backup_vault      = true
  backup_vault_name        = ""
  backup_vault_kms_key_arn = null

  # AWS Backup plan
  enable_backup_plan = true
  backup_plan_name   = ""
  backup_plan_rule = [{
    rule_name = "rule-name-1"
    schedule  = "cron(0 12 * * ? *)"
  }]

  # AWS backup selection
  enable_backup_selection       = true
  backup_selection_name         = ""
  backup_selection_iam_role_arn = "arn:aws:iam::167127734783:role/admin-role"
  backup_selection_resources    = []

  tags = map("Env", "dev", "Orchestration", "Terraform", "Createdby", "Vitalii Natarov")
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = ""`)
- `enable_backup_vault` - Enable backup vault usage (`default = ""`)
- `backup_vault_name` - Name of the backup vault to create. (`default = ""`)
- `backup_vault_kms_key_arn` - (Optional) The server-side encryption key that is used to protect your backups. (`default = null`)
- `enable_backup_plan` - Enable backup plan usage (`default = ""`)
- `backup_plan_name` - The display name of a backup plan. (`default = ""`)
- `backup_plan_rule` - (Required) A rule object that specifies a scheduled task that is used to back up a selection of resources. (`default = ""`)
- `backup_plan_rule_copy_action` - (Required) A rule object that specifies a scheduled task that is used to back up a selection of resources with copy_action usage. (`default = ""`)
- `enable_backup_selection` - Enable backup selection usage (`default = ""`)
- `backup_selection_name` - The display name of a resource selection document. (`default = ""`)
- `backup_selection_iam_role_arn` - The ARN of the IAM role that AWS Backup uses to authenticate when restoring and backing up the target resource. See the AWS Backup Developer Guide for additional information about using AWS managed policies or creating custom policies attached to the IAM role. (`default = null`)
- `backup_selection_plan_id` - The backup plan ID to be associated with the selection of resources. (`default = ""`)
- `backup_selection_resources` - (Optional) An array of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan.. (`default = null`)
- `backup_selection_selection_tag` - (Optional) Tag-based conditions used to specify a set of resources to assign to a backup plan. (`default = ""`)

## Module Output Variables
----------------------


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
