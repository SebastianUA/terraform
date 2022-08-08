# Work with TIME via terraform

A terraform module for making TIME.


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
```

## Module Input Variables
----------------------
- `enable_offset` - Enable offset usage (`default = False`)
- `offset_offset_years` - (Optional) Number of years to offset the base timestamp. Conflicts with other offset_ arguments. (`default = null`)
- `offset_offset_months` - (Optional) Number of months to offset the base timestamp. Conflicts with other offset_ arguments. (`default = null`)
- `offset_offset_days` - (Optional) Number of days to offset the base timestamp. Conflicts with other offset_ arguments. (`default = null`)
- `offset_offset_hours` - (Optional) Number of hours to offset the base timestamp. Conflicts with other offset_ arguments. (`default = null`)
- `offset_offset_minutes` - (Optional) Number of minutes to offset the base timestamp. Conflicts with other offset_ arguments. (`default = null`)
- `offset_offset_seconds` - (Optional) Number of seconds to offset the base timestamp. Conflicts with other offset_ arguments. (`default = null`)
- `offset_base_rfc3339` - (Optional) Configure the base timestamp with an UTC RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ). Defaults to the current time. (`default = null`)
- `offset_triggers` - (Optional) Arbitrary map of values that, when changed, will trigger a new base timestamp value to be saved. See the main provider documentation for more information. (`default = null`)
- `enable_rotating` - Enable rotating usage (`default = False`)
- `rotating_rotation_years` - (Optional) Number of years to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation. Conflicts with other rotation_ arguments. (`default = null`)
- `rotating_rotation_months` - (Optional) Number of months to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation. Conflicts with other rotation_ arguments. (`default = null`)
- `rotating_rotation_days` - (Optional) Number of days to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation. Conflicts with other rotation_ arguments. (`default = null`)
- `rotating_rotation_hours` - (Optional) Number of hours to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation. Conflicts with other rotation_ arguments. (`default = null`)
- `rotating_rotation_minutes` - (Optional) Number of minutes to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation. Conflicts with other rotation_ arguments. (`default = null`)
- `rotating_rfc3339` - (Optional) Configure the base timestamp with an UTC RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ). Defaults to the current time. (`default = null`)
- `rotating_rotation_rfc3339` - (Optional) Configure the rotation timestamp with an UTC RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ). When the current time has passed the rotation timestamp, the resource will trigger recreation. Conflicts with other rotation_ arguments. (`default = null`)
- `rotating_triggers` - (Optional) Arbitrary map of values that, when changed, will trigger a new base timestamp value to be saved. These conditions recreate the resource in addition to other rotation arguments. See the main provider documentation for more information. (`default = null`)
- `enable_sleep` - Enable sleep usage (`default = False`)
- `sleep_create_duration` - (Optional) Time duration to delay resource creation. For example, 30s for 30 seconds or 5m for 5 minutes. Updating this value by itself will not trigger a delay. (`default = null`)
- `sleep_destroy_duration` - (Optional) Time duration to delay resource destroy. For example, 30s for 30 seconds or 5m for 5 minutes. Updating this value by itself will not trigger a delay. This value or any updates to it must be successfully applied into the Terraform state before destroying this resource to take effect. (`default = null`)
- `sleep_triggers` - (Optional) Arbitrary map of values that, when changed, will run any creation or destroy delays again. See the main provider documentation for more information. (`default = null`)
- `enable_static` - Enable static usage (`default = False`)
- `static_rfc3339` - (Optional) Configure the base timestamp with an UTC RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ). Defaults to the current time. (`default = null`)
- `static_triggers` - (Optional) Arbitrary map of values that, when changed, will trigger a new base timestamp value to be saved. See the main provider documentation for more information. (`default = null`)

## Module Output Variables
----------------------
- `offset_id` - UTC RFC3339 format of the base timestamp, e.g. 2020-02-12T06:36:13Z.
- `offset_day` - Number day of offset timestamp.
- `offset_hour` - Number hour of offset timestamp.
- `offset_minute` - Number minute of offset timestamp.
- `offset_month` - Number month of offset timestamp.
- `offset_second` - Number second of offset timestamp.
- `offset_year` - Number year of offset timestamp.
- `offset_rfc3339` - UTC RFC3339 format of the offset timestamp, e.g. 2020-02-12T06:36:13Z.
- `offset_unix` - Number of seconds since epoch time, e.g. 1581489373.
- `rotating_id` - UTC RFC3339 format of the base timestamp, e.g. 2020-02-12T06:36:13Z.
- `rotating_year` - Number year of timestamp.
- `rotating_month` - Number month of timestamp.
- `rotating_day` - Number day of timestamp.
- `rotating_hour` - Number hour of timestamp.
- `rotating_minute` - Number minute of timestamp.
- `rotating_second` - Number second of timestamp.
- `rotating_unix` - Number of seconds since epoch time, e.g. 1581489373.
- `sleep_id` - UTC RFC3339 timestamp of the creation or import, e.g. 2020-02-12T06:36:13Z
- `static_id` - UTC RFC3339 timestamp format, e.g. 2020-02-12T06:36:13Z.
- `static_year` - Number year of timestamp..
- `static_month` - Number month of timestamp.
- `static_day` - Number day of timestamp..
- `static_hour` - Number hour of timestamp.
- `static_minute` - Number minute of timestamp..
- `static_second` - Number second of timestamp.
- `static_rfc3339` - UTC RFC3339 format of timestamp, e.g. 2020-02-12T06:36:13Z.
- `static_unix` - Number of seconds since epoch time, e.g. 1581489373


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
