#---------------------------------------------------
# Add a record to the domain
#---------------------------------------------------
output "record_id" {
  description = ""
  value       = element(concat(cloudflare_record.record.*.id, [""]), 0)
}

output "record_name" {
  description = ""
  value       = element(concat(cloudflare_record.record.*.name, [""]), 0)
}

output "record_value" {
  description = ""
  value       = element(concat(cloudflare_record.record.*.value, [""]), 0)
}

output "record_type" {
  description = ""
  value       = element(concat(cloudflare_record.record.*.type, [""]), 0)
}

output "record_ttls" {
  description = ""
  value       = element(concat(cloudflare_record.record.*.ttl, [""]), 0)
}

output "record_prioritys" {
  description = ""
  value       = element(concat(cloudflare_record.record.*.priority, [""]), 0)
}

output "record_hostnames" {
  description = ""
  value       = element(concat(cloudflare_record.record.*.hostname, [""]), 0)
}

output "record_proxieds" {
  description = ""
  value       = element(concat(cloudflare_record.record.*.proxied, [""]), 0)
}
