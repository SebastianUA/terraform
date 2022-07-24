#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "this"
}

variable "environment" {
  description = "Environment for service"
  default     = "test"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# Azure eventgrid topic
#-----------------------------------------------------------
variable "enable_eventgrid_topic" {
  description = "Enable eventgrid topic usage"
  default     = false
}

variable "eventgrid_topic_name" {
  description = "Specifies the name of the EventGrid Topic resource. Changing this forces a new resource to be created."
  default     = ""
}

variable "eventgrid_topic_resource_group_name" {
  description = "(Required) The name of the resource group in which the EventGrid Topic exists. Changing this forces a new resource to be created."
  default     = null
}

variable "eventgrid_topic_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "eventgrid_topic_input_schema" {
  description = "(Optional) Specifies the schema in which incoming events will be published to this domain. Allowed values are CloudEventSchemaV1_0, CustomEventSchema, or EventGridSchema. Defaults to EventGridSchema. Changing this forces a new resource to be created."
  default     = null
}

variable "eventgrid_topic_public_network_access_enabled" {
  description = "(Optional) Whether or not public network access is allowed for this server. Defaults to true."
  default     = null
}

variable "eventgrid_topic_local_auth_enabled" {
  description = "(Optional) Whether local authentication methods is enabled for the EventGrid Topic. Defaults to true."
  default     = null
}

variable "eventgrid_topic_identity" {
  description = "(Optional) An identity block"
  default     = {}
}

variable "eventgrid_topic_input_mapping_fields" {
  description = "(Optional) A input_mapping_fields block"
  default     = {}
}

variable "eventgrid_topic_input_mapping_default_values" {
  description = "(Optional) A input_mapping_default_values block"
  default     = {}
}

variable "eventgrid_topic_inbound_ip_rule" {
  description = "(Optional) One or more inbound_ip_rule blocks"
  default     = []
}

variable "eventgrid_topic_timeouts" {
  description = "Set timeouts for eventgrid topic"
  default     = {}
}

#-----------------------------------------------------------
# Azure eventgrid system topic
#-----------------------------------------------------------
variable "enable_eventgrid_system_topic" {
  description = "Enable eventgrid system topic usage"
  default     = false
}

variable "eventgrid_system_topic_name" {
  description = "The name which should be used for this Event Grid System Topic. Changing this forces a new Event Grid System Topic to be created."
  default     = ""
}

variable "eventgrid_system_topic_resource_group_name" {
  description = "(Required) The name of the Resource Group where the Event Grid System Topic should exist. Changing this forces a new Event Grid System Topic to be created."
  default     = null
}

variable "eventgrid_system_topic_source_arm_resource_id" {
  description = "(Required) The ID of the Event Grid System Topic ARM Source. Changing this forces a new Event Grid System Topic to be created."
  default     = null
}

variable "eventgrid_system_topic_topic_type" {
  description = "(Required) The Topic Type of the Event Grid System Topic. The topic type is validated by Azure and there may be additional topic types beyond the following: Microsoft.AppConfiguration.ConfigurationStores, Microsoft.Communication.CommunicationServices, Microsoft.ContainerRegistry.Registries, Microsoft.Devices.IoTHubs, Microsoft.EventGrid.Domains, Microsoft.EventGrid.Topics, Microsoft.Eventhub.Namespaces, Microsoft.KeyVault.vaults, Microsoft.MachineLearningServices.Workspaces, Microsoft.Maps.Accounts, Microsoft.Media.MediaServices, Microsoft.Resources.ResourceGroups, Microsoft.Resources.Subscriptions, Microsoft.ServiceBus.Namespaces, Microsoft.SignalRService.SignalR, Microsoft.Storage.StorageAccounts, Microsoft.Web.ServerFarms and Microsoft.Web.Sites. Changing this forces a new Event Grid System Topic to be created."
  default     = null
}

variable "eventgrid_system_topic_identity" {
  description = "(Optional) An identity block"
  default     = {}
}

