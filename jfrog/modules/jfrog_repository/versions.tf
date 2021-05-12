terraform {
  required_providers {
    artifactory = {
      source  = "jfrog/artifactory"
      version = "~> 2.2.11"
    }
  }
  required_version = "~> 0.13"
}
