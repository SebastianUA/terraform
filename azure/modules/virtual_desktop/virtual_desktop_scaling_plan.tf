#-----------------------------------------------------------
# Azure virtual desktop scaling plan
#-----------------------------------------------------------
resource "azurerm_virtual_desktop_scaling_plan" "virtual_desktop_scaling_plan" {
  count = var.enable_virtual_desktop_scaling_plan ? 1 : 0

  name                = var.virtual_desktop_scaling_plan_name != "" ? var.virtual_desktop_scaling_plan_name : "${lower(var.name)}-virtual-desktop-scaling-plan-${lower(var.environment)}"
  location            = var.virtual_desktop_scaling_plan_location
  resource_group_name = var.virtual_desktop_scaling_plan_resource_group_name
  time_zone           = var.virtual_desktop_scaling_plan_time_zone

  dynamic "schedule" {
    iterator = schedule
    for_each = var.virtual_desktop_scaling_plan_schedule

    content {
      name                                 = lookup(schedule.value, "name", null)
      days_of_week                         = lookup(schedule.value, "days_of_week", null)
      ramp_up_start_time                   = lookup(schedule.value, "ramp_up_start_time", null)
      ramp_up_load_balancing_algorithm     = lookup(schedule.value, "ramp_up_load_balancing_algorithm", null)
      peak_start_time                      = lookup(schedule.value, "peak_start_time", null)
      peak_load_balancing_algorithm        = lookup(schedule.value, "peak_load_balancing_algorithm", null)
      ramp_down_start_time                 = lookup(schedule.value, "ramp_down_start_time", null)
      ramp_down_load_balancing_algorithm   = lookup(schedule.value, "ramp_down_load_balancing_algorithm", null)
      ramp_down_minimum_hosts_percent      = lookup(schedule.value, "ramp_down_minimum_hosts_percent", null)
      ramp_down_force_logoff_users         = lookup(schedule.value, "ramp_down_force_logoff_users", null)
      ramp_down_wait_time_minutes          = lookup(schedule.value, "ramp_down_wait_time_minutes", null)
      ramp_down_notification_message       = lookup(schedule.value, "ramp_down_notification_message", null)
      ramp_down_capacity_threshold_percent = lookup(schedule.value, "ramp_down_capacity_threshold_percent", null)
      ramp_down_stop_hosts_when            = lookup(schedule.value, "ramp_down_stop_hosts_when", null)
      off_peak_start_time                  = lookup(schedule.value, "off_peak_start_time", null)
      off_peak_load_balancing_algorithm    = lookup(schedule.value, "off_peak_load_balancing_algorithm", null)

      ramp_up_capacity_threshold_percent = lookup(schedule.value, "ramp_up_capacity_threshold_percent", null)
      ramp_up_minimum_hosts_percent      = lookup(schedule.value, "ramp_up_minimum_hosts_percent", null)
    }
  }

  description   = var.virtual_desktop_scaling_plan_description
  exclusion_tag = var.virtual_desktop_scaling_plan_exclusion_tag
  friendly_name = var.virtual_desktop_scaling_plan_friendly_name

  dynamic "host_pool" {
    iterator = host_pool
    for_each = var.virtual_desktop_scaling_plan_host_pool

    content {
      hostpool_id          = lookup(host_pool.value, "hostpool_id", null)
      scaling_plan_enabled = lookup(host_pool.value, "scaling_plan_enabled", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.virtual_desktop_workspace_timeouts)) > 0 ? [var.virtual_desktop_workspace_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.virtual_desktop_scaling_plan_name != "" ? var.virtual_desktop_scaling_plan_name : "${lower(var.name)}-virtual-desktop-scaling-plan-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
