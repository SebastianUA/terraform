# Work with TEMPLATE via terraform

A terraform module for making TEMPLATE.


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


data "azurerm_template_spec_version" "template_spec_version" {
  name                = "myTemplateForTenant"
  resource_group_name = "myResourceGroup"
  version             = "v0.1"
}

module "template" {
  source = "../../modules/template"

  # tenant template deployment
  enable_tenant_template_deployment   = true
  tenant_template_deployment_name     = ""
  tenant_template_deployment_location = "West Europe"
  template_spec_version_id            = data.azurerm_template_spec_version.template_spec_version.id

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = []
}

#---------------------------------------------------------------
# ARM template
#
# http://armviz.io/designer
# https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment
#
#---------------------------------------------------------------
data "template_file" "arm_template" {
  template = file("./additional_files/main.json.tpl")

  vars = {
    test_var_name = "placeholder"
  }
}

module "arm_base_resource_group" {
  source = "git@github.com:SebastianUA/terraform.git//azure/modules/base?ref=dev"

  enable_resource_group   = true
  resource_group_name     = "arm-template-resource-group"
  resource_group_location = "West Europe"

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "arm_template_deployment" {
  source = "../../modules/template"

  enable_tenant_template_deployment              = true
  tenant_template_deployment_name                = "arm-template-deployment"
  tenant_template_deployment_resource_group_name = module.arm_base_resource_group.resource_group_name
  tenant_template_deployment_deployment_mode     = "Incremental"
  tenant_template_deployment_parameters_content = jsonencode({
    "env" = {
      value = "test"
    }
  })

  tenant_template_deployment_template_content = data.template_file.arm_template.rendered

  depends_on = [
    module.arm_base_resource_group,
    data.template_file.arm_template
  ]
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - Add additional tags (`default = {}`)
- `enable_tenant_template_deployment` - Enable tenant template deployment usage (`default = False`)
- `tenant_template_deployment_name` - The name which should be used for this Template. Changing this forces a new Template to be created. (`default = ""`)
- `tenant_template_deployment_location` - (Required) The Azure Region where the Template should exist. Changing this forces a new Template to be created. (`default = null`)
- `tenant_template_deployment_debug_level` - (Optional) The Debug Level which should be used for this Resource Group Template Deployment. Possible values are none, requestContent, responseContent and requestContent, responseContent (`default = null`)
- `tenant_template_deployment_parameters_content` - (Optional) The contents of the ARM Template parameters file - containing a JSON list of parameters. (`default = null`)
- `tenant_template_deployment_template_content` - (Optional) The contents of the ARM Template which should be deployed into this Resource Group. Cannot be specified with template_spec_version_id. (`default = null`)
- `tenant_template_deployment_template_spec_version_id` - (Optional) The ID of the Template Spec Version to deploy. Cannot be specified with template_content (`default = null`)
- `tenant_template_deployment_timeouts` - Set timeouts for tenant template deployment (`default = {}`)
- `enable_template_deployment` - Enable template deployment usage (`default = False`)
- `template_deployment_name` - Specifies the name of the template deployment. Changing this forces a new resource to be created. (`default = ""`)
- `template_deployment_resource_group_name` - (Required) The name of the resource group in which to create the template deployment. (`default = null`)
- `template_deployment_deployment_mode` - Required) Specifies the mode that is used to deploy resources. This value could be either Incremental or Complete. Note that you will almost always want this to be set to Incremental otherwise the deployment will destroy all infrastructure not specified within the template, and Terraform will not be aware of this. (`default = null`)
- `template_deployment_template_body` - (Optional) Specifies the JSON definition for the template. (`default = null`)
- `template_deployment_parameters` - (Optional) Specifies the name and value pairs that define the deployment parameters for the template. (`default = null`)
- `template_deployment_parameters_body` - (Optional) Specifies a valid Azure JSON parameters file that define the deployment parameters. It can contain KeyVault references (`default = null`)
- `template_deployment_timeouts` - Set timeouts for template deployment (`default = {}`)
- `enable_subscription_template_deployment` - Enable subscription template deployment usage (`default = False`)
- `subscription_template_deployment_name` - The name which should be used for this Subscription Template Deployment. Changing this forces a new Subscription Template Deployment to be created. (`default = ""`)
- `subscription_template_deployment_location` - (Required) The Azure Region where the Subscription Template Deployment should exist. Changing this forces a new Subscription Template Deployment to be created. (`default = null`)
- `subscription_template_deployment_debug_level` - (Optional) The Debug Level which should be used for this Subscription Template Deployment. Possible values are none, requestContent, responseContent and requestContent, responseContent. (`default = null`)
- `subscription_template_deployment_template_content` - (Optional) The contents of the ARM Template which should be deployed into this Subscription. (`default = null`)
- `subscription_template_deployment_template_spec_version_id` - (Optional) The ID of the Template Spec Version to deploy into the Subscription. Cannot be specified with template_content (`default = null`)
- `subscription_template_deployment_parameters_content` - (Optional) The contents of the ARM Template parameters file - containing a JSON list of parameters. (`default = null`)
- `subscription_template_deployment_timeouts` - Set timeouts for subscription template deployment (`default = {}`)
- `enable_resource_group_template_deployment` - Enable resource group template deployment usage (`default = False`)
- `resource_group_template_deployment_name` - The name which should be used for this Resource Group Template Deployment. Changing this forces a new Resource Group Template Deployment to be created. (`default = ""`)
- `resource_group_template_deployment_resource_group_name` - (Required) The name of the Resource Group where the Resource Group Template Deployment should exist. Changing this forces a new Resource Group Template Deployment to be created. (`default = null`)
- `resource_group_template_deployment_deployment_mode` - (Required) The Deployment Mode for this Resource Group Template Deployment. Possible values are Complete (where resources in the Resource Group not specified in the ARM Template will be destroyed) and Incremental (where resources are additive only). (`default = null`)
- `resource_group_template_deployment_debug_level` - (Optional) The Debug Level which should be used for this Resource Group Template Deployment. Possible values are none, requestContent, responseContent and requestContent, responseContent. (`default = null`)
- `resource_group_template_deployment_template_content` - (Optional) The contents of the ARM Template which should be deployed into this Resource Group. Cannot be specified with template_spec_version_id. (`default = null`)
- `resource_group_template_deployment_template_spec_version_id` - (Optional) The ID of the Template Spec Version to deploy. Cannot be specified with template_content. (`default = null`)
- `resource_group_template_deployment_parameters_content` - (Optional) The contents of the ARM Template parameters file - containing a JSON list of parameters. (`default = null`)
- `resource_group_template_deployment_timeouts` - Set timeouts for resource group template deployment (`default = {}`)
- `enable_management_group_template_deployment` - Enable management group template deployment usage (`default = False`)
- `management_group_template_deployment_name` - The name which should be used for this Template Deployment. Changing this forces a new Template Deployment to be created. (`default = ""`)
- `management_group_template_deployment_management_group_id` - (Required) The Name of the Management Group to apply the Deployment Template to. (`default = null`)
- `management_group_template_deployment_location` - (Required) The Azure Region where the Template should exist. Changing this forces a new Template to be created. (`default = null`)
- `management_group_template_deployment_debug_level` - (Optional) The Debug Level which should be used for this Resource Group Template Deployment. Possible values are none, requestContent, responseContent and requestContent, responseContent. (`default = null`)
- `management_group_template_deployment_parameters_content` - (Optional) The contents of the ARM Template parameters file - containing a JSON list of parameters. (`default = null`)
- `management_group_template_deployment_template_content` - (Optional) The contents of the ARM Template which should be deployed into this Resource Group. Cannot be specified with template_spec_version_id. (`default = null`)
- `management_group_template_deployment_template_spec_version_id` - (Optional) The ID of the Template Spec Version to deploy. Cannot be specified with template_content (`default = null`)
- `subscription_template_deployment_timeouts` - Set timeouts for subscription template deployment (`default = {}`)

## Module Output Variables
----------------------
- `tenant_template_deployment_id` - The ID of the Tenant Template Deployment.
- `tenant_template_deployment_output_content` - The JSON Content of the Outputs of the ARM Template Deployment.
- `template_deployment_id` - The Template Deployment ID.
- `template_deployment_outputs` - A map of supported scalar output types returned from the deployment (currently, Azure Template Deployment outputs of type String, Int and Bool are supported, and are converted to strings - others will be ignored) and can be accessed using .outputs['name'].
- `subscription_template_deployment_id` - The ID of the Subscription Template Deployment.
- `subscription_template_deployment_output_content` - The JSON Content of the Outputs of the ARM Template Deployment.
- `resource_group_template_deployment_id` - The ID of the Resource Group Template Deployment.
- `resource_group_template_deployment_` - The JSON Content of the Outputs of the ARM Template Deployment.
- `management_group_template_deployment_id` - The ID of the Management Group Template Deployment.
- `management_group_template_deployment_output_content` - The JSON Content of the Outputs of the ARM Template Deployment.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
