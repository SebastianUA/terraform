# Work with EVENTGRID_MESSAGING via terraform

A terraform module for making EVENTGRID_MESSAGING.


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

module "eventgrid_messaging" {
  source = "../../modules/eventgrid_messaging"

  enable_eventgrid_topic = true

  eventgrid_topic_name                = "eventgrid-topic"
  eventgrid_topic_location            = module.base_resource_group.resource_group_location
  eventgrid_topic_resource_group_name = module.base_resource_group.resource_group_name


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
- `enable_eventgrid_topic` - Enable eventgrid topic usage (`default = False`)
- `eventgrid_topic_name` - Specifies the name of the EventGrid Topic resource. Changing this forces a new resource to be created. (`default = ""`)
- `eventgrid_topic_resource_group_name` - (Required) The name of the resource group in which the EventGrid Topic exists. Changing this forces a new resource to be created. (`default = null`)
- `eventgrid_topic_location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `eventgrid_topic_input_schema` - (Optional) Specifies the schema in which incoming events will be published to this domain. Allowed values are CloudEventSchemaV1_0, CustomEventSchema, or EventGridSchema. Defaults to EventGridSchema. Changing this forces a new resource to be created. (`default = null`)
- `eventgrid_topic_public_network_access_enabled` - (Optional) Whether or not public network access is allowed for this server. Defaults to true. (`default = null`)
- `eventgrid_topic_local_auth_enabled` - (Optional) Whether local authentication methods is enabled for the EventGrid Topic. Defaults to true. (`default = null`)
- `eventgrid_topic_identity` - (Optional) An identity block (`default = {}`)
- `eventgrid_topic_input_mapping_fields` - (Optional) A input_mapping_fields block (`default = {}`)
- `eventgrid_topic_input_mapping_default_values` - (Optional) A input_mapping_default_values block (`default = {}`)
- `eventgrid_topic_inbound_ip_rule` - (Optional) One or more inbound_ip_rule blocks (`default = []`)
- `eventgrid_topic_timeouts` - Set timeouts for eventgrid topic (`default = {}`)
- `enable_eventgrid_system_topic` - Enable eventgrid system topic usage (`default = False`)
- `eventgrid_system_topic_name` - The name which should be used for this Event Grid System Topic. Changing this forces a new Event Grid System Topic to be created. (`default = ""`)
- `eventgrid_system_topic_resource_group_name` - (Required) The name of the Resource Group where the Event Grid System Topic should exist. Changing this forces a new Event Grid System Topic to be created. (`default = null`)
- `eventgrid_system_topic_source_arm_resource_id` - (Required) The ID of the Event Grid System Topic ARM Source. Changing this forces a new Event Grid System Topic to be created. (`default = null`)
- `eventgrid_system_topic_topic_type` - (Required) The Topic Type of the Event Grid System Topic. The topic type is validated by Azure and there may be additional topic types beyond the following: Microsoft.AppConfiguration.ConfigurationStores, Microsoft.Communication.CommunicationServices, Microsoft.ContainerRegistry.Registries, Microsoft.Devices.IoTHubs, Microsoft.EventGrid.Domains, Microsoft.EventGrid.Topics, Microsoft.Eventhub.Namespaces, Microsoft.KeyVault.vaults, Microsoft.MachineLearningServices.Workspaces, Microsoft.Maps.Accounts, Microsoft.Media.MediaServices, Microsoft.Resources.ResourceGroups, Microsoft.Resources.Subscriptions, Microsoft.ServiceBus.Namespaces, Microsoft.SignalRService.SignalR, Microsoft.Storage.StorageAccounts, Microsoft.Web.ServerFarms and Microsoft.Web.Sites. Changing this forces a new Event Grid System Topic to be created. (`default = null`)
- `eventgrid_system_topic_identity` - (Optional) An identity block (`default = {}`)
- `eventgrid_system_topic_timeouts` - Set timeouts for eventgrid system topic (`default = {}`)
- `enable_eventgrid_system_topic_event_subscription` - Enable eventgrid system topic event subscription usage (`default = False`)
- `enable_eventgrid_system_topic_event_subscription_name` - The name which should be used for this Event Subscription. Changing this forces a new Event Subscription to be created. (`default = ""`)
- `enable_eventgrid_system_topic_event_subscription_system_topic` - The System Topic where the Event Subscription should be created in. Changing this forces a new Event Subscription to be created. (`default = ""`)
- `enable_eventgrid_system_topic_event_subscription_resource_group_name` - (Required) The name of the Resource Group where the System Topic exists. Changing this forces a new Event Subscription to be created. (`default = null`)
- `enable_eventgrid_system_topic_event_subscription_expiration_time_utc` - (Optional) Specifies the expiration time of the event subscription (Datetime Format RFC 3339). (`default = null`)
- `enable_eventgrid_system_topic_event_subscription_event_delivery_schema` - (Optional) Specifies the event delivery schema for the event subscription. Possible values include: EventGridSchema, CloudEventSchemaV1_0, CustomInputSchema. Defaults to EventGridSchema. Changing this forces a new resource to be created. (`default = null`)
- `enable_eventgrid_system_topic_event_subscription_eventhub_endpoint_id` - (Optional) Specifies the id where the Event Hub is located. (`default = null`)
- `enable_eventgrid_system_topic_event_subscription_hybrid_connection_endpoint_id` - (Optional) Specifies the id where the Hybrid Connection is located. (`default = null`)
- `enable_eventgrid_system_topic_event_subscription_service_bus_queue_endpoint_id` - (Optional) Specifies the id where the Service Bus Queue is located. (`default = null`)
- `enable_eventgrid_system_topic_event_subscription_service_bus_topic_endpoint_id` - (Optional) Specifies the id where the Service Bus Topic is located. (`default = null`)
- `enable_eventgrid_system_topic_event_subscription_included_event_types` - (Optional) A list of applicable event types that need to be part of the event subscription. (`default = null`)
- `enable_eventgrid_system_topic_event_subscription_labels` - (Optional) A list of labels to assign to the event subscription. (`default = null`)
- `enable_eventgrid_system_topic_event_subscription_advanced_filtering_on_arrays_enabled` - Optional) Specifies whether advanced filters should be evaluated against an array of values instead of expecting a singular value. Defaults to false. (`default = null`)
- `eventgrid_system_topic_event_subscription_azure_function_endpoint` - (Optional) An azure_function_endpoint block (`default = {}`)
- `eventgrid_system_topic_event_subscription_storage_queue_endpoint` - (Optional) A storage_queue_endpoint block (`default = {}`)
- `eventgrid_system_topic_event_subscription_webhook_endpoint` - (Optional) A webhook_endpoint block (`default = {}`)
- `eventgrid_system_topic_event_subscription_subject_filter` - (Optional) A subject_filter block (`default = {}`)
- `eventgrid_system_topic_event_subscription_advanced_filter` - (Optional) A advanced_filter block (`default = []`)
- `eventgrid_system_topic_event_subscription_delivery_identity` - (Optional) A delivery_identity block (`default = []`)
- `eventgrid_system_topic_event_subscription_delivery_property` - (Optional) One or more delivery_property blocks (`default = []`)
- `eventgrid_system_topic_event_subscription_dead_letter_identity` - (Optional) A dead_letter_identity block (`default = {}`)
- `eventgrid_system_topic_event_subscription_storage_blob_dead_letter_destination` - (Optional) A storage_blob_dead_letter_destination block (`default = {}`)
- `eventgrid_system_topic_event_subscription_retry_policy` - (Optional) A retry_policy block (`default = {}`)
- `eventgrid_system_topic_event_subscription_timeouts` - Set timeouts for eventgrid system topic event subscription (`default = {}`)
- `enable_eventgrid_event_subscription` - Enable eventgrid system topic event subscription usage (`default = False`)
- `enable_eventgrid_event_subscription_name` - The name which should be used for this Event Subscription. Changing this forces a new Event Subscription to be created. (`default = ""`)
- `enable_eventgrid_event_subscription_system_topic` - The System Topic where the Event Subscription should be created in. Changing this forces a new Event Subscription to be created. (`default = ""`)
- `enable_eventgrid_event_subscription_resource_group_name` - (Required) The name of the Resource Group where the System Topic exists. Changing this forces a new Event Subscription to be created. (`default = null`)
- `enable_eventgrid_event_subscription_expiration_time_utc` - (Optional) Specifies the expiration time of the event subscription (Datetime Format RFC 3339). (`default = null`)
- `enable_eventgrid_event_subscription_event_delivery_schema` - (Optional) Specifies the event delivery schema for the event subscription. Possible values include: EventGridSchema, CloudEventSchemaV1_0, CustomInputSchema. Defaults to EventGridSchema. Changing this forces a new resource to be created. (`default = null`)
- `enable_eventgrid_event_subscription_eventhub_endpoint_id` - (Optional) Specifies the id where the Event Hub is located. (`default = null`)
- `enable_eventgrid_event_subscription_hybrid_connection_endpoint_id` - (Optional) Specifies the id where the Hybrid Connection is located. (`default = null`)
- `enable_eventgrid_event_subscription_service_bus_queue_endpoint_id` - (Optional) Specifies the id where the Service Bus Queue is located. (`default = null`)
- `enable_eventgrid_event_subscription_service_bus_topic_endpoint_id` - (Optional) Specifies the id where the Service Bus Topic is located. (`default = null`)
- `enable_eventgrid_event_subscription_included_event_types` - (Optional) A list of applicable event types that need to be part of the event subscription. (`default = null`)
- `enable_eventgrid_event_subscription_labels` - (Optional) A list of labels to assign to the event subscription. (`default = null`)
- `enable_eventgrid_event_subscription_advanced_filtering_on_arrays_enabled` - Optional) Specifies whether advanced filters should be evaluated against an array of values instead of expecting a singular value. Defaults to false. (`default = null`)
- `eventgrid_event_subscription_azure_function_endpoint` - (Optional) An azure_function_endpoint block (`default = {}`)
- `eventgrid_event_subscription_storage_queue_endpoint` - (Optional) A storage_queue_endpoint block (`default = {}`)
- `eventgrid_event_subscription_webhook_endpoint` - (Optional) A webhook_endpoint block (`default = {}`)
- `eventgrid_event_subscription_subject_filter` - (Optional) A subject_filter block (`default = {}`)
- `eventgrid_event_subscription_advanced_filter` - (Optional) A advanced_filter block (`default = []`)
- `eventgrid_event_subscription_delivery_identity` - (Optional) A delivery_identity block (`default = []`)
- `eventgrid_event_subscription_delivery_property` - (Optional) One or more delivery_property blocks (`default = []`)
- `eventgrid_event_subscription_dead_letter_identity` - (Optional) A dead_letter_identity block (`default = {}`)
- `eventgrid_event_subscription_storage_blob_dead_letter_destination` - (Optional) A storage_blob_dead_letter_destination block (`default = {}`)
- `eventgrid_event_subscription_retry_policy` - (Optional) A retry_policy block (`default = {}`)
- `eventgrid_event_subscription_timeouts` - Set timeouts for eventgrid system topic event subscription (`default = {}`)
- `enable_eventgrid_domain` - Enable eventgrid domain usage (`default = False`)
- `eventgrid_domain_name` - Specifies the name of the EventGrid Domain resource. Changing this forces a new resource to be created. (`default = ""`)
- `eventgrid_domain_resource_group_name` - (Required) The name of the resource group in which the EventGrid Domain exists. Changing this forces a new resource to be created. (`default = null`)
- `eventgrid_domain_location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `eventgrid_domain_input_schema` - (Optional) Specifies the schema in which incoming events will be published to this domain. Allowed values are CloudEventSchemaV1_0, CustomEventSchema, or EventGridSchema. Defaults to eventgridschema. Changing this forces a new resource to be created. (`default = null`)
- `eventgrid_domain_public_network_access_enabled` - (Optional) Whether or not public network access is allowed for this server. Defaults to true. (`default = null`)
- `eventgrid_domain_local_auth_enabled` - (Optional) Whether local authentication methods is enabled for the EventGrid Domain. Defaults to true (`default = null`)
- `eventgrid_domain_auto_create_topic_with_first_subscription` - (Optional) Whether to create the domain topic when the first event subscription at the scope of the domain topic is created. Defaults to true. (`default = null`)
- `eventgrid_domain_auto_delete_topic_with_last_subscription` - Optional) Whether to delete the domain topic when the last event subscription at the scope of the domain topic is deleted. Defaults to true. (`default = null`)
- `eventgrid_domain_identity` - (Optional) An identity block (`default = {}`)
- `eventgrid_domain_input_mapping_fields` - (Optional) A input_mapping_fields block (`default = {}`)
- `eventgrid_domain_input_mapping_default_values` - (Optional) A input_mapping_default_values block (`default = {}`)
- `eventgrid_domain_inbound_ip_rule` - (Optional) One or more inbound_ip_rule blocks (`default = []`)
- `eventgrid_domain_timeouts` - Set timeouts for eventgrid domain (`default = {}`)
- `enable_eventgrid_domain_topic` - Enable eventgrid domain topic usage (`default = False`)
- `eventgrid_domain_topic_name` - Specifies the name of the EventGrid Domain Topic resource. Changing this forces a new resource to be created. (`default = ""`)
- `eventgrid_domain_topic_domain_name` - Specifies the name of the EventGrid Domain. Changing this forces a new resource to be created. (`default = ""`)
- `eventgrid_domain_topic_resource_group_name` - (Required) The name of the resource group in which the EventGrid Domain exists. Changing this forces a new resource to be created. (`default = null`)
- `eventgrid_domain_topic_timeouts` - Set timeouts for eventgrid domain topic (`default = {}`)

