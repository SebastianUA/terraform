#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}


module "random" {
  source = "../../modules/random"

  # Generate ramdom UUID
  enable_uuid  = true
  uuid_keepers = {}

  # Generate random string
  enable_string = true
  string_length = 66

  # Generate random shuffle
  enable_shuffle       = true
  shuffle_input        = ["us-east-1", "us-east-2", "us-west-1", "us-west-2"]
  shuffle_result_count = 2

  # Generate random pet
  enable_pet = true
  pet_length = 6

  # Generate random integer
  enable_integer = true
  integer_min    = 1
  integer_max    = 50000

  # Generate random password
  enable_password           = true
  password_length           = 13
  password_special          = true
  password_override_special = "_%@"

  # Generate random id
  enable_id      = true
  id_byte_length = 8

}