variable "eventgrid_system_topic_timeouts" {
  description = "Set timeouts for eventgrid system topic"
  default     = {}
}

#-----------------------------------------------------------
# Azure eventgrid system topic event subscription
#-----------------------------------------------------------
variable "enable_eventgrid_system_topic_event_subscription" {
  description = "Enable eventgrid system topic event subscription usage"
  default     = false
}

variable "enable_eventgrid_system_topic_event_subscription_name" {
  description = "The name which should be used for this Event Subscription. Changing this forces a new Event Subscription to be created."
  default     = ""
}

variable "enable_eventgrid_system_topic_event_subscription_system_topic" {
  description = "The System Topic where the Event Subscription should be created in. Changing this forces a new Event Subscription to be created."
  default     = ""
}

variable "enable_eventgrid_system_topic_event_subscription_resource_group_name" {
  description = "(Required) The name of the Resource Group where the System Topic exists. Changing this forces a new Event Subscription to be created."
  default     = null
}

variable "enable_eventgrid_system_topic_event_subscription_expiration_time_utc" {
  description = "(Optional) Specifies the expiration time of the event subscription (Datetime Format RFC 3339)."
  default     = null
}

variable "enable_eventgrid_system_topic_event_subscription_event_delivery_schema" {
  description = "(Optional) Specifies the event delivery schema for the event subscription. Possible values include: EventGridSchema, CloudEventSchemaV1_0, CustomInputSchema. Defaults to EventGridSchema. Changing this forces a new resource to be created."
  default     = null
}

variable "enable_eventgrid_system_topic_event_subscription_eventhub_endpoint_id" {
  description = "(Optional) Specifies the id where the Event Hub is located."
  default     = null
}

variable "enable_eventgrid_system_topic_event_subscription_hybrid_connection_endpoint_id" {
  description = "(Optional) Specifies the id where the Hybrid Connection is located."
  default     = null
}

variable "enable_eventgrid_system_topic_event_subscription_service_bus_queue_endpoint_id" {
  description = "(Optional) Specifies the id where the Service Bus Queue is located."
  default     = null
}

variable "enable_eventgrid_system_topic_event_subscription_service_bus_topic_endpoint_id" {
  description = "(Optional) Specifies the id where the Service Bus Topic is located."
  default     = null
}

variable "enable_eventgrid_system_topic_event_subscription_included_event_types" {
  description = "(Optional) A list of applicable event types that need to be part of the event subscription."
  default     = null
}

variable "enable_eventgrid_system_topic_event_subscription_labels" {
  description = "(Optional) A list of labels to assign to the event subscription."
  default     = null
}

variable "enable_eventgrid_system_topic_event_subscription_advanced_filtering_on_arrays_enabled" {
  description = "Optional) Specifies whether advanced filters should be evaluated against an array of values instead of expecting a singular value. Defaults to false."
  default     = null
}

variable "eventgrid_system_topic_event_subscription_azure_function_endpoint" {
  description = "(Optional) An azure_function_endpoint block"
  default     = {}
}

variable "eventgrid_system_topic_event_subscription_storage_queue_endpoint" {
  description = "(Optional) A storage_queue_endpoint block"
  default     = {}
}

variable "eventgrid_system_topic_event_subscription_webhook_endpoint" {
  description = "(Optional) A webhook_endpoint block"
  default     = {}
}

variable "eventgrid_system_topic_event_subscription_subject_filter" {
  description = "(Optional) A subject_filter block"
  default     = {}
}

variable "eventgrid_system_topic_event_subscription_advanced_filter" {
  description = "(Optional) A advanced_filter block"
  default     = []
}

variable "eventgrid_system_topic_event_subscription_delivery_identity" {
  description = "(Optional) A delivery_identity block"
  default     = []
}

variable "eventgrid_system_topic_event_subscription_delivery_property" {
  description = "(Optional) One or more delivery_property blocks"
  default     = []
}

