# Work with VMWARE via terraform

A terraform module for making VMWARE.


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

module "vmware" {
  source = "../../modules/vmware"

  // Azure vmware private cloud
  enable_vmware_private_cloud              = true
  vmware_private_cloud_name                = "vmware-private-cloud"
  vmware_private_cloud_location            = module.base_resource_group.resource_group_location
  vmware_private_cloud_resource_group_name = module.base_resource_group.resource_group_name

  vmware_private_cloud_network_subnet_cidr = "192.168.48.0/22"
  vmware_private_cloud_sku_name            = "av36"
  vmware_private_cloud_management_cluster = {
    size = 3
  }

  vmware_private_cloud_internet_connection_enabled = false
  vmware_private_cloud_nsxt_password               = "QazWsx13$Edc"
  vmware_private_cloud_vcenter_password            = "WsxEdc23$Rfv"

  // Azure vmware cluster
  enable_vmware_cluster             = true
  vmware_cluster_name               = "vmware-cluster-1"
  vmware_cluster_cluster_node_count = 3
  vmware_cluster_sku_name           = "av36"

  // Azure vmware express route authorization
  enable_vmware_express_route_authorization = true
  vmware_express_route_authorization_name   = "vmware-express-route-authorization"

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
- `enable_vmware_private_cloud` - Enable vmware private cloud usage (`default = False`)
- `vmware_private_cloud_name` - The name which should be used for this VMware Private Cloud. Changing this forces a new VMware Private Cloud to be created. (`default = ""`)
- `vmware_private_cloud_resource_group_name` - (Required) The name of the Resource Group where the VMware Private Cloud should exist. Changing this forces a new VMware Private Cloud to be created. (`default = null`)
- `vmware_private_cloud_location` - (Required) The Azure Region where the VMware Private Cloud should exist. Changing this forces a new VMware Private Cloud to be created. (`default = null`)
- `vmware_private_cloud_network_subnet_cidr` - (Required) The subnet which should be unique across virtual network in your subscription as well as on-premise. Changing this forces a new VMware Private Cloud to be created. (`default = null`)
- `vmware_private_cloud_sku_name` - (Required) The Name of the SKU used for this Private Cloud. Possible values are av20, av36 and av36t. Changing this forces a new VMware Private Cloud to be created. (`default = null`)
- `vmware_private_cloud_management_cluster` - (Required) A management_cluster block (`default = {}`)
- `vmware_private_cloud_internet_connection_enabled` - (Optional) Is the Private Cluster connected to the internet? This field can not updated with management_cluster.0.size together. ~> NOTE : internet_connection_enabled and management_cluster.0.size cannot be updated at the same time (`default = null`)
- `vmware_private_cloud_nsxt_password` - (Optional) The password of the NSX-T Manager. Changing this forces a new VMware Private Cloud to be created. (`default = null`)
- `vmware_private_cloud_vcenter_password` - (Optional) The password of the vCenter admin. Changing this forces a new VMware Private Cloud to be created. (`default = null`)
- `vmware_private_cloud_timeouts` - Set timeouts for vmware private cloud (`default = {}`)
- `enable_vmware_cluster` - Enable vmware cluster usage (`default = False`)
- `vmware_cluster_name` - The name which should be used for this VMware Cluster. Changing this forces a new VMware Cluster to be created. (`default = ""`)
- `vmware_cluster_vmware_cloud_id` - The ID of the VMware Private Cloud in which to create this VMware Cluster. Changing this forces a new VMware Cluster to be created. (`default = ""`)
- `vmware_cluster_cluster_node_count` - (Required) The count of the VMware Cluster nodes. (`default = 1`)
- `vmware_cluster_sku_name` - (Required) The cluster SKU to use. Possible values are av20, av36, and av36t. Changing this forces a new VMware Cluster to be created. (`default = null`)
- `vmware_cluster_timeouts` - Set timeouts for vmware cluster (`default = {}`)
- `enable_vmware_express_route_authorization` - Enable vmware express route authorization usage (`default = False`)
- `vmware_express_route_authorization_name` - The name which should be used for this Express Route VMware Authorization. Changing this forces a new VMware Authorization to be created. (`default = ""`)
- `vmware_express_route_authorization_private_cloud_id` - The ID of the VMware Private Cloud in which to create this Express Route VMware Authorization. Changing this forces a new VMware Authorization to be created. (`default = ""`)
- `vmware_express_route_authorization_timeouts` - Set timeouts for vmware express route authorization (`default = {}`)

## Module Output Variables
----------------------
- `vmware_private_cloud_id` - The ID of the VMware Private Cloud.
- `vmware_private_cloud_circuit` - A circuit block
- `vmware_private_cloud_hcx_cloud_manager_endpoint` - The endpoint for the HCX Cloud Manager.
- `vmware_private_cloud_nsxt_manager_endpoint` - The endpoint for the NSX-T Data Center manager.
- `vmware_private_cloud_vcsa_endpoint` - The endpoint for Virtual Center Server Appliance.
- `vmware_private_cloud_nsxt_certificate_thumbprint` - The thumbprint of the NSX-T Manager SSL certificate..
- `vmware_private_cloud_vcenter_certificate_thumbprint` - The thumbprint of the vCenter Server SSL certificate.
- `vmware_private_cloud_management_subnet_cidr` - The network used to access vCenter Server and NSX-T Manager.
- `vmware_private_cloud_provisioning_subnet_cidr` - The network which is used for virtual machine cold migration, cloning, and snapshot migration.
- `vmware_private_cloud_vmotion_subnet_cidr` - The network which is used for live migration of virtual machines.
- `vmware_cluster_id` - The ID of the VMware Cluster.
- `vmware_cluster_cluster_number` - A number that identifies this VMware Cluster in its VMware Private Cloud.
- `vmware_cluster_hosts` - A list of host of the VMware Cluster.
- `vmware_express_route_authorization_id` - The ID of the VMware Authorization.
- `vmware_express_route_authorization_express_route_authorization_id` - The ID of the Express Route Circuit Authorization.
- `vmware_express_route_authorization_express_route_authorization_key` - The key of the Express Route Circuit Authorization.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
