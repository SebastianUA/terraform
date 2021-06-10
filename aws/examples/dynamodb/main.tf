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
