#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}


module "time_offset" {
  source = "../../modules/time"

  # Time offset
  enable_offset      = true
  offset_offset_days = 7

  offset_triggers = null
}

module "time_rotating" {
  source = "../../modules/time"

  # Time rotating
  enable_rotating        = true
  rotating_rotation_days = 7

  rotating_triggers = null
}

module "time_sleep" {
  source = "../../modules/time"

  # Time sleep
  enable_sleep           = true
  sleep_create_duration  = "30s"
  sleep_destroy_duration = "30s"

  sleep_triggers = {}
}

module "time_static" {
  source = "../../modules/time"

  # Time static
  enable_static   = true
  static_rfc3339  = null
  static_triggers = null
}