#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

# Required for Terraform 0.13 and up (https://www.terraform.io/upgrade-guides/0-13.html)
terraform {

  // required_version = ">= 0.13"

  required_providers {
    jfrog = {
      source  = "jfrog/artifactory"
      version = "2.2.4"
    }
  }
}

variable "artifactory_url" {
  description = "The base URL of the Artifactory deployment"
  type        = string
}
variable "artifactory_username" {
  description = "The username for the Artifactory administrator"
  type        = string
}
variable "artifactory_password" {
  description = "The password for the Artifactory administrator"
  type        = string
}

# Configure the Artifactory provider
provider "artifactory" {
  url = "artifactory.linux-notes.org" # "${var.artifactory_url}"

  username = "captain" # "${var.artifactory_username}"
  password = "captain" # "${var.artifactory_password}"
  # or
  access_token = null
  api_key      = null

}

module "jfrog_local_repository" {
  source = "../../modules/jfrog_repository"

  enable_local_repository       = true
  local_repository_key          = "local-repo-1"
  local_repository_package_type = "npm"
}

module "jfrog_remote_repository" {
  source = "../../modules/jfrog_repository"

  enable_remote_repository       = true
  remote_repository_key          = "remote-repo-1"
  remote_repository_package_type = "npm"
  remote_repository_url          = "https://registry.npmjs.org/"

  remote_repository_repo_layout_ref = "npm-default"
}

module "jfrog_virtual_repository" {
  source = "../../modules/jfrog_repository"

  enable_virtual_repository       = true
  virtual_repository_key          = "virtual-repo-1"
  virtual_repository_package_type = "maven"
  virtual_repository_repositories = []
}