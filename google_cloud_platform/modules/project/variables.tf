#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
    description = " The name of the project"
    default     = "project"
}   

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}

variable "billing_account" {
    description = "Billing account"
    default     = ""
}

variable "org_id" {
    description = "Org ID"
    default     = ""
}

variable "enable_specific_folder" {
    description = "Enable specific folder under your organization"
    default     = false
}

variable "project_id" {
    description = "The project ID. Changing this forces a new project to be created."
    default     = ""
}

variable "skip_delete" {
    description = "If true, the Terraform resource can be deleted without deleting the Project via the Google API."
    default     = false
}

variable "auto_create_network" {                                                                                                            
    description = "(Optional) Create the 'default' network automatically. Default true. Note: this might be more accurately described as 'Delete Default Network', since the network is created automatically then deleted before project creation returns, but we choose this name to match the GCP Console UI. Setting this field to false will enable the Compute Engine API which is required to delete the network."
    default     = true
}

variable "google_project_services" {
    description = "The list of services that are enabled. Supports update."
    type        = "list"
    default     = []
}

variable "disable_on_destroy" {
    description = "(Optional) If true, disable the service when the terraform resource is destroyed. Defaults to true. May be useful in the event that a project is long-lived but the infrastructure running in that project changes frequently."
    default     = true 
}
                
variable "enable_organization_iam_policy" {
    description = "Enable add an organization iam policy"
    default     = false
}

variable "enable_organization_iam_member" {
    description = "Enable add an organization iam member"
    default     = false
}

variable "enable_organization_iam_custom_role" {
    description = "Enable add an organization iam custom role"
    default     = false
}

variable "enable_organization_iam_binding" {
    description = "Enable add an organization iam binding"
    default     = false
}


