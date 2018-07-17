#---------------------------------------------------
# Create endpoints service (openapi)
#---------------------------------------------------
resource "google_endpoints_service" "endpoints_service_openapi" {
    count           = "${var.enable_endpoints_service_openapi && length(var.openapi_config) >0 ? 1 : 0}"  

    service_name    = "${var.service_name}"
    project         = "${var.project}"
    openapi_config  = "${file("${path.module}/${var.openapi_config}")}"

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}

#---------------------------------------------------
# Create endpoints service (grpc)
#---------------------------------------------------
resource "google_endpoints_service" "endpoints_service_grpc" {
    count                   = "${var.enable_endpoints_service_grpc && length(var.grpc_config) >0 && length(var.protoc_output_base64) >0 ? 1 : 0}"  
                
    service_name            = "${var.service_name}"
    project                 = "${var.project}"
    grpc_config             = "${file("${path.module}/${var.grpc_config}")}"
    protoc_output_base64    = "${file("${path.module}/${var.protoc_output_base64}")}"
                    
    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
