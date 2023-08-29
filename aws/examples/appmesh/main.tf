#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = [pathexpand("~/.aws/credentials")]
}

module "appmesh" {
  source      = "../../modules/appmesh"
  name        = "TEST"
  environment = "stage"

  # Appmesh mesh
  enable_appmesh_mesh = true
  appmesh_mesh_name   = ""

  # Appmesh virtual node
  enable_appmesh_virtual_node = true
  appmesh_virtual_node_name   = ""

  appmesh_virtual_node_backend = [{
    virtual_service_name = "servicea.simpleapp.local"
  }]

  ## Lisner
  #appmesh_virtual_node_listener                                   = [{
  #    port        = 8080
  #    protocol    = "http"
  #}]

  appmesh_virtual_node_listener_hc = [{
    pm_port     = 8080
    pm_protocol = "http"

    hc_healthy_threshold   = 3
    hc_interval_millis     = 6000
    hc_protocol            = "http"
    hc_timeout_millis      = 3000
    hc_unhealthy_threshold = 3

    hc_path = "/"
    hc_port = 8080
  }]

  ## service discovery
  #appmesh_virtual_node_service_discovery_dns                      = [{
  #    hostname        = "serviceb.simpleapp.local"
  #}]
  # or, using aws cloud map
  #appmesh_virtual_node_service_discovery_cloud_map                = [{
  #    service_name     = "serviceb1"
  #    namespace_name   = "aws_service_discovery_http_namespace_name"
  #    attributes       = {
  #        stack = "blue"
  #    }
  #}]

  appmesh_virtual_node_logging = [{
    path = "/dev/stdout"
  }]

  # Virtual Service
  enable_appmesh_virtual_service = false
  appmesh_virtual_service_name   = ""

  #appmesh_virtual_service_spec_provider_virtual_node             = [{
  #    virtual_node_name   = "aws_appmesh_virtual_node.serviceb1.name"
  #}]

  appmesh_virtual_service_spec_provider_virtual_router = [{
    virtual_router_name = "aws_appmesh_virtual_router.serviceb.name"
  }]

  enable_appmesh_virtual_router                              = true
  appmesh_virtual_router_name                                = ""
  appmesh_virtual_router_spec_listener_port_mapping_port     = 8080
  appmesh_virtual_router_spec_listener_port_mapping_protocol = "http"

  enable_appmesh_route     = true
  appmesh_route_name       = ""
  appmesh_route_http_route = []
  appmesh_route_tcp_route  = []

  enable_appmesh_virtual_gateway = true
  appmesh_virtual_gateway_spec_listener_port_mapping = [
    {
      port     = 8080
      protocol = "http"
    }
  ]
}
