# Work with LB via terraform

A terraform module for making LB.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.1.0"
    }
  }
}

provider "azurerm" {
  # The AzureRM Provider supports authenticating using via the Azure CLI, a Managed Identity
  # and a Service Principal. More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure

  # The features block allows changing the behaviour of the Azure Provider, more
  # information can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/features-block
  features {}

  // subscription_id = ""
  // tenant_id       = ""
}

module "base_resource_group" {
  source = "../../modules/base"

  enable_resource_group   = true
  resource_group_name     = "res-group"
  resource_group_location = "West Europe"

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

module "lb" {
  source = "../../modules/lb"

  // LB
  enable_lb              = true
  lb_name                = ""
  lb_location            = module.base_resource_group.resource_group_location
  lb_resource_group_name = module.base_resource_group.resource_group_name

  lb_frontend_ip_configuration = [
    {
      name                 = "PublicIPAddress"
      public_ip_address_id = "public_ip_address_id_here"
    }
  ]

  // LB rule
  enabne_lb_rule                         = true
  lb_rule_name                           = ""
  lb_rule_frontend_ip_configuration_name = "PublicIPAddress"
  lb_rule_protocol                       = "Tcp"
  lb_rule_frontend_port                  = 3389
  lb_rule_backend_port                   = 3389

  // LB probe
  enable_lb_probe = true
  lb_probe_name   = ""
  lb_probe_port   = 22

  // LB nat rule
  enable_lb_nat_rule                         = true
  lb_nat_rule_name                           = ""
  lb_nat_rule_resource_group_name            = module.base_resource_group.resource_group_name
  lb_nat_rule_frontend_ip_configuration_name = "PublicIPAddress"
  lb_nat_rule_protocol                       = "Tcp"
  lb_nat_rule_frontend_port                  = 3389
  lb_nat_rule_backend_port                   = 3389

  // LB nat pool
  enable_lb_nat_pool                         = true
  lb_nat_pool_name                           = ""
  lb_nat_pool_resource_group_name            = module.base_resource_group.resource_group_name
  lb_nat_pool_frontend_ip_configuration_name = "PublicIPAddress"
  lb_nat_pool_protocol                       = "Tcp"
  lb_nat_pool_frontend_port_start            = 80
  lb_nat_pool_frontend_port_end              = 81
  lb_nat_pool_backend_port                   = 3389

  // LB backend address pool
  enable_lb_backend_address_pool = true
  lb_backend_address_pool_name   = ""

  // LB lb backend address pool address
  enable_lb_backend_address_pool_address             = true
  lb_backend_address_pool_address_name               = ""
  lb_backend_address_pool_address_virtual_network_id = "virt_net_id_here"
  lb_backend_address_pool_address_ip_address         = "10.0.0.1"

  // LB outbound rule
  enable_lb_outbound_rule   = true
  lb_outbound_rule_name     = ""
  lb_outbound_rule_protocol = "Tcp"
  // lb_outbound_rule_backend_address_pool_id = ""

