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
