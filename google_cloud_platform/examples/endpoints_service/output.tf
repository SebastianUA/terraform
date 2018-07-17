#-----------------------------------------------------------------------
# Openapi
#-----------------------------------------------------------------------
output "endpoints_service_openapi_id" {
    description = "ID"
    value       = "${module.endpoints_service.google_endpoints_service_openapi_id}"
}

output "endpoints_service_openapi_endpoints" {
    description = "endpoints"
    value       = "${module.endpoints_service.google_endpoints_service_openapi_endpoints}"
}

output "endpoints_service_openapi_dns_address" {
    description = "dns_address"
    value       = "${module.endpoints_service.google_endpoints_service_openapi_dns_address}"
}

output "endpoints_service_openapi_apis" {
    description = "apis"
    value       = "${module.endpoints_service.google_endpoints_service_openapi_apis}"
}
#-----------------------------------------------------------------------
#
#-----------------------------------------------------------------------
output "endpoints_service_grpc_id" {
    description = "ID"
    value       = "${module.endpoints_service.google_endpoints_service_grpc_id}"
}

output "endpoints_service_grpc_endpoints" {
    description = "endpoints"
    value       = "${module.endpoints_service.google_endpoints_service_grpc_endpoints}"
}

output "endpoints_service_grpc_dns_address" {
    description = "dns_address"
    value       = "${module.endpoints_service.google_endpoints_service_grpc_dns_address}"
}

output "endpoints_service_grpc_apis" {
    description = "apis"
    value       = "${module.endpoints_service.google_endpoints_service_grpc_apis}"
}

