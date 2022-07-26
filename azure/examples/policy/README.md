# Work with POLICY via terraform

A terraform module for making POLICY.


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
      version = "3.1.0"
    }
  }
}


provider "azurerm" {
  # Configuration options
}

module "policy" {
  source = "../../modules/policy"

  enable_policy_definition       = true
  policy_definition_name         = "test-1"
  policy_definition_policy_type  = "Custom"
  policy_definition_mode         = "Indexed"
  policy_definition_display_name = "acceptance test policy definition"

  policy_definition_policy_rule = <<POLICY_RULE
    {
    "if": {
      "not": {
        "field": "location",
        "in": "[parameters('allowedLocations')]"
      }
    },
    "then": {
      "effect": "audit"
    }
  }
POLICY_RULE

  policy_definition_metadata = <<METADATA
    {
    "category": "General"
    }

METADATA

  policy_definition_parameters = <<PARAMETERS
    {
    "allowedLocations": {
      "type": "Array",
      "metadata": {
        "description": "The list of allowed locations for resources.",
        "displayName": "Allowed locations",
        "strongType": "location"
      }
    }
  }
PARAMETERS

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = []
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `enable_policy_definition` - Enable policy definition usage (`default = False`)
- `policy_definition_name` - The name of the policy definition. Changing this forces a new resource to be created. (`default = ""`)
- `policy_definition_policy_type` - (Required) The policy type. Possible values are BuiltIn, Custom and NotSpecified. Changing this forces a new resource to be created. (`default = null`)
- `policy_definition_mode` - (Required) The policy mode that allows you to specify which resource types will be evaluated. Possible values are All, Indexed, Microsoft.ContainerService.Data, Microsoft.CustomerLockbox.Data, Microsoft.DataCatalog.Data, Microsoft.KeyVault.Data, Microsoft.Kubernetes.Data, Microsoft.MachineLearningServices.Data, Microsoft.Network.Data and Microsoft.Synapse.Data. (`default = null`)
- `policy_definition_display_name` - (Required) The display name of the policy definition. (`default = null`)
- `policy_definition_description` - (Optional) The description of the policy definition. (`default = null`)
- `policy_definition_management_group_id` - (Optional) The name of the Management Group where this policy should be defined. Changing this forces a new resource to be created. (`default = null`)
- `policy_definition_policy_rule` - (Optional) The policy rule for the policy definition. This is a JSON string representing the rule that contains an if and a then block. (`default = null`)
- `policy_definition_metadata` - (Optional) The metadata for the policy definition. This is a JSON string representing additional metadata that should be stored with the policy definition. (`default = null`)
- `policy_definition_parameters` - (Optional) Parameters for the policy definition. This field is a JSON string that allows you to parameterize your policy definition. (`default = null`)
- `policy_definition_timeouts` - Set timeouts for policy definition (`default = {}`)
- `enable_management_group_policy_assignment` - Enable management group policy assignment usage (`default = False`)
- `management_group_policy_assignment_name` - The name which should be used for this Policy Assignment. Changing this forces a new Policy Assignment to be created. (`default = ""`)
- `management_group_policy_assignment_policy_definition_id` - The ID of the Policy Definition or Policy Definition Set. Changing this forces a new Policy Assignment to be created. (`default = null`)
- `management_group_policy_assignment_management_group_id` - (Required) The ID of the Management Group. Changing this forces a new Policy Assignment to be created. (`default = null`)
- `management_group_policy_assignment_description` - (Optional) A description which should be used for this Policy Assignment. (`default = null`)
- `management_group_policy_assignment_display_name` - (Optional) The Display Name for this Policy Assignment. (`default = null`)
- `management_group_policy_assignment_enforce` - (Optional) Specifies if this Policy should be enforced or not? (`default = null`)
- `management_group_policy_assignment_location` - (Optional) The Azure Region where the Policy Assignment should exist. Changing this forces a new Policy Assignment to be created. (`default = null`)
- `management_group_policy_assignment_metadata` - (Optional) A JSON mapping of any Metadata for this Policy. (`default = null`)
- `management_group_policy_assignment_not_scopes` - (Optional) Specifies a list of Resource Scopes (for example a Subscription, or a Resource Group) within this Management Group which are excluded from this Policy. (`default = null`)
- `management_group_policy_assignment_parameters` - (Optional) A JSON mapping of any Parameters for this Policy. (`default = null`)
- `management_group_policy_assignment_identity` - (Optional) An identity block (`default = {}`)
- `management_group_policy_assignment_non_compliance_message` -  (Optional) One or more non_compliance_message blocks (`default = []`)
- `management_group_policy_assignment_timeouts` - Set timeouts for management group policy assignment (`default = {}`)
- `enable_subscription_policy_assignment` - Enable subscription policy assignment usage (`default = False`)
- `subscription_policy_assignment_name` - The name which should be used for this Policy Assignment. Changing this forces a new Policy Assignment to be created. (`default = ""`)
- `subscription_policy_assignment_policy_definition_id` - The ID of the Policy Definition or Policy Definition Set. Changing this forces a new Policy Assignment to be created. (`default = ""`)
- `subscription_policy_assignment_subscription_id` - (Required) The ID of the Subscription where this Policy Assignment should be created. Changing this forces a new Policy Assignment to be created. (`default = null`)
- `subscription_policy_assignment_description` - (Optional) A description which should be used for this Policy Assignment. (`default = null`)
- `subscription_policy_assignment_display_name` - (Optional) The Display Name for this Policy Assignment. (`default = null`)
- `subscription_policy_assignment_enforce` - (Optional) Specifies if this Policy should be enforced or not? (`default = null`)
- `subscription_policy_assignment_location` - (Optional) The Azure Region where the Policy Assignment should exist. Changing this forces a new Policy Assignment to be created. (`default = null`)
- `subscription_policy_assignment_metadata` - (Optional) A JSON mapping of any Metadata for this Policy. (`default = null`)
- `subscription_policy_assignment_not_scopes` - (Optional) Specifies a list of Resource Scopes (for example a Subscription, or a Resource Group) within this Management Group which are excluded from this Policy. (`default = null`)
- `subscription_policy_assignment_parameters` - (Optional) A JSON mapping of any Parameters for this Policy. (`default = null`)
- `subscription_policy_assignment_identity` - (Optional) An identity block (`default = {}`)
- `subscription_policy_assignment_non_compliance_message` - (Optional) One or more non_compliance_message blocks (`default = []`)
- `subscription_policy_assignment_timeouts` - Set timeouts for subscription policy assignment (`default = {}`)
- `enable_resource_policy_assignment` - Enable resource policy assignment usage (`default = False`)
- `resource_policy_assignment_name` - The name which should be used for this Policy Assignment. Changing this forces a new Resource Policy Assignment to be created. (`default = ""`)
- `resource_policy_assignment_resource_id` - (Required) The ID of the Resource (or Resource Scope) where this should be applied. Changing this forces a new Resource Policy Assignment to be created. (`default = null`)
- `resource_policy_assignment_policy_definition_id` - The ID of the Policy Definition or Policy Definition Set. Changing this forces a new Policy Assignment to be created. (`default = ""`)
- `resource_policy_assignment_description` - (Optional) A description which should be used for this Policy Assignment. (`default = null`)
- `resource_policy_assignment_display_name` - (Optional) The Display Name for this Policy Assignment. (`default = null`)
- `resource_policy_assignment_enforce` - (Optional) Specifies if this Policy should be enforced or not? (`default = null`)
- `resource_policy_assignment_location` - (Optional) The Azure Region where the Policy Assignment should exist. Changing this forces a new Policy Assignment to be created. (`default = null`)
- `resource_policy_assignment_metadata` - (Optional) A JSON mapping of any Metadata for this Policy. (`default = null`)
- `resource_policy_assignment_not_scopes` - (Optional) Specifies a list of Resource Scopes (for example a Subscription, or a Resource Group) within this Management Group which are excluded from this Policy. (`default = null`)
- `resource_policy_assignment_parameters` - (Optional) A JSON mapping of any Parameters for this Policy. (`default = null`)
- `resource_policy_assignment_identity` - (Optional) An identity block (`default = {}`)
- `resource_policy_assignment_non_compliance_message` - (Optional) One or more non_compliance_message blocks (`default = []`)
- `resource_policy_assignment_timeouts` - Set timeouts for resource policy assignment (`default = {}`)
- `enable_resource_group_policy_assignment` - Enable resource group policy assignment usage (`default = False`)
- `resource_group_policy_assignment_name` - The name which should be used for this Policy Assignment. Changing this forces a new Policy Assignment to be created. (`default = ""`)
- `resource_group_policy_assignment_resource_group_id` - (Required) The ID of the Resource Group where this Policy Assignment should be created. Changing this forces a new Policy Assignment to be created. (`default = null`)
- `resource_group_policy_assignment_policy_definition_id` - The ID of the Policy Definition or Policy Definition Set. Changing this forces a new Policy Assignment to be created. (`default = ""`)
- `resource_group_policy_assignment_description` - (Optional) A description which should be used for this Policy Assignment. (`default = null`)
- `resource_group_policy_assignment_display_name` - (Optional) The Display Name for this Policy Assignment. (`default = null`)
- `resource_group_policy_assignment_enforce` - (Optional) Specifies if this Policy should be enforced or not? (`default = null`)
- `resource_group_policy_assignment_location` - (Optional) The Azure Region where the Policy Assignment should exist. Changing this forces a new Policy Assignment to be created. (`default = null`)
- `resource_group_policy_assignment_metadata` - (Optional) A JSON mapping of any Metadata for this Policy. (`default = null`)
- `resource_group_policy_assignment_not_scopes` - (Optional) Specifies a list of Resource Scopes (for example a Subscription, or a Resource Group) within this Management Group which are excluded from this Policy. (`default = null`)
- `resource_group_policy_assignment_parameters` - (Optional) A JSON mapping of any Parameters for this Policy. (`default = null`)
- `resource_group_policy_assignment_identity` - (Optional) An identity block (`default = {}`)
- `resource_group_policy_assignment_non_compliance_message` - (Optional) One or more non_compliance_message blocks (`default = []`)
- `resource_group_policy_assignment_timeouts` - Set timeouts for resource group policy assignment (`default = {}`)
- `enable_subscription_policy_remediation` - Enable subscription policy remediation usage (`default = False`)
- `subscription_policy_remediation_name` - The name of the Policy Remediation. Changing this forces a new resource to be created. (`default = ""`)
- `subscription_policy_remediation_subscription_id` - (Required) The Subscription ID at which the Policy Remediation should be applied. Changing this forces a new resource to be created. (`default = null`)
- `subscription_policy_remediation_policy_assignment_id` - The ID of the Policy Assignment that should be remediated. (`default = null`)
- `subscription_policy_remediation_policy_definition_id` - (Optional) The unique ID for the policy definition within the policy set definition that should be remediated. Required when the policy assignment being remediated assigns a policy set definition. (`default = null`)
- `subscription_policy_remediation_location_filters` - (Optional) A list of the resource locations that will be remediated. (`default = null`)
- `subscription_policy_remediation_resource_discovery_mode` - (Optional) The way that resources to remediate are discovered. Possible values are ExistingNonCompliant, ReEvaluateCompliance. Defaults to ExistingNonCompliant. (`default = null`)
- `subscription_policy_remediation_timeouts` - Set timeouts for subscription policy remediation (`default = {}`)
- `enable_management_group_policy_remediation` - Enable management group policy remediation usage (`default = False`)
- `management_group_policy_remediation_name` - The name of the Policy Remediation. Changing this forces a new resource to be created. (`default = ""`)
- `management_group_policy_remediation_management_group_id` - Required) The Management Group ID at which the Policy Remediation should be applied. Changing this forces a new resource to be created. (`default = null`)
- `management_group_policy_remediation_policy_assignment_id` - The ID of the Policy Assignment that should be remediated. (`default = ""`)
- `management_group_policy_remediation_policy_definition_id` - (Optional) The unique ID for the policy definition within the policy set definition that should be remediated. Required when the policy assignment being remediated assigns a policy set definition. (`default = null`)
- `management_group_policy_remediation_location_filters` - (Optional) A list of the resource locations that will be remediated. (`default = null`)
- `management_group_policy_remediation_resource_discovery_mode` - (Optional) The way that resources to remediate are discovered. Possible values are ExistingNonCompliant, ReEvaluateCompliance. Defaults to ExistingNonCompliant. (`default = null`)
- `management_group_policy_remediation_timeouts` - Set timeouts for management group policy remediation (`default = {}`)
- `enable_resource_group_policy_remediation` - Enable resource group policy remediation udage (`default = False`)
- `resource_group_policy_remediation_name` - The name of the Policy Remediation. Changing this forces a new resource to be created. (`default = ""`)
- `resource_group_policy_remediation_resource_group_id` - (Required) The Resource Group ID at which the Policy Remediation should be applied. Changing this forces a new resource to be created. (`default = null`)
- `resource_group_policy_remediation_policy_assignment_id` - The ID of the Policy Assignment that should be remediated. (`default = ""`)
- `resource_group_policy_remediation_policy_definition_id` - (Optional) The unique ID for the policy definition within the policy set definition that should be remediated. Required when the policy assignment being remediated assigns a policy set definition. (`default = null`)
- `resource_group_policy_remediation_location_filters` - (Optional) A list of the resource locations that will be remediated. (`default = null`)
- `resource_group_policy_remediation_resource_discovery_mode` - (Optional) The way that resources to remediate are discovered. Possible values are ExistingNonCompliant, ReEvaluateCompliance. Defaults to ExistingNonCompliant. (`default = null`)
- `resource_group_policy_remediation_timeouts` - Set timeouts for resource group policy remediation (`default = {}`)
- `enable_resource_policy_remediation` - Enable resource policy remediation usage (`default = False`)
- `resource_policy_remediation_name` - The name of the Policy Remediation. Changing this forces a new resource to be created. (`default = ""`)
- `resource_policy_remediation_resource_id` - (Required) The Resource ID at which the Policy Remediation should be applied. Changing this forces a new resource to be created. (`default = null`)
- `resource_policy_remediation_policy_assignment_id` - The ID of the Policy Assignment that should be remediated. (`default = ""`)
- `resource_policy_remediation_policy_definition_id` - (Optional) The unique ID for the policy definition within the policy set definition that should be remediated. Required when the policy assignment being remediated assigns a policy set definition. (`default = null`)
- `resource_policy_remediation_location_filters` - (Optional) A list of the resource locations that will be remediated. (`default = null`)
- `resource_policy_remediation_resource_discovery_mode` - (Optional) The way that resources to remediate are discovered. Possible values are ExistingNonCompliant, ReEvaluateCompliance. Defaults to ExistingNonCompliant. (`default = null`)
- `resource_policy_remediation_timeouts` - Set timeouts for resource policy remediation (`default = {}`)
- `enable_policy_set_definition` - Enable policy set definition usage (`default = False`)
- `policy_set_definition_name` - The name of the policy set definition. Changing this forces a new resource to be created. (`default = ""`)
- `policy_set_definition_policy_type` - (Required) The policy set type. Possible values are BuiltIn or Custom. Changing this forces a new resource to be created. (`default = null`)
- `policy_set_definition_display_name` - (Required) The display name of the policy set definition. (`default = null`)
- `policy_set_definition_description` - (Optional) The description of the policy set definition. (`default = null`)
- `policy_set_definition_management_group_id` - (Optional) The name of the Management Group where this policy set definition should be defined. Changing this forces a new resource to be created. (`default = null`)
- `policy_set_definition_metadata` - (Optional) The metadata for the policy set definition. This is a JSON object representing additional metadata that should be stored with the policy definition. (`default = null`)
- `policy_set_definition_parameters` - (Optional) Parameters for the policy set definition. This field is a JSON object that allows you to parameterize your policy definition. (`default = null`)
- `policy_set_definition_policy_policy_definition_reference` - (Optional) One or more policy_definition_reference blocks (`default = []`)
- `policy_set_definition_policy_definition_group` - (Optional) One or more policy_definition_group blocks (`default = []`)
- `policy_set_definition_timeouts` - Set timeouts for policy set definition (`default = {}`)
- `enable_policy_virtual_machine_configuration_assignment` - Enable policy virtual machine configuration assignment usage (`default = False`)
- `policy_virtual_machine_configuration_assignment_name` - The name of the Guest Configuration that will be assigned in this Guest Configuration Assignment. Changing this forces a new resource to be created. (`default = ""`)
- `policy_virtual_machine_configuration_assignment_location` - (Required) The Azure location where the Policy Virtual Machine Configuration Assignment should exist. Changing this forces a new resource to be created. (`default = null`)
- `policy_virtual_machine_configuration_assignment_virtual_machine_id` - (Required) The resource ID of the Policy Virtual Machine which this Guest Configuration Assignment should apply to. Changing this forces a new resource to be created. (`default = null`)
- `policy_virtual_machine_configuration_assignment_configuration` - (Required) A configuration block (`default = {}`)
- `policy_virtual_machine_configuration_assignment_timeouts` - Set timeouts for policy virtual machine configuration assignment (`default = {}`)

## Module Output Variables
----------------------
- `policy_definition_id` - The ID of the Policy Definition.
- `management_group_policy_assignment_id` - The ID of the Management Group Policy Assignment.
- `subscription_policy_assignment_id` - The ID of the Subscription Policy Assignment.
- `resource_policy_assignment_id` - The ID of the Resource Policy Assignment.
- `resource_group_policy_assignment_id` - The ID of the Resource Group Policy Assignment.
- `resource_group_policy_assignment_identity` - The identity settings of the Resource Group Policy Assignment.
- `subscription_policy_remediation_id` - The ID of the Policy Remediation.
- `management_group_policy_remediation_id` - The ID of the Policy Remediation.
- `resource_group_policy_remediation_id` - The ID of the Policy Remediation.
- `resource_policy_remediation_id` - The ID of the Policy Remediation.
- `resource_policy_remediation_id` - The ID of the Policy Set Definition.
- `policy_virtual_machine_configuration_assignment_id` - The ID of the Policy Virtual Machine Configuration Assignment.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
