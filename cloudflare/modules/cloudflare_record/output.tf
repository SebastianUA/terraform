output "record_ids" {
    description = ""
    value       = "${cloudflare_record.record.*.id}"
}

output "record_names" {
    description = ""
    value       = "${cloudflare_record.record.*.name}"
}

output "record_values" {
    description = ""
    value       = "${cloudflare_record.record.*.value}"
}

output "record_types" {
    description = ""
    value       = "${cloudflare_record.record.*.type}"
}

output "record_ttls" {
    description = ""
    value       = "${cloudflare_record.record.*.ttl}"
}

output "record_prioritys" {
    description = ""
    value       = "${cloudflare_record.record.*.priority}"
}

output "record_hostnames" { 
    description = ""
    value       = "${cloudflare_record.record.*.hostname}"
}

output "record_proxieds" {
    description = ""
    value       = "${cloudflare_record.record.*.proxied}"
}
