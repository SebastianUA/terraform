# Work with AWS Athena via terraform

A terraform module for making AWS Athena.

## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    profile                 = "default"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "s3" {
    source                                  = "../../modules/s3"
    name                                    = "TEST"
    environment                             = "NonPROD"
    region                                  = "us-east-1"

    enable_s3_bucket                        = true
    s3_bucket_name                          = "my-test-bucket"
    s3_bucket_acl                           = "private"
    s3_bucket_cors_rule                     = []

    s3_bucket_versioning                    = []
    enable_lifecycle_rule                   = true

    # Add policy to the bucket
    enable_s3_bucket_policy                 = false

}

data "template_file" "kms_key_policy" {
    template = file("policies/kms_key_policy.json.tpl")
}

module "kms" {
    source              = "../../modules/kms"

    enable_kms_key      = true
    name                = "TESTKMS"
    environment         = "stage"
    key_usage           = "ENCRYPT_DECRYPT"

    policy              = data.template_file.kms_key_policy.rendered

}

module "athena" {
    source                                      = "../../modules/athena"

    enable_athena_database                      = true
    athena_database_name                        = ""
    athena_database_bucket                      = module.s3.s3_bucket_id
    #athena_database_encryption_configuration    = ["encryption_option", "test", "kms_key", "kms_key"]

    enable_athena_workgroup                     = true
    athena_workgroup_name                       = ""
    athena_workgroup_encryption_option          = "SSE_KMS"
    athena_workgroup_kms_key_arn                = module.kms.kms_key_arn
    tags                                        = map("Env", "stage", "Orchestration", "Terraform")

    enable_athena_named_query                   = true
    athena_named_query_name                     = ""
    athena_named_query_query                    = "SELECT * FROM ${module.athena.athena_database_id} limit 10;"

}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch. (`default = ""`)
- `enable_athena_database` - Enable athena DB usage (`default = ""`)
- `athena_database_name` - Name of the database to create. (`default = ""`)
- `athena_database_bucket` - (Required) Name of s3 bucket to save the results of the query execution. (`default = ""`)
- `force_destroy` - (Optional, Default: false) A boolean that indicates all tables should be deleted from the database so that the database can be destroyed without error. The tables are not recoverable. (`default = ""`)
- `enable_athena_named_query` - Enable athena named query usage (`default = ""`)
- `athena_named_query_name` - The plain language name for the query. Maximum length of 128. (`default = ""`)
- `athena_named_query_workgroup` - (Optional) The workgroup to which the query belongs. Defaults to primary (`default = primary`)
- `athena_named_query_database` - The database to which the query belongs. (`default = ""`)
- `athena_named_query_description` - (Optional) A brief explanation of the query. Maximum length of 1024. (`default = ""`)
- `athena_named_query_query` - (Required) The text of the query itself. In other words, all query statements. Maximum length of 262144. (`default = ""`)
- `enable_athena_workgroup` - Enable athena workgroup usage (`default = ""`)
- `athena_workgroup_name` - Name of the workgroup. (`default = ""`)
- `athena_workgroup_description` - (Optional) Description of the workgroup. (`default = ""`)
- `athena_workgroup_state` - (Optional) State of the workgroup. Valid values are DISABLED or ENABLED. Defaults to ENABLED. (`default = ENABLED`)
- `athena_workgroup_bytes_scanned_cutoff_per_query` - (Optional) Integer for the upper data usage limit (cutoff) for the amount of bytes a single query in a workgroup is allowed to scan. Must be at least 10485760. (`default = 10485760`)
- `athena_workgroup_enforce_workgroup_configuration` - (Optional) Boolean whether the settings for the workgroup override client-side settings. For more information, see Workgroup Settings Override Client-Side Settings. Defaults to true. (`default = True`)
- `athena_workgroup_publish_cloudwatch_metrics_enabled` - (Optional) Boolean whether Amazon CloudWatch metrics are enabled for the workgroup. Defaults to true. (`default = True`)
- `athena_workgroup_output_location` - (Optional) The location in Amazon S3 where your query results are stored, such as s3://path/to/query/bucket/. For more information, see Queries and Query Result Files. (`default = ""`)
- `athena_workgroup_encryption_option` - (Required) Indicates whether Amazon S3 server-side encryption with Amazon S3-managed keys (SSE-S3), server-side encryption with KMS-managed keys (SSE-KMS), or client-side encryption with KMS-managed keys (CSE-KMS) is used. If a query runs in a workgroup and the workgroup overrides client-side settings, then the workgroup's setting for encryption is used. It specifies whether query results must be encrypted, for all queries that run in this workgroup. (`default = ""`)
- `athena_workgroup_kms_key_arn` - (Optional) For SSE-KMS and CSE-KMS, this is the KMS key Amazon Resource Name (ARN). (`default = ""`)

## Module Output Variables
----------------------
- `athena_database_id` - The database name
- `athena_named_query_id` - The unique ID of the query.
- `athena_workgroup_id` - The workgroup name
- `athena_workgroup_arn` - Amazon Resource Name (ARN) of the workgroup


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
