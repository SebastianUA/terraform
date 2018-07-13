output "google_dns_managed_zone_name" {
    description = "Name of google dns managed zone"
    value       = "${module.google_dns.google_dns_managed_zone_name}"
}

output "google_dns_managed_zone_name_servers" {
    description = "The list of nameservers that will be authoritative for this domain. Use NS records to redirect from your DNS provider to these names, thus making Google Cloud DNS authoritative for this zone."
    value       = "${module.google_dns.google_dns_managed_zone_name_servers}"
}

output "google_dns_managed_zone_id" {
    description = "ID"
    value       = "${module.google_dns.google_dns_managed_zone_id}"
}

output "google_dns_record_set_name" {
    description = "Name"
    value       = "${module.google_dns.google_dns_record_set_name}"
}

output "google_dns_record_set_id" {
    description = "ID"
    value       = "${module.google_dns.google_dns_record_set_id}"
}

