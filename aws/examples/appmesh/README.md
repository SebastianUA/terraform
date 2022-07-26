# Work with APPMESH via terraform

A terraform module for making APPMESH.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
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

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_appmesh_mesh` - Enable appmesh mesh usage (`default = False`)
- `appmesh_mesh_name` - The name to use for the service mesh. (`default = ""`)
- `appmesh_mesh_spec_egress_filter_type` - (Optional) The egress filter type. By default, the type is DROP_ALL. Valid values are ALLOW_ALL and DROP_ALL. (`default = DROP_ALL`)
- `enable_appmesh_virtual_node` - Enable appmesh virtual node usage (`default = False`)
- `appmesh_virtual_node_name` - The name to use for the virtual node. (`default = ""`)
- `appmesh_virtual_node_mesh_name` - The name of the service mesh in which to create the virtual node. (`default = ""`)
- `appmesh_virtual_node_backend` - (Optional) The backends to which the virtual node is expected to send outbound traffic. (`default = []`)
- `appmesh_virtual_node_listener` - (Optional) The listeners from which the virtual node is expected to receive inbound traffic. (`default = []`)
- `appmesh_virtual_node_listener_hc` - (Optional) The listeners from which the virtual node is expected to receive inbound traffic with health_check. (`default = []`)
- `appmesh_virtual_node_service_discovery_dns` - (Optional) The service discovery information for the virtual node for DNS. (`default = []`)
- `appmesh_virtual_node_service_discovery_cloud_map` - (Optional) The service discovery information for the virtual node for aws_cloud_map. (`default = []`)
- `appmesh_virtual_node_logging` - (Optional) The inbound and outbound access logging information for the virtual node. (`default = []`)
- `enable_appmesh_virtual_service` - Enable appmesh virtual service usage (`default = False`)
- `appmesh_virtual_service_name` - The name to use for the virtual service. (`default = ""`)
- `appmesh_virtual_service_mesh_name` - The name of the service mesh in which to create the virtual service. (`default = ""`)
- `appmesh_virtual_service_spec_provider_virtual_node` - (Optional) The virtual node associated with a virtual service. (`default = []`)
- `appmesh_virtual_service_spec_provider_virtual_router` - (Optional) The virtual router associated with a virtual service. (`default = []`)
- `enable_appmesh_virtual_router` - Enable appmesh virtual router usage (`default = False`)
- `appmesh_virtual_router_name` - The name to use for the virtual router. (`default = ""`)
- `appmesh_virtual_router_mesh_name` - The name of the service mesh in which to create the virtual router. (`default = ""`)
- `appmesh_virtual_router_spec_listener_port_mapping_port` - (Required) The port used for the port mapping. (`default = 8080`)
- `appmesh_virtual_router_spec_listener_port_mapping_protocol` - (Required) The protocol used for the port mapping. Valid values are http and tcp. (`default = http`)
- `enable_appmesh_route` - Enable appmesh route usage (`default = False`)
- `appmesh_route_name` - The name to use for the route. (`default = ""`)
- `appmesh_route_mesh_name` - The name of the service mesh in which to create the route. (`default = ""`)
- `appmesh_route_virtual_router_name` - The name of the virtual router in which to create the route. (`default = ""`)
- `appmesh_route_spec_priority` - (Optional) The priority for the route, between 0 and 1000. Routes are matched based on the specified value, where 0 is the highest priority. (`default = null`)
- `appmesh_route_http_route` - (Optional) The HTTP routing information for the route. (`default = []`)
- `appmesh_route_http_route_header` - (Optional) The HTTP routing information for the route with header supporting (`default = []`)
- `appmesh_route_http_route_header_match` - (Optional) The HTTP routing information for the route with header + match supporting (`default = []`)
- `appmesh_route_http_route_header_match_range` - (Optional) The HTTP routing information for the route with header + match + range supporting (`default = []`)
- `appmesh_route_tcp_route` - (Optional) The TCP routing information for the route. (`default = []`)
- `enable_appmesh_virtual_gateway` - Enable appmesh virtual gateway usage (`default = False`)
- `appmesh_virtual_gateway_name` - The name to use for the virtual gateway. Must be between 1 and 255 characters in length. (`default = ""`)
- `appmesh_virtual_gateway_mesh_name` - The name of the service mesh in which to create the virtual gateway. Must be between 1 and 255 characters in length. (`default = ""`)
- `appmesh_virtual_gateway_mesh_owner` - (Optional) The AWS account ID of the service mesh's owner. Defaults to the account ID the AWS provider is currently connected to. (`default = null`)
- `appmesh_virtual_gateway_spec_logging` - Set some setting for appmesh virtual gateway spec logging (`default = []`)
- `appmesh_virtual_gateway_spec_backend_defaults` - Set some setting for appmesh virtual gateway spec backend_defaults (`default = []`)
- `appmesh_virtual_gateway_spec_listener_tls` - Set some setting for appmesh virtual gateway spec listner tls (`default = []`)
- `appmesh_virtual_gateway_spec_listener_health_check` - Set some setting for appmesh virtual gateway spec health_check (`default = []`)
- `appmesh_virtual_gateway_spec_listener_connection_pool` - Set some setting for appmesh virtual gateway spec listner connection_pool (`default = []`)
- `appmesh_virtual_gateway_spec_listener_port_mapping` - Set some setting for appmesh virtual gateway spec listner port_mapping (`default = []`)
- `enable_appmesh_gateway_route` - Enable appmesh gateway route usage (`default = False`)
- `appmesh_gateway_route_name` - The name to use for the gateway route. Must be between 1 and 255 characters in length. (`default = ""`)
- `appmesh_gateway_route_mesh_name` - The name of the service mesh in which to create the gateway route. Must be between 1 and 255 characters in length. (`default = ""`)
- `appmesh_gateway_route_virtual_gateway_name` - The name of the virtual gateway to associate the gateway route with. Must be between 1 and 255 characters in length. (`default = ""`)
- `appmesh_gateway_route_mesh_owner` - (Optional) The AWS account ID of the service mesh's owner. Defaults to the account ID the AWS provider is currently connected to. (`default = null`)
- `appmesh_gateway_route_spec_grpc_route` - Set some settings for appmesh gateway route spec grpc_route (`default = []`)
- `appmesh_gateway_route_spec_http_route` - Set some settings for appmesh gateway route spec http_route (`default = []`)
- `appmesh_gateway_route_spec_http2_route` - Set some settings for appmesh gateway route spec http2_route (`default = []`)

## Module Output Variables
----------------------
- `appmesh_mesh_id` - The ID of the service mesh.
- `appmesh_mesh_arn` - The ARN of the service mesh.
- `appmesh_mesh_created_date` - The creation date of the service mesh.
- `appmesh_mesh_last_updated_date` - The last update date of the service mesh.
- `appmesh_virtual_node_id` - The ID of the virtual node.
- `appmesh_virtual_node_arn` - The ARN of the virtual node.
- `appmesh_virtual_node_created_date` - The creation date of the virtual node.
- `appmesh_virtual_node_last_updated_date` - The last update date of the virtual node.
- `appmesh_virtual_service_id` - The ID of the virtual service.
- `appmesh_virtual_service_arn` - The ARN of the virtual service.
- `appmesh_virtual_service_created_date` - The creation date of the virtual service.
- `appmesh_virtual_service_last_updated_date` - The last update date of the virtual service.
- `appmesh_virtual_router_id` - The ID of the virtual router.
- `appmesh_virtual_router_arn` - The ARN of the virtual router.
- `appmesh_virtual_router_created_date` - The creation date of the virtual router.
- `appmesh_virtual_router_last_updated_date` - The last update date of the virtual router.
- `appmesh_route_id` - The ID of the route.
- `appmesh_route_arn` - The ARN of the route.
- `appmesh_route_created_date` - The creation date of the route.
- `appmesh_route_last_updated_date` - The last update date of the route.
- `appmesh_virtual_gateway_id` - The ID of the virtual gateway.
- `appmesh_virtual_gateway_arn` - The ARN of the virtual gateway.
- `appmesh_virtual_gateway_created_date` - The creation date of the virtual gateway.
- `appmesh_virtual_gateway_last_updated_date` - The last update date of the virtual gateway.
- `appmesh_virtual_gateway_resource_owner` - The resource owner's AWS account ID.
- `appmesh_gateway_route_id` - The ID of the gateway route.
- `appmesh_gateway_route_arn` - The ARN of the gateway route.
- `appmesh_gateway_route_created_date` - The creation date of the gateway route.
- `appmesh_gateway_route_last_updated_date` - The last update date of the gateway route.
- `appmesh_gateway_route_resource_owner` - The resource owner's AWS account ID.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
