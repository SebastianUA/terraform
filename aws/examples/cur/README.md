# Work with CUR via terraform

A terraform module for making CUR.


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
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "cur" {
  source      = "../../modules/cur"
  name        = "TEST"
  environment = "dev"

  enable_cur_report_definition                     = true
  cur_report_definition_report_name                = ""
  cur_report_definition_time_unit                  = "HOURLY"
  cur_report_definition_format                     = "textORcsv"
  cur_report_definition_compression                = "GZIP"
  cur_report_definition_additional_schema_elements = ["RESOURCES"]
  cur_report_definition_additional_artifacts       = ["REDSHIFT", "QUICKSIGHT"]

  cur_report_definition_s3_bucket = "my-test-bucket"
  cur_report_definition_s3_region = "us-east-1"
  cur_report_definition_s3_prefix = null
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_cur_report_definition` - Enable cur report definition usage (`default = False`)
- `cur_report_definition_report_name` - (Required) Unique name for the report. Must start with a number/letter and is case sensitive. Limited to 256 characters. (`default = ""`)
- `cur_report_definition_time_unit` - (Required) The frequency on which report data are measured and displayed. Valid values are: HOURLY, DAILY. (`default = HOURLY`)
- `cur_report_definition_format` - (Required) Format for report. Valid values are: textORcsv. (`default = textORcsv`)
- `cur_report_definition_compression` - (Required) Compression format for report. Valid values are: GZIP, ZIP. (`default = GZIP`)
- `cur_report_definition_additional_schema_elements` - (Required) A list of schema elements. Valid values are: RESOURCES. (`default = ['RESOURCES']`)
- `cur_report_definition_additional_artifacts` - (Required) A list of additional artifacts. Valid values are: REDSHIFT, QUICKSIGHT. (`default = ['REDSHIFT', 'QUICKSIGHT']`)
- `cur_report_definition_s3_bucket` - (Required) Name of the existing S3 bucket to hold generated reports. (`default = null`)
- `cur_report_definition_s3_region` - (Required) Region of the existing S3 bucket to hold generated reports. (`default = null`)
- `cur_report_definition_s3_prefix` - (Optional) Report path prefix. Limited to 256 characters. (`default = null`)

## Module Output Variables
----------------------
- `cur_report_definition_id` - The ID of the cur report definition


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
