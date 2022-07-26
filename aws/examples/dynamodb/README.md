# Work with DYNAMODB via terraform

A terraform module for making DYNAMODB.


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

module "dynamodb" {
  source      = "../../modules/dynamodb"
  name        = "TEST"
  environment = "stage"

  enable_dynamodb_table           = true
  dynamodb_table_name             = "tf-locker"
  dynamodb_table_hash_key         = "LockID"
  dynamodb_table_billing_mode     = "PROVISIONED"
  dynamodb_table_read_capacity    = 2
  dynamodb_table_write_capacity   = 2
  dynamodb_table_stream_enabled   = true
  dynamodb_table_stream_view_type = "NEW_AND_OLD_IMAGES"
  dynamodb_table_range_key        = "Locker"

  dynamodb_table_ttl = [{
    attribute_name = "TimeToExist"
    enabled        = false
  }]

  dynamodb_table_attribute = [
    {
      name = "LockID"
      type = "S"
    },
    {
      name = "Locker"
      type = "S"
    }
  ]

  #dynamodb_table_local_secondary_index    = [{
  #    name                = "LockIDLocalInder"
  #    range_key           = "Locker"
  #    projection_type     = "ALL"
  #}]

  #dynamodb_table_global_secondary_index   = [{
  #    name               = "LockIDIndex"
  #    hash_key           = "LockID"
  #    range_key          = "Locker"
  #    write_capacity     = 1
  #    read_capacity      = 1
  #    projection_type    = "INCLUDE"
  #    non_key_attributes = ["UserId"]
  #}]

  # DynamoDB table item
  enable_dynamodb_table_item = false
  dynamodb_table_item_item   = <<ITEM
{
  "exampleHashKey": {"S": "LockID"},
  "one": {"N": "11111"},
  "two": {"N": "22222"},
  "three": {"N": "33333"},
  "four": {"N": "44444"},
  "LockID": {"S": "LockID"},
  "Locker": {"S": "Locker"}
}
ITEM

  #  DynamoDB global table
  enable_dynamodb_global_table = true
  dynamodb_global_table_name   = "tf-locker"
  dynamodb_global_table_replica = [
    {
      region_name = "us-east-1"
    }
  ]
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_dynamodb_table` - Enable dynamodb table usage (`default = False`)
- `dynamodb_table_name` - The name of the table, this needs to be unique within a region. (`default = ""`)
- `dynamodb_table_hash_key` - (Required, Forces new resource) The attribute to use as the hash (partition) key. Must also be defined as an attribute (`default = null`)
- `dynamodb_table_attribute` - description (`default = []`)
- `dynamodb_table_billing_mode` - (Optional) Controls how you are charged for read and write throughput and how you manage capacity. The valid values are PROVISIONED and PAY_PER_REQUEST. Defaults to PROVISIONED (`default = PROVISIONED`)
- `dynamodb_table_range_key` - (Optional, Forces new resource) The attribute to use as the range (sort) key. Must also be defined as an attribute (`default = null`)
- `dynamodb_table_write_capacity` -  (Optional) The number of write units for this table. If the billing_mode is PROVISIONED, this field is required. (`default = null`)
- `dynamodb_table_read_capacity` - (Optional) The number of read units for this table. If the billing_mode is PROVISIONED, this field is required. (`default = null`)
- `dynamodb_table_stream_enabled` - (Optional) Indicates whether Streams are to be enabled (true) or disabled (false) (`default = False`)
- `dynamodb_table_stream_view_type` - (Optional) When an item in the table is modified, StreamViewType determines what information is written to the table's stream. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES. (`default = null`)
- `dynamodb_table_ttl` -  (Optional) Defines ttl, has two properties, and can only be specified (`default = []`)
- `dynamodb_table_local_secondary_index` - (Optional, Forces new resource) Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource. (`default = []`)
- `dynamodb_table_global_secondary_index` - (Optional) Describe a GSI for the table; subject to the normal limits on the number of GSIs, projected attributes, etc. (`default = []`)
- `dynamodb_table_server_side_encryption` - (Optional) Encryption at rest options. AWS DynamoDB tables are automatically encrypted at rest with an AWS owned Customer Master Key if this argument isn't specified. (`default = []`)
- `dynamodb_table_point_in_time_recovery` - (Optional) Point-in-time recovery options. (`default = []`)
- `dynamodb_table_timeouts` - The timeouts block allows you to specify timeouts for certain actions. (`default = []`)
- `enable_dynamodb_table_item` - Enable dynamodb table item usage (`default = False`)
- `dynamodb_table_item_table_name` - The name of the table to contain the item. (`default = ""`)
- `dynamodb_table_item_hash_key` - Hash key to use for lookups and identification of the item (`default = ""`)
- `dynamodb_table_item_item` - (Required) JSON representation of a map of attribute name/value pairs, one for each attribute. Only the primary key attributes are required; you can optionally provide other attribute name-value pairs for the item. (`default = null`)
- `dynamodb_table_item_range_key` - (Optional) Range key to use for lookups and identification of the item. Required if there is range key defined in the table. (`default = null`)
- `enable_dynamodb_global_table` - Enable dynamodb global table usage (`default = False`)
- `dynamodb_global_table_name` - The name of the global table. Must match underlying DynamoDB Table names in all regions. (`default = ""`)
- `dynamodb_global_table_replica` - (Required) Underlying DynamoDB Table. At least 1 replica must be defined. (`default = []`)

## Module Output Variables
----------------------
- `dynamodb_table_id` - The name of the table
- `dynamodb_table_arn` - The arn of the table
- `dynamodb_table_stream_arn` - The ARN of the Table Stream. Only available when stream_enabled = true
- `dynamodb_table_stream_label` - A timestamp, in ISO 8601 format, for this stream. Note that this timestamp is not a unique identifier for the stream on its own. However, the combination of AWS customer ID, table name and this field is guaranteed to be unique. It can be used for creating CloudWatch Alarms. Only available when stream_enabled = true
- `aws_dynamodb_table_item_id` - The ID of the table item
- `aws_dynamodb_table_item_table_name` - The name of the table to contain the item.
- `aws_dynamodb_table_item_hash_key` - Hash key to use for lookups and identification of the item
- `aws_dynamodb_table_item_range_key` - Range key to use for lookups and identification of the item. Required if there is range key defined in the table.
- `aws_dynamodb_table_item_item` - JSON representation of a map of attribute name/value pairs, one for each attribute. Only the primary key attributes are required; you can optionally provide other attribute name-value pairs for the item.
- `dynamodb_global_table_id` - The name of the DynamoDB Global Table
- `dynamodb_global_table_arn` - The ARN of the DynamoDB Global Table


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
