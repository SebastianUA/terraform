#---------------------------------------------------
# Time offset
#---------------------------------------------------
output "offset_id" {
  description = "UTC RFC3339 format of the base timestamp, e.g. 2020-02-12T06:36:13Z."
  value       = element(concat(time_offset.offset.*.id, [""]), 0)
}

output "offset_day" {
  description = "Number day of offset timestamp."
  value       = element(concat(time_offset.offset.*.id, [""]), 0)
}

output "offset_hour" {
  description = "Number hour of offset timestamp."
  value       = element(concat(time_offset.offset.*.hour, [""]), 0)
}

output "offset_minute" {
  description = "Number minute of offset timestamp."
  value       = element(concat(time_offset.offset.*.minute, [""]), 0)
}

output "offset_month" {
  description = "Number month of offset timestamp."
  value       = element(concat(time_offset.offset.*.month, [""]), 0)
}

output "offset_second" {
  description = "Number second of offset timestamp."
  value       = element(concat(time_offset.offset.*.second, [""]), 0)
}

output "offset_year" {
  description = "Number year of offset timestamp."
  value       = element(concat(time_offset.offset.*.year, [""]), 0)
}

output "offset_rfc3339" {
  description = "UTC RFC3339 format of the offset timestamp, e.g. 2020-02-12T06:36:13Z."
  value       = element(concat(time_offset.offset.*.rfc3339, [""]), 0)
}

output "offset_unix" {
  description = "Number of seconds since epoch time, e.g. 1581489373."
  value       = element(concat(time_offset.offset.*.unix, [""]), 0)
}

#---------------------------------------------------
# Time rotating
#---------------------------------------------------
output "rotating_id" {
  description = "UTC RFC3339 format of the base timestamp, e.g. 2020-02-12T06:36:13Z."
  value       = element(concat(time_rotating.rotating.*.id, [""]), 0)
}

output "rotating_year" {
  description = "Number year of timestamp."
  value       = element(concat(time_rotating.rotating.*.year, [""]), 0)
}

output "rotating_month" {
  description = "Number month of timestamp."
  value       = element(concat(time_rotating.rotating.*.month, [""]), 0)
}

output "rotating_day" {
  description = "Number day of timestamp."
  value       = element(concat(time_rotating.rotating.*.day, [""]), 0)
}

output "rotating_hour" {
  description = "Number hour of timestamp."
  value       = element(concat(time_rotating.rotating.*.hour, [""]), 0)
}

output "rotating_minute" {
  description = "Number minute of timestamp."
  value       = element(concat(time_rotating.rotating.*.minute, [""]), 0)
}

output "rotating_second" {
  description = "Number second of timestamp."
  value       = element(concat(time_rotating.rotating.*.second, [""]), 0)
}

output "rotating_unix" {
  description = "Number of seconds since epoch time, e.g. 1581489373."
  value       = element(concat(time_rotating.rotating.*.unix, [""]), 0)
}

#---------------------------------------------------
# Time sleep
#---------------------------------------------------
output "sleep_id" {
  description = "UTC RFC3339 timestamp of the creation or import, e.g. 2020-02-12T06:36:13Z"
  value       = element(concat(time_sleep.sleep.*.id, [""]), 0)
}

#---------------------------------------------------
# Time static
#---------------------------------------------------
output "static_id" {
  description = "UTC RFC3339 timestamp format, e.g. 2020-02-12T06:36:13Z."
  value       = element(concat(time_static.static.*.id, [""]), 0)
}

output "static_year" {
  description = "Number year of timestamp.."
  value       = element(concat(time_static.static.*.year, [""]), 0)
}

output "static_month" {
  description = "Number month of timestamp."
  value       = element(concat(time_static.static.*.month, [""]), 0)
}

output "static_day" {
  description = "Number day of timestamp.."
  value       = element(concat(time_static.static.*.day, [""]), 0)
}

output "static_hour" {
  description = "Number hour of timestamp."
  value       = element(concat(time_static.static.*.hour, [""]), 0)
}

output "static_minute" {
  description = "Number minute of timestamp.."
  value       = element(concat(time_static.static.*.minute, [""]), 0)
}

output "static_second" {
  description = "Number second of timestamp."
  value       = element(concat(time_static.static.*.second, [""]), 0)
}

output "static_rfc3339" {
  description = "UTC RFC3339 format of timestamp, e.g. 2020-02-12T06:36:13Z."
  value       = element(concat(time_static.static.*.rfc3339, [""]), 0)
}

output "static_unix" {
  description = "Number of seconds since epoch time, e.g. 1581489373"
  value       = element(concat(time_static.static.*.unix, [""]), 0)
}