  lb_outbound_rule_frontend_ip_configuration = [
    {
      name = "PublicIPAddress"
    }
  ]


  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `tags` - Add additional tags (`default = {}`)
- `enable_lb` - Enable lb usage (`default = False`)
- `lb_name` - Specifies the name of the Load Balancer. (`default = ""`)
- `lb_resource_group_name` - (Required) The name of the Resource Group in which to create the Load Balancer. (`default = null`)
- `lb_location` - (Required) Specifies the supported Azure Region where the Load Balancer should be created. (`default = null`)
- `lb_edge_zone` - (Optional) Specifies the Edge Zone within the Azure Region where this Load Balancer should exist. Changing this forces a new Load Balancer to be created. (`default = null`)
- `lb_sku` - (Optional) The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway. Defaults to Basic. (`default = null`)
- `lb_sku_tier` - (Optional) sku_tier - (Optional) The SKU tier of this Load Balancer. Possible values are Global and Regional. Defaults to Regional. Changing this forces a new resource to be created. (`default = null`)
- `lb_frontend_ip_configuration` - (Optional) One or multiple frontend_ip_configuration blocks (`default = []`)
- `lb_timeouts` - Set timeouts for LB (`default = {}`)
- `enabne_lb_rule` - Enabne lb rule usage (`default = False`)
- `lb_rule_name` - Specifies the name of the LB Rule. (`default = ""`)
- `lb_rule_loadbalancer_id` - The ID of the Load Balancer in which to create the Rule. (`default = ""`)
- `lb_rule_frontend_ip_configuration_name` - (Required) The name of the frontend IP configuration to which the rule is associated. (`default = null`)
- `lb_rule_protocol` - (Required) The transport protocol for the external endpoint. Possible values are Tcp, Udp or All (`default = null`)
- `lb_rule_frontend_port` - (Required) The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 0 and 65534, inclusive. (`default = null`)
- `lb_rule_backend_port` - (Required) The port used for internal connections on the endpoint. Possible values range between 0 and 65535, inclusive. (`default = null`)
- `lb_rule_backend_address_pool_ids` - (Optional) A list of reference to a Backend Address Pool over which this Load Balancing Rule operates. (`default = null`)
- `lb_rule_probe_id` - (Optional) A reference to a Probe used by this Load Balancing Rule. (`default = null`)
- `lb_rule_enable_floating_ip` - (Optional) Are the Floating IPs enabled for this Load Balncer Rule? A 'floating' IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to false (`default = null`)
- `lb_rule_idle_timeout_in_minutes` - (Optional) Specifies the idle timeout in minutes for TCP connections. Valid values are between 4 and 30 minutes. Defaults to 4 minutes (`default = null`)
- `lb_rule_load_distribution` - (Optional) Specifies the load balancing distribution type to be used by the Load Balancer. Possible values are: Default – The load balancer is configured to use a 5 tuple hash to map traffic to available servers. SourceIP – The load balancer is configured to use a 2 tuple hash to map traffic to available servers. SourceIPProtocol – The load balancer is configured to use a 3 tuple hash to map traffic to available servers. Also known as Session Persistence, where the options are called None, Client IP and Client IP and Protocol respectively. (`default = null`)
- `lb_rule_disable_outbound_snat` - (Optional) Is snat enabled for this Load Balancer Rule? Default false. (`default = null`)
- `lb_rule_enable_tcp_reset` - (Optional) Is TCP Reset enabled for this Load Balancer Rule? Defaults to false. (`default = null`)
- `lb_rule_timeouts` - Set timeouts for lb rule (`default = {}`)
- `enable_lb_probe` - Enable lb probe usage (`default = False`)
- `lb_probe_name` - Specifies the name of the Probe. (`default = ""`)
- `lb_probe_loadbalancer_id` - The ID of the LoadBalancer in which to create the NAT Rule. (`default = ""`)
- `lb_probe_port` - (Required) Port on which the Probe queries the backend endpoint. Possible values range from 1 to 65535, inclusive. (`default = null`)
- `lb_probe_protocol` - (Optional) Specifies the protocol of the end point. Possible values are Http, Https or Tcp. If TCP is specified, a received ACK is required for the probe to be successful. If HTTP is specified, a 200 OK response from the specified URI is required for the probe to be successful. (`default = null`)
- `lb_probe_request_path` - (Optional) The URI used for requesting health status from the backend endpoint. Required if protocol is set to Http or Https. Otherwise, it is not allowed. (`default = null`)
- `lb_probe_interval_in_seconds` - (Optional) The interval, in seconds between probes to the backend endpoint for health status. The default value is 15, the minimum value is 5. (`default = null`)
- `lb_probe_number_of_probes` - (Optional) The number of failed probe attempts after which the backend endpoint is removed from rotation. The default value is 2. NumberOfProbes multiplied by intervalInSeconds value must be greater or equal to 10.Endpoints are returned to rotation when at least one probe is successful. (`default = null`)
- `lb_probe_timeouts` - Set timeouts for lb probe (`default = {}`)
- `enable_lb_outbound_rule` - Enable lb outbound rule usage (`default = False`)
- `lb_outbound_rule_name` - Specifies the name of the Outbound Rule. Changing this forces a new resource to be created. (`default = ""`)
- `lb_outbound_rule_loadbalancer_id` - The ID of the Load Balancer in which to create the Outbound Rule. Changing this forces a new resource to be created. (`default = ""`)
- `lb_outbound_rule_backend_address_pool_id` - The ID of the Backend Address Pool. Outbound traffic is randomly load balanced across IPs in the backend IPs. (`default = ""`)
- `lb_outbound_rule_protocol` - (Required) The transport protocol for the external endpoint. Possible values are Udp, Tcp or All (`default = null`)
- `lb_outbound_rule_frontend_ip_configuration` - (Required) One or more frontend_ip_configuration blocks (`default = []`)
- `lb_outbound_rule_enable_tcp_reset` - (Optional) Receive bidirectional TCP Reset on TCP flow idle timeout or unexpected connection termination. This element is only used when the protocol is set to TCP. (`default = null`)
- `lb_outbound_rule_allocated_outbound_ports` - (Optional) The number of outbound ports to be used for NAT. Defaults to 1024. (`default = null`)
- `lb_outbound_rule_idle_timeout_in_minutes` - (Optional) The timeout for the TCP idle connection (`default = null`)
- `lb_outbound_rule_timeouts` - Set timeouts for lb outbound rule (`default = {}`)
- `enable_lb_nat_rule` - Enable lb nat rule usage (`default = False`)
- `lb_nat_rule_name` - Specifies the name of the NAT Rule. (`default = ""`)
- `lb_nat_rule_resource_group_name` - (Required) The name of the resource group in which to create the resource. (`default = null`)
- `lb_nat_rule_loadbalancer_id` - The ID of the Load Balancer in which to create the NAT Rule. (`default = ""`)
- `lb_nat_rule_frontend_ip_configuration_name` - (Required) The name of the resource group in which to create the resource. (`default = null`)
- `lb_nat_rule_protocol` - (Required) The transport protocol for the external endpoint. Possible values are Udp, Tcp or All. (`default = null`)
- `lb_nat_rule_frontend_port` - (Required) The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 0 and 65534, inclusive. (`default = null`)
- `lb_nat_rule_backend_port` - (Required) The port used for internal connections on the endpoint. Possible values range between 0 and 65535, inclusive. (`default = null`)
- `lb_nat_rule_idle_timeout_in_minutes` - (Optional) Specifies the idle timeout in minutes for TCP connections. Valid values are between 4 and 30 minutes. Defaults to 4 minutes. (`default = null`)
- `lb_nat_rule_enable_floating_ip` - (Optional) Are the Floating IPs enabled for this Load Balancer Rule? A 'floating' IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to false. (`default = null`)
- `lb_nat_rule_enable_tcp_reset` - (Optional) Is TCP Reset enabled for this Load Balancer Rule? Defaults to false. (`default = null`)
- `lb_nat_rule_timeouts` - Set timeouts for lb nat rule (`default = {}`)
- `enable_lb_nat_pool` - Enable lb nat pool usage (`default = False`)
- `lb_nat_pool_name` - Specifies the name of the NAT pool. (`default = ""`)
- `lb_nat_pool_resource_group_name` - Required) The name of the resource group in which to create the resource. (`default = null`)
- `lb_nat_pool_loadbalancer_id` - The ID of the Load Balancer in which to create the NAT pool. (`default = ""`)
- `lb_nat_pool_frontend_ip_configuration_name` - (Required) The name of the frontend IP configuration exposing this rule. (`default = null`)
- `lb_nat_pool_protocol` - (Required) The transport protocol for the external endpoint. Possible values are Udp or Tcp (`default = null`)
- `lb_nat_pool_frontend_port_start` - (Required) The first port number in the range of external ports that will be used to provide Inbound NAT to NICs associated with this Load Balancer. Possible values range between 1 and 65534, inclusive. (`default = null`)
- `lb_nat_pool_frontend_port_end` - (Required) The last port number in the range of external ports that will be used to provide Inbound NAT to NICs associated with this Load Balancer. Possible values range between 1 and 65534, inclusive. (`default = null`)
- `lb_nat_pool_backend_port` - (Required) The port used for the internal endpoint. Possible values range between 1 and 65535, inclusive. (`default = null`)
- `lb_nat_pool_idle_timeout_in_minutes` - (Optional) Specifies the idle timeout in minutes for TCP connections. Valid values are between 4 and 30. Defaults to 4. (`default = null`)
- `lb_nat_pool_floating_ip_enabled` - (Optional) Are the floating IPs enabled for this Load Balancer Rule? A floating IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to false. (`default = null`)
- `lb_nat_pool_tcp_reset_enabled` - (Optional) Is TCP Reset enabled for this Load Balancer Rule? Defaults to false. (`default = null`)
- `lb_nat_pool_timeouts` - Set timeouts for lb nat pool (`default = {}`)
- `enable_lb_backend_address_pool` - Enable lb backend address pool usage (`default = False`)
- `lb_backend_address_pool_name` - Specifies the name of the Backend Address Pool. (`default = ""`)
- `lb_backend_address_pool_loadbalancer_id` - The ID of the Load Balancer in which to create the Backend Address Pool. (`default = ""`)
- `lb_backend_address_pool_tunnel_interface` - (Optional) One or more tunnel_interface blocks (`default = []`)
- `lb_nat_pool_timeouts` - Set timeouts for lb nat pool (`default = {}`)
- `enable_lb_backend_address_pool_address` - Enable lb backend address pool address usage (`default = False`)
- `lb_backend_address_pool_address_name` - The name which should be used for this Backend Address Pool Address. Changing this forces a new Backend Address Pool Address to be created. (`default = ""`)
- `lb_backend_address_pool_address_backend_address_pool_id` - The ID of the Backend Address Pool. Changing this forces a new Backend Address Pool Address to be created. (`default = ""`)
- `lb_backend_address_pool_address_virtual_network_id` - (Required) The ID of the Virtual Network within which the Backend Address Pool should exist. (`default = null`)
- `lb_backend_address_pool_address_ip_address` - (Required) The Static IP Address which should be allocated to this Backend Address Pool. (`default = null`)
- `lb_backend_address_pool_address_timeouts` - Set timeouts for lb backend address pool address (`default = {}`)

## Module Output Variables
----------------------
- `lb_id` - The Load Balancer ID.
- `lb_frontend_ip_configuration` - A frontend_ip_configuration block as documented
- `lb_private_ip_address` - The first private IP address assigned to the load balancer in frontend_ip_configuration blocks, if any.
- `lb_private_ip_addresses` - The list of private IP address assigned to the load balancer in frontend_ip_configuration blocks, if any.
- `lb_rule_id` - The ID of the Load Balancer Rule.
- `lb_probe_id` - The ID of the Load Balancer Rule.
- `lb_outbound_rule_id` - The ID of the Load Balancer Outbound Rule.
- `lb_nat_rule_id` - The ID of the Load Balancer NAT Rule.
- `lb_nat_pool_id` - The ID of the Load Balancer NAT pool.
- `lb_backend_address_pool_id` - The ID of the Backend Address Pool.
- `lb_backend_address_pool_backend_ip_configurations` - The Backend IP Configurations associated with this Backend Address Pool.
- `lb_backend_address_pool_load_balancing_rules` - The Load Balancing Rules associated with this Backend Address Pool.
- `lb_backend_address_pool_outbound_rules` - An array of the Load Balancing Outbound Rules associated with this Backend Address Pool.
- `lb_backend_address_pool_address_id` - The ID of the Backend Address Pool Address.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
