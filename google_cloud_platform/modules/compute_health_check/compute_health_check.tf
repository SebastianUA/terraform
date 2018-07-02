#---------------------------------------------------
# Create compute http health check
#---------------------------------------------------
resource "google_compute_health_check" "compute_http_health_check" {
    count = "${var.enable_compute_http_health_check ? 1 : 0 }"
            
    project             = "${var.project}"
    name                = "${length(var.custom_name) > 0 ? var.custom_name : "${lower(var.name)}-http-hc-${lower(var.environment)}" }"
    description         = "${var.description}"

    check_interval_sec  = "${var.check_interval_sec}"
    timeout_sec         = "${var.timeout_sec}"
    
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"

    http_health_check {
        host            = "${var.http_health_check_host}"
        port            = "${var.http_health_check_port}"
        proxy_header    = "${var.http_health_check_proxy_header}"
        request_path    = "${var.http_health_check_request_path}"
        
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }

}
#---------------------------------------------------
# Create compute https health check
#---------------------------------------------------
resource "google_compute_health_check" "compute_https_health_check" {
    count = "${var.enable_compute_https_health_check ? 1 : 0 }"

    project             = "${var.project}"
    name                = "${length(var.custom_name) > 0 ? var.custom_name : "${lower(var.name)}-https-hc-${lower(var.environment)}" }"
    description         = "${var.description}"
    
    check_interval_sec  = "${var.check_interval_sec}"
    timeout_sec         = "${var.timeout_sec}"
    
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"

    https_health_check {            
        host            = "${var.https_health_check_host}"
        port            = "${var.https_health_check_port}"
        proxy_header    = "${var.https_health_check_proxy_header}"
        request_path    = "${var.https_health_check_request_path}"
    }
    
    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }

}
#---------------------------------------------------
# Create compute SSL health check
#---------------------------------------------------
resource "google_compute_health_check" "compute_ssl_health_check" {
    count = "${var.enable_compute_ssl_health_check ? 1 : 0 }"

    project             = "${var.project}"
    name                = "${length(var.custom_name) > 0 ? var.custom_name : "${lower(var.name)}-ssl-hc-${lower(var.environment)}" }"
    description         = "${var.description}"

    check_interval_sec  = "${var.check_interval_sec}"
    timeout_sec         = "${var.timeout_sec}"

    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"

    ssl_health_check {
        port            = "${var.ssl_health_check_port}"
        proxy_header    = "${var.ssl_health_check_proxy_header}"
        request         = "${var.ssl_health_check_request}"
        response        = "${var.ssl_health_check_response}"
    }
    
    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }
}
#---------------------------------------------------
# Create compute TCP health check
#---------------------------------------------------
resource "google_compute_health_check" "compute_tcp_health_check" {
    count = "${var.enable_compute_tcp_health_check ? 1 : 0 }"

    project             = "${var.project}"
    name                = "${length(var.custom_name) > 0 ? var.custom_name : "${lower(var.name)}-tcp-hc-${lower(var.environment)}" }"
    description         = "${var.description}"

    check_interval_sec  = "${var.check_interval_sec}"
    timeout_sec         = "${var.timeout_sec}"

    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"

    tcp_health_check {
        port            = "${var.tcp_health_check_port}"
        proxy_header    = "${var.tcp_health_check_proxy_header}"
        request         = "${var.tcp_health_check_request}"
        response        = "${var.tcp_health_check_response}"
    }

    lifecycle {
        ignore_changes = []
        create_before_destroy = true
    }

}

