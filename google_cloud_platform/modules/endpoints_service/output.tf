#-----------------------------------------------------------------------
# Openapi
#-----------------------------------------------------------------------
output "google_endpoints_service_openapi_id" {
    description = "ID"
    value       = "${google_endpoints_service.endpoints_service_openapi.*.id}"
}

output "google_endpoints_service_openapi_endpoints" {
    description = "endpoints"
    value       = "${google_endpoints_service.endpoints_service_openapi.*.endpoints}"
}

output "google_endpoints_service_openapi_dns_address" {
    description = "dns_address"
    value       = "${google_endpoints_service.endpoints_service_openapi.*.dns_address}"
}

output "google_endpoints_service_openapi_apis" {
    description = "apis"
    value       = "${google_endpoints_service.endpoints_service_openapi.*.apis}"
}
#-----------------------------------------------------------------------
#
#-----------------------------------------------------------------------
output "google_endpoints_service_grpc_id" {
    description = "ID"
    value       = "${google_endpoints_service.endpoints_service_grpc.*.id}"
}

output "google_endpoints_service_grpc_endpoints" {
    description = "endpoints"
    value       = "${google_endpoints_service.endpoints_service_grpc.*.endpoints}"
}

output "google_endpoints_service_grpc_dns_address" {
    description = "dns_address"
    value       = "${google_endpoints_service.endpoints_service_grpc.*.dns_address}"
}

output "google_endpoints_service_grpc_apis" {
    description = "apis"
    value       = "${google_endpoints_service.endpoints_service_grpc.*.apis}"
}