variable "eventgrid_system_topic_event_subscription_dead_letter_identity" {
  description = "(Optional) A dead_letter_identity block"
  default     = {}
}

variable "eventgrid_system_topic_event_subscription_storage_blob_dead_letter_destination" {
  description = "(Optional) A storage_blob_dead_letter_destination block"
  default     = {}
}

variable "eventgrid_system_topic_event_subscription_retry_policy" {
  description = "(Optional) A retry_policy block"
  default     = {}
}

variable "eventgrid_system_topic_event_subscription_timeouts" {
  description = "Set timeouts for eventgrid system topic event subscription"
  default     = {}
}

#-----------------------------------------------------------
# Azure eventgrid event subscription
#-----------------------------------------------------------
variable "enable_eventgrid_event_subscription" {
  description = "Enable eventgrid system topic event subscription usage"
  default     = false
}

variable "enable_eventgrid_event_subscription_name" {
  description = "The name which should be used for this Event Subscription. Changing this forces a new Event Subscription to be created."
  default     = ""
}

variable "enable_eventgrid_event_subscription_system_topic" {
  description = "The System Topic where the Event Subscription should be created in. Changing this forces a new Event Subscription to be created."
  default     = ""
}

variable "enable_eventgrid_event_subscription_resource_group_name" {
  description = "(Required) The name of the Resource Group where the System Topic exists. Changing this forces a new Event Subscription to be created."
  default     = null
}

variable "enable_eventgrid_event_subscription_expiration_time_utc" {
  description = "(Optional) Specifies the expiration time of the event subscription (Datetime Format RFC 3339)."
  default     = null
}

variable "enable_eventgrid_event_subscription_event_delivery_schema" {
  description = "(Optional) Specifies the event delivery schema for the event subscription. Possible values include: EventGridSchema, CloudEventSchemaV1_0, CustomInputSchema. Defaults to EventGridSchema. Changing this forces a new resource to be created."
  default     = null
}

variable "enable_eventgrid_event_subscription_eventhub_endpoint_id" {
  description = "(Optional) Specifies the id where the Event Hub is located."
  default     = null
}

variable "enable_eventgrid_event_subscription_hybrid_connection_endpoint_id" {
  description = "(Optional) Specifies the id where the Hybrid Connection is located."
  default     = null
}

variable "enable_eventgrid_event_subscription_service_bus_queue_endpoint_id" {
  description = "(Optional) Specifies the id where the Service Bus Queue is located."
  default     = null
}

variable "enable_eventgrid_event_subscription_service_bus_topic_endpoint_id" {
  description = "(Optional) Specifies the id where the Service Bus Topic is located."
  default     = null
}

variable "enable_eventgrid_event_subscription_included_event_types" {
  description = "(Optional) A list of applicable event types that need to be part of the event subscription."
  default     = null
}

variable "enable_eventgrid_event_subscription_labels" {
  description = "(Optional) A list of labels to assign to the event subscription."
  default     = null
}

variable "enable_eventgrid_event_subscription_advanced_filtering_on_arrays_enabled" {
  description = "Optional) Specifies whether advanced filters should be evaluated against an array of values instead of expecting a singular value. Defaults to false."
  default     = null
}

variable "eventgrid_event_subscription_azure_function_endpoint" {
  description = "(Optional) An azure_function_endpoint block"
  default     = {}
}

variable "eventgrid_event_subscription_storage_queue_endpoint" {
  description = "(Optional) A storage_queue_endpoint block"
  default     = {}
}

variable "eventgrid_event_subscription_webhook_endpoint" {
  description = "(Optional) A webhook_endpoint block"
  default     = {}
}

variable "eventgrid_event_subscription_subject_filter" {
  description = "(Optional) A subject_filter block"
  default     = {}
}

variable "eventgrid_event_subscription_advanced_filter" {
  description = "(Optional) A advanced_filter block"
  default     = []
}

variable "eventgrid_event_subscription_delivery_identity" {
  description = "(Optional) A delivery_identity block"
  default     = []
}

