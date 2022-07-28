# Work with NETWORK via terraform

A terraform module for making NETWORK.


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

module "network_sg" {
  source = "../../modules/network"

  // Enable Network SG
  enable_network_security_group              = true
  network_security_group_name                = "my-sg"
  network_security_group_location            = module.base_resource_group.resource_group_location
  network_security_group_resource_group_name = module.base_resource_group.resource_group_name

  network_security_group_security_rule = [
    {
      name      = "test123"
      protocol  = "Tcp"
      access    = "Allow"
      priority  = 100
      direction = "Inbound"


      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
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

module "virtual_network" {
  source = "../../modules/network"

  // Enable Network SG
  enable_virtual_network              = true
  virtual_network_name                = "my-virtual-network"
  virtual_network_location            = module.base_resource_group.resource_group_location
  virtual_network_resource_group_name = module.base_resource_group.resource_group_name

  virtual_network_dns_servers   = []
  virtual_network_address_space = ["10.0.0.0/16"]
  virtual_network_subnet = [
    {
      # name           = 
      address_prefix = "10.0.1.0/24"
      security_group = module.network_sg.network_security_group_id
    },
    {
      # name           = 
      address_prefix = "10.0.2.0/24"
    }
  ]

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group,
    module.network_sg
  ]
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `tags` - Add additional tags (`default = {}`)
- `enable_network_security_group` - Enable network security group usage (`default = False`)
- `network_security_group_name` - Specifies the name of the network security group. Changing this forces a new resource to be created. (`default = ""`)
- `network_security_group_resource_group_name` - (Required) The name of the resource group in which to create the network security group. Changing this forces a new resource to be created. (`default = null`)
- `network_security_group_location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `network_security_group_security_rule` - (Optional) List of objects representing security rules (`default = []`)
- `network_security_group_timeouts` - Set timeouts for network security group (`default = {}`)
- `enable_network_security_rule` - Enable network security rule usage (`default = False`)
- `network_security_rule_name` - The name of the security rule. This needs to be unique across all Rules in the Network Security Group. Changing this forces a new resource to be created. (`default = ""`)
- `network_security_rule_resource_group_name` - (Required) The name of the resource group in which to create the Network Security Rule. Changing this forces a new resource to be created. (`default = null`)
- `network_security_rule_network_security_group_name` - The name of the Network Security Group that we want to attach the rule to. Changing this forces a new resource to be created. (`default = ""`)
- `network_security_rule_protocol` - (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all). (`default = null`)
- `network_security_rule_access` - (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny. (`default = null`)
- `network_security_rule_priority` - (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule. (`default = null`)
- `network_security_rule_direction` - (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound. (`default = null`)
- `network_security_rule_description` - (Optional) A description for this rule. Restricted to 140 characters. (`default = null`)
- `network_security_rule_source_port_range` - (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified. (`default = null`)
- `network_security_rule_source_port_ranges` - (Optional) List of source ports or port ranges. This is required if source_port_range is not specified. (`default = null`)
- `network_security_rule_destination_port_range` - (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified. (`default = null`)
- `network_security_rule_destination_port_ranges` - (Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified. (`default = null`)
- `network_security_rule_source_address_prefix` - (Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified. (`default = null`)
- `network_security_rule_source_address_prefixes` - (Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified. (`default = null`)
- `network_security_rule_source_application_security_group_ids` - (Optional) A List of source Application Security Group IDs (`default = null`)
- `network_security_rule_destination_address_prefix` - (Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. Besides, it also supports all available Service Tags like ‘Sql.WestEurope‘, ‘Storage.EastUS‘, etc. You can list the available service tags with the CLI: shell az network list-service-tags --location westcentralus. For further information please see Azure CLI - az network list-service-tags. This is required if destination_address_prefixes is not specified. (`default = null`)
- `network_security_rule_destination_address_prefixes` - (Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified. (`default = null`)
- `network_security_rule_destination_application_security_group_ids` - (Optional) A List of destination Application Security Group IDs (`default = null`)
- `network_security_rule_timeouts` - Set timeouts for network security rule (`default = {}`)
- `enable_network_security_rule_stacks` - Enable network security rules with multiple blocks (`default = False`)
- `network_security_rule_stacks` - Set rules properties (`default = []`)
- `network_security_rule_stacks_timeouts` - Set timeouts for network security rule stacks (`default = {}`)
- `enable_virtual_network` - Enable virtual network usage (`default = False`)
- `virtual_network_name` - The name of the virtual network. Changing this forces a new resource to be created. (`default = ""`)
- `virtual_network_resource_group_name` - (Required) The name of the resource group in which to create the virtual network. (`default = null`)
- `virtual_network_location` - (Required) The location/region where the virtual network is created. Changing this forces a new resource to be created. (`default = null`)
- `virtual_network_address_space` - (Required) The address space that is used the virtual network. You can supply more than one address space. (`default = null`)
- `virtual_network_bgp_community` - (Optional) The BGP community attribute in format <as-number>:<community-value>. (`default = null`)
- `virtual_network_dns_servers` - (Optional) List of IP addresses of DNS servers (`default = null`)
- `virtual_network_edge_zone` - (Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created. (`default = null`)
- `virtual_network_flow_timeout_in_minutes` - (Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes. (`default = null`)
- `virtual_network_subnet` - (Optional) Can be specified multiple times to define multiple subnets. (`default = []`)
- `virtual_network_ddos_protection_plan` - (Optional) A ddos_protection_plan block (`default = {}`)
- `virtual_network_timeouts` - Set timeouts for virtual network (`default = {}`)

## Module Output Variables
----------------------
- `network_security_group_id` - The ID of the Network Security Group.
- `network_security_group_name` - The name of the Network Security Group.
- `network_security_rule_id` - The ID of the Network Security Rule.
- `network_security_rule_stacks_id` - The IDs of the Network Security Rules.
- `virtual_network_id` - The virtual NetworkConfiguration ID.
- `virtual_network_name` - The name of the virtual network.
- `virtual_network_resource_group_name` - The name of the resource group in which to create the virtual network.
- `virtual_network_location` - The location/region where the virtual network is created.
- `virtual_network_address_space` - The list of address spaces used by the virtual network.
- `virtual_network_guid` - The GUID of the virtual network.
- `virtual_network_subnet` - The virtual NetworkConfiguration ID.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
