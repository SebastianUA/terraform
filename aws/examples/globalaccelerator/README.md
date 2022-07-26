# Work with GLOBALACCELERATOR via terraform

A terraform module for making GLOBALACCELERATOR.


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

module "globalaccelerator" {
  source      = "../../modules/globalaccelerator"
  name        = "TEST"
  environment = "dev"

  # AWS globalaccelerator accelerator
  enable_globalaccelerator_accelerator = true
  globalaccelerator_accelerator_name   = "test-globalaccelerator-accelerator"

  globalaccelerator_accelerator_attributes = [{
    flow_logs_enabled   = true
    flow_logs_s3_bucket = "example-bucket"
    flow_logs_s3_prefix = "flow-logs/"
  }]

  # AWS globalaccelerator listener
  enable_globalaccelerator_listener          = true
  globalaccelerator_listener_client_affinity = "SOURCE_IP"
  globalaccelerator_listener_protocol        = "TCP"
  globalaccelerator_listener_port_range = [{
    from_port = 80
    to_port   = 80
  }]

  # AWS globalaccelerator endpoint group
  enable_globalaccelerator_endpoint_group = true
  globalaccelerator_endpoint_group_endpoint_configuration = [
    #{
    #    endpoint_id = "${aws_lb.example.arn}"
    #    weight      = 100
    #}
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_globalaccelerator_accelerator` - Enable globalaccelerator accelerator usage (`default = False`)
- `globalaccelerator_accelerator_name` - The name of the accelerator. (`default = ""`)
- `globalaccelerator_accelerator_ip_address_type` - (Optional) The value for the address type must be IPV4. (`default = IPV4`)
- `globalaccelerator_accelerator_enabled` - (Optional) Indicates whether the accelerator is enabled. The value is true or false. The default value is true. (`default = True`)
- `globalaccelerator_accelerator_attributes` - (Optional) The attributes of the accelerator. (`default = []`)
- `enable_globalaccelerator_listener` - Enable globalaccelerator listener usage (`default = False`)
- `globalaccelerator_listener_accelerator_arn` - The Amazon Resource Name (ARN) of your accelerator. (`default = ""`)
- `globalaccelerator_listener_client_affinity` - (Optional) Direct all requests from a user to the same endpoint. Valid values are NONE, SOURCE_IP. Default: NONE. If NONE, Global Accelerator uses the 'five-tuple' properties of source IP address, source port, destination IP address, destination port, and protocol to select the hash value. If SOURCE_IP, Global Accelerator uses the 'two-tuple' properties of source (client) IP address and destination IP address to select the hash value. (`default = NONE`)
- `globalaccelerator_listener_protocol` - (Optional) The protocol for the connections from clients to the accelerator. Valid values are TCP, UDP. (`default = TCP`)
- `globalaccelerator_listener_port_range` - (Optional) The list of port ranges for the connections from clients to the accelerator.  (`default = []`)
- `enable_globalaccelerator_endpoint_group` - Enable globalaccelerator endpoint group usage (`default = False`)
- `globalaccelerator_endpoint_group_listener_arn` - The Amazon Resource Name (ARN) of the listener. (`default = ""`)
- `globalaccelerator_endpoint_group_endpoint_group_region` - (Optional) - The name of the AWS Region where the endpoint group is located. (`default = null`)
- `globalaccelerator_endpoint_group_health_check_interval_seconds` - (Optional) The time—10 seconds or 30 seconds—between each health check for an endpoint. The default value is 30. (`default = 30`)
- `globalaccelerator_endpoint_group_health_check_path` - (Optional) If the protocol is HTTP/S, then this specifies the path that is the destination for health check targets. The default value is slash (/). (`default = /`)
- `globalaccelerator_endpoint_group_health_check_port` - (Optional) The port that AWS Global Accelerator uses to check the health of endpoints that are part of this endpoint group. The default port is the listener port that this endpoint group is associated with. If listener port is a list of ports, Global Accelerator uses the first port in the list. (`default = null`)
- `globalaccelerator_endpoint_group_health_check_protocol` - (Optional) The protocol that AWS Global Accelerator uses to check the health of endpoints that are part of this endpoint group. The default value is TCP. (`default = TCP`)
- `globalaccelerator_endpoint_group_threshold_count` - (Optional) The number of consecutive health checks required to set the state of a healthy endpoint to unhealthy, or to set an unhealthy endpoint to healthy. The default value is 3. (`default = 3`)
- `globalaccelerator_endpoint_group_traffic_dial_percentage` - (Optional) The percentage of traffic to send to an AWS Region. Additional traffic is distributed to other endpoint groups for this listener. The default value is 100. (`default = 100`)
- `globalaccelerator_endpoint_group_endpoint_configuration` - (Optional) The list of endpoint objects. (`default = []`)

## Module Output Variables
----------------------
- `globalaccelerator_accelerator_id` - The Amazon Resource Name (ARN) of the accelerator.
- `globalaccelerator_accelerator_dns_name` - The DNS name of the accelerator. For example, a5d53ff5ee6bca4ce.awsglobalaccelerator.com.
- `globalaccelerator_accelerator_hosted_zone_id` - The Global Accelerator Route 53 zone ID that can be used to route an Alias Resource Record Set to the Global Accelerator. This attribute is simply an alias for the zone ID Z2BJ6XQ5FK7U4H.
- `globalaccelerator_accelerator_ip_sets` - IP address set associated with the accelerator.
- `globalaccelerator_listener_id` - The Amazon Resource Name (ARN) of the listener.
- `globalaccelerator_endpoint_group_id` - The Amazon Resource Name (ARN) of the endpoint group.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
