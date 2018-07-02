variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "custom_name" {
    description = "A custom name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = ""
}

variable "project" {
    description = "The project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "zone" {
  description = "The zone that the machine should be created in"
  default     = "us-east1-b"    
} 

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}

variable "project_name" {
    description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "check_interval_sec" {
    description = "The number of seconds between each poll of the instance instance (default 5)."
    default     = "5"
}

variable "timeout_sec" {
    description = "The number of seconds to wait before declaring failure (default 5)."
    default     = 5
}

variable "description" {
    description = "Textual description field."
    default     = ""
}

variable "healthy_threshold" {
    description = "Consecutive successes required (default 2)."
    default     = 2
}

variable "unhealthy_threshold" {
    description = "Consecutive failures required (default 2)."
    default     = 2
}
#----------------------------------------------------------------
# compute_http_health_check
#----------------------------------------------------------------
variable "enable_compute_http_health_check" {
    description = "Enable compute http health check usage"
    default     = false
}

variable "http_health_check_host" {
    description = "HTTP host header field (default instance's public ip)."
    default     = ""
}

variable "http_health_check_port" {
    description = "HTTP port to connect to (default 80)."
    default     = "80"
}

variable "http_health_check_proxy_header" {
    description = "Type of proxy header to append before sending data to the backend, either NONE or PROXY_V1 (default NONE)."
    default     = "NONE"
}

variable "http_health_check_request_path" {
    description = "URL path to query (default /)."
    default     = "/"
}
#----------------------------------------------------------------
# enable_compute_https_health_check
#----------------------------------------------------------------
variable "enable_compute_https_health_check" {
    description = "Enable compute https health check usage"
    default     = false
}

variable "https_health_check_host" {
    description = "HTTPS host header field (default instance's public ip)."
    default     = ""
}

variable "https_health_check_port" {
    description = "HTTPS port to connect to (default 443)."
    default     = "443"
}

variable "https_health_check_proxy_header" {
    description = "Type of proxy header to append before sending data to the backend, either NONE or PROXY_V1 (default NONE)."
    default     = "NONE"
}

variable "https_health_check_request_path" {
    description = "URL path to query (default /)."
    default     = "/"
}
#----------------------------------------------------------------
#enable_compute_ssl_health_check
#----------------------------------------------------------------
variable "enable_compute_ssl_health_check" {
    description = "Enable compute ssl health check usage"
    default     = false
}

variable "ssl_health_check_port" {
    description = "SSL port to connect to (default 443)."
    default     = "443"
}

variable "ssl_health_check_proxy_header" {
    description = "Type of proxy header to append before sending data to the backend, either NONE or PROXY_V1 (default NONE)."
    default     = "NONE"
}

variable "ssl_health_check_request" {
    description = "Application data to send once the SSL connection has been established (default '')."
    default     = ""
}

variable "ssl_health_check_response" {
    description = "The response that indicates health (default '')"
    default     = ""
}

#----------------------------------------------------------------
#enable_compute_tcp_health_check
#----------------------------------------------------------------
variable "enable_compute_tcp_health_check" {
    description = "Enable compute tcp health check usage"
    default     = false
}

variable "tcp_health_check_port" {
    description = "TCP port to connect to (default 80)."
    default     = "80"
}

variable "tcp_health_check_proxy_header" {
    description = "Type of proxy header to append before sending data to the backend, either NONE or PROXY_V1 (default NONE)."
    default     = "NONE"
}

variable "tcp_health_check_request" {
    description = "Application data to send once the TCP connection has been established (default '')."
    default     = ""
}
            
variable "tcp_health_check_response" {
    description = "The response that indicates health (default '')"
    default     = ""
}