variable "eventgrid_event_subscription_delivery_property" {
  description = "(Optional) One or more delivery_property blocks"
  default     = []
}

variable "eventgrid_event_subscription_dead_letter_identity" {
  description = "(Optional) A dead_letter_identity block"
  default     = {}
}

variable "eventgrid_event_subscription_storage_blob_dead_letter_destination" {
  description = "(Optional) A storage_blob_dead_letter_destination block"
  default     = {}
}

variable "eventgrid_event_subscription_retry_policy" {
  description = "(Optional) A retry_policy block"
  default     = {}
}

variable "eventgrid_event_subscription_timeouts" {
  description = "Set timeouts for eventgrid system topic event subscription"
  default     = {}
}

#-----------------------------------------------------------
# Azure eventgrid domain
#-----------------------------------------------------------
variable "enable_eventgrid_domain" {
  description = "Enable eventgrid domain usage"
  default     = false
}

variable "eventgrid_domain_name" {
  description = "Specifies the name of the EventGrid Domain resource. Changing this forces a new resource to be created."
  default     = ""
}

variable "eventgrid_domain_resource_group_name" {
  description = "(Required) The name of the resource group in which the EventGrid Domain exists. Changing this forces a new resource to be created."
  default     = null
}

variable "eventgrid_domain_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "eventgrid_domain_input_schema" {
  description = "(Optional) Specifies the schema in which incoming events will be published to this domain. Allowed values are CloudEventSchemaV1_0, CustomEventSchema, or EventGridSchema. Defaults to eventgridschema. Changing this forces a new resource to be created."
  default     = null
}

variable "eventgrid_domain_public_network_access_enabled" {
  description = "(Optional) Whether or not public network access is allowed for this server. Defaults to true."
  default     = null
}

variable "eventgrid_domain_local_auth_enabled" {
  description = "(Optional) Whether local authentication methods is enabled for the EventGrid Domain. Defaults to true"
  default     = null
}

variable "eventgrid_domain_auto_create_topic_with_first_subscription" {
  description = "(Optional) Whether to create the domain topic when the first event subscription at the scope of the domain topic is created. Defaults to true."
  default     = null
}

variable "eventgrid_domain_auto_delete_topic_with_last_subscription" {
  description = "Optional) Whether to delete the domain topic when the last event subscription at the scope of the domain topic is deleted. Defaults to true."
  default     = null
}

variable "eventgrid_domain_identity" {
  description = "(Optional) An identity block"
  default     = {}
}

variable "eventgrid_domain_input_mapping_fields" {
  description = "(Optional) A input_mapping_fields block"
  default     = {}
}

variable "eventgrid_domain_input_mapping_default_values" {
  description = "(Optional) A input_mapping_default_values block"
  default     = {}
}

variable "eventgrid_domain_inbound_ip_rule" {
  description = "(Optional) One or more inbound_ip_rule blocks"
  default     = []
}

variable "eventgrid_domain_timeouts" {
  description = "Set timeouts for eventgrid domain"
  default     = {}
}

#-----------------------------------------------------------
# Azure eventgrid domain topic
#-----------------------------------------------------------
variable "enable_eventgrid_domain_topic" {
  description = "Enable eventgrid domain topic usage"
  default     = false
}

variable "eventgrid_domain_topic_name" {
  description = "Specifies the name of the EventGrid Domain Topic resource. Changing this forces a new resource to be created."
  default     = ""
}

variable "eventgrid_domain_topic_domain_name" {
  description = "Specifies the name of the EventGrid Domain. Changing this forces a new resource to be created."
  default     = ""
}

variable "eventgrid_domain_topic_resource_group_name" {
  description = "(Required) The name of the resource group in which the EventGrid Domain exists. Changing this forces a new resource to be created."
  default     = null
}

variable "eventgrid_domain_topic_timeouts" {
  description = "Set timeouts for eventgrid domain topic"
  default     = {}
}