## Module Output Variables
----------------------
- `eventgrid_topic_id` - The EventGrid Topic ID.
- `eventgrid_topic_endpoint` - The Endpoint associated with the EventGrid Topic.
- `eventgrid_topic_primary_access_key` - The Primary Shared Access Key associated with the EventGrid Topic.
- `eventgrid_topic_secondary_access_key` - The Secondary Shared Access Key associated with the EventGrid Topic.
- `eventgrid_topic_identity` - The identity block with principal_id and tenant_id
- `eventgrid_system_topic_id` - The ID of the Event Grid System Topic.
- `eventgrid_system_topic_identity` - An identity block
- `eventgrid_system_topic_metric_arm_resource_id` - The Metric ARM Resource ID of the Event Grid System Topic.
- `eventgrid_system_topic_event_subscription_id` - The ID of the EventGrid System Topic.
- `eventgrid_event_subscription_id` - The ID of the EventGrid System Topic.
- `eventgrid_domain_id` - The ID of the EventGrid Domain.
- `eventgrid_domain_endpoint` - The Endpoint associated with the EventGrid Domain.
- `eventgrid_domain_primary_access_key` - The Primary Shared Access Key associated with the EventGrid Domain.
- `eventgrid_domain_secondary_access_key` - The Secondary Shared Access Key associated with the EventGrid Domain.
- `eventgrid_domain_identity` - An identity block as defined below, which contains the Managed Service Identity information for this Event Grid Domain.
- `eventgrid_domain_topic_id` - The ID of the EventGrid Domain Topic.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